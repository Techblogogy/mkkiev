# coding: utf-8
from __future__ import unicode_literals

import json
import codecs
import urllib2

from django.core.management.base import BaseCommand, CommandError
from django.utils import timezone
from django.utils.translation import ugettext as _


class Command(BaseCommand):

    help = 'Fetch weather from wunderground.com'
    can_import_settings = True

    def handle(self, *args, **options):
        output = []

        time_now = timezone.now().strftime("%Y-%m-%d %H:%M")

        object_list = []

        city_list = (
            (_('Киев'), 'UKKK'),
            (_('Москва'), 'UUEE'),
            (_('С.Петербург'), 'ULLI')
        )

        api_key = '4a3041301633023b'
        path = 'http://api.wunderground.com/api/%s/conditions/q/%s.json'
        for city, query in city_list:
            try:
                f = urllib2.urlopen(path % (api_key, query), None, 1)
                json_string = f.read()
                parsed_json = json.loads(json_string)
            except Exception, e:
                raise CommandError('%s Can not get weather from wunderground.com: %s' % (time_now, e))
            finally:
                f.close()

            try:
                temp_c = int(round(parsed_json['current_observation']['temp_c']))
                icon_url = parsed_json['current_observation']['icon_url']
                object_list.append({'city': city, 'temp_c': temp_c, 'icon_url': icon_url})
            except KeyError:
                desc = parsed_json['response']['error']['description']
                raise CommandError('%s Can not parse json data: %s' % (time_now, desc))

        try:
            path = '/var/www/mkkiev/common/templatetags/weather.json'
            with codecs.open(path, 'w', 'utf-8') as f:
                f.write(json.dumps(object_list))
        except IOError, e:
            raise CommandError('%s Error writing json data file: %s' % (time_now, e))

        output.append('%s Successfully get weather from wunderground.com\n' % time_now)

        return '\n'.join(output)
