# coding: utf-8
from __future__ import unicode_literals

import hmac
import base64
from datetime import timedelta
from hashlib import sha1

from django.core.management.base import BaseCommand, CommandError
from django.core.urlresolvers import reverse
from django.core import mail
from django.template.loader import get_template
from django.template import Context, Template, TemplateDoesNotExist
from django.contrib.syndication.views import add_domain
from django.conf import settings
# from django.contrib.sites.models import Site
from django.utils import timezone
from django.utils.translation import ugettext as _

from subscribes.models import Subscribe
from articles.models import Article


class Command(BaseCommand):

    help = 'Send mail to subscribers'
    can_import_settings = True

    def handle(self, *args, **options):
        output = []

        time_now = timezone.now().strftime("%Y-%m-%d %H:%M")

        subject = getattr(settings, 'SUBSCRIBES_SUBJECT', _('«МК-Киев». Выбор редактора'))
        from_email_name = getattr(settings, 'SUBSCRIBES_FROM_EMAIL_NAME', 'no-reply')
        pretty_from_email_name = getattr(settings, 'SUBSCRIBES_PRETTY_FROM_EMAIL_NAME', 'МК-Киев')

        previous_day = timezone.now() - timedelta(days=1)
        try:
            articles = Article.objects.select_related().filter(activity=True, pub_date__gte=previous_day).order_by('-pub_date')
        except Article.DoesNotExist:
            raise CommandError('%s Articles does not exist' % time_now)

        # current_site = Site.objects.get_current()
        # domain = add_domain(current_site.domain, '', False)
        domain = "http://127.0.0.1:8000/"
        pretty_domain = domain.replace('http://', '').replace('https://', '').replace('//', '').replace('www', '')
        #
        from_email = '%s <%s@%s>' % (pretty_from_email_name, from_email_name, pretty_domain)
        # print from_email
        from_email = "fedorbobylev@fabricator.me"

        c = Context({
            'article_list': articles,
            'subject': subject,
            'domain': domain,
            'pretty_domain': pretty_domain
        })

        messages = []
        for template_name in ('subscribes/email.txt', 'subscribes/email.html'):
            try:
                t = get_template(template_name)
            except TemplateDoesNotExist:
                raise CommandError('%s Template "%s" does not exist' % (template_name, time_now))

            # unsubscribe link in %(unsubscribe_link)s
            messages.append(t.render(c))

        try:
            # recipient_list = Subscribe.objects.filter(activity=True, site=settings.SITE_ID).values_list('email', flat=True).order_by('?')
            recipient_list = Subscribe.objects.filter(activity=True).values_list('email', flat=True).order_by('?')
        except Subscribe.DoesNotExist:
            raise CommandError('%s Subscribes does not exist' % time_now)

        def gen_emails():
            for email in recipient_list:
                token = base64.encodestring(hmac.new(settings.SECRET_KEY, email, sha1).digest()).rstrip()
                unsubscribe_link = '%s%s?t=%s&e=%s&d=1' % (domain, reverse('subscribes-index'), token, email)
                c = Context({'unsubscribe_link': unsubscribe_link})
                t = Template(messages[0])
                text_message = t.render(c)
                t = Template(messages[1])
                html_message = t.render(c)
                msg = mail.EmailMultiAlternatives(subject, text_message, from_email, [email])
                msg.attach_alternative(html_message, 'text/html')
                yield msg

        connection = mail.get_connection(fail_silently=True)

        try:
            connection.send_messages(gen_emails())
        except SMTPException:
            raise

        output.append('%s Successfully sends mails to subscribes\n' % time_now)
        return '\n'.join(output)
