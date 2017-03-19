# coding: utf-8
from __future__ import unicode_literals

import os
import datetime

import gdata.gauth
import gdata.analytics.client

from django.core.mail import mail_admins
from django.core.management.base import BaseCommand, CommandError
from django.conf import settings
from django.utils import timezone


class Command(BaseCommand):
    help = 'Fetch Google Analytics data'

    def add_arguments(self, parser):
        parser.add_argument('--oauth', action='store_true', help='Generate an access token for OAuth')

    def handle(self, *args, **options):
        output = []
        time_now = timezone.now().strftime("%Y-%m-%d %H:%M")
        self.stdout.write('%s Getting Google Analytics data...\n' % time_now)
        # Authorize to Google OAuth 2.0
        try:
            client_id = settings.GOOGLE_OAUTH_CLIENT_ID
            client_secret = settings.GOOGLE_OAUTH_CLIENT_SECRET
            user_agent = settings.GOOGLE_OAUTH_USER_AGENT
            table_id = settings.GOOGLE_ANALYTICS_TABLE_ID
            scope = 'https://www.google.com/analytics/feeds/'  # Default scope for analytics
        except AttributeError:
            raise CommandError('%s Please set GOOGLE_OAUTH_CLIENT_ID and '
                               'GOOGLE_OAUTH_CLIENT_SECRET and '
                               'GOOGLE_OAUTH_USER_AGENT and '
                               'GOOGLE_ANALYTICS_TABLE_ID '
                               'in settings.py' % time_now)
        filename = os.path.join(settings.BASE_DIR, '.googleoathtoken')
        if options['oauth']:
            token = gdata.gauth.OAuth2Token(client_id=client_id, client_secret=client_secret, scope=scope, user_agent=user_agent)
            url = token.generate_authorize_url(redirect_uri='urn:ietf:wg:oauth:2.0:oob')
            self.stdout.write('Please follow this url and put code here:')
            self.stdout.write(url)
            code = raw_input('--> ')
            token.get_access_token(code)
            with open(filename, 'w') as f:
                f.write(gdata.gauth.token_to_blob(token))
        try:
            with open(filename) as f:
                token = gdata.gauth.token_from_blob(f.read())
        except (IOError, gdata.gauth.UnsupportedTokenType):
            mail_admins('Please generate an access token for OAuth', 'python manage.py fetchgoogleanalytics --oauth')
            raise CommandError('%s Please generate an access token for OAuth' % time_now)
        # Query to Google Analytics
        client = gdata.analytics.client.AnalyticsClient()
        token.authorize(client)
        start_index = 1
        max_result = 10000
        updated = 0
        from articles.models import Article
        while True:
            data_query = gdata.analytics.client.DataFeedQuery({
                'ids': 'ga:%s' % table_id,
                'dimensions': 'ga:pagePath',
                'metrics': 'ga:pageviews',
                'filters': 'ga:pagePath=~\d{4}/\d{2}/\d{2}/[\w-]+.html$',
                'sort': '-ga:pagePath',
                'start-date': '2005-01-01',  # Google Analytics start day
                'end-date': timezone.now().strftime("%Y-%m-%d"),
                'start-index': start_index,
                'max-results': max_result,
            })
            feed = client.GetDataFeed(data_query)
            if not feed.entry:
                break
            for entry in feed.entry:
                path = entry.dimension[0].value
                pageviews = int(entry.metric[0].value)
                try:
                    _, year, month, day, slug = path.lstrip('/')[:-5].rsplit('/', 4)
                    if pageviews > 0:
                        slug_date = datetime.date(int(year), int(month), int(day))
                        updated += Article.objects.filter(slug_date=slug_date, slug=slug, pageviews__lt=pageviews).update(pageviews=pageviews)
                except (TypeError, ValueError):
                    pass
            start_index += max_result
        self.stdout.write('%s Successfully get Google Analytics data... (updated %s)\n' % (time_now, updated))
        return '\n'.join(output)