# coding: utf-8
from __future__ import unicode_literals

import re
import json
import codecs
import urllib2
import os

from django.core.management.base import BaseCommand, CommandError
from django.utils import timezone
from djangoapp.settings import BASE_DIR



class Command(BaseCommand):

    help = 'Fetch currency from cbr.ru'
    can_import_settings = True

    def handle(self, *args, **options):
        output = []

        time_now = timezone.now().strftime("%Y-%m-%d %H:%M")

        show = ('UAH', 'USD', 'EUR')

        object_list = []
        try:
            f = urllib2.urlopen('http://api.privatbank.ua/p24api/pubinfo?json&exchange&coursid=5', None, .5)
            # xml_string = f.read().decode('CP1251')
            json_data = json.loads(f.read())
            print json_data

            f.close()
        except Exception, e:
            CommandError('%s Can not connect to cbr.ru: %s' % (time_now, e))
        else:
            # date = re.search(r'Date="(.*?)"', xml_string).group(1)
            # valute_c = re.compile(r'<Valute.*?>(.*?)</Valute>', re.S)
            # code_c = re.compile(r'<CharCode>(.*?)<', re.S)
            # nominal_c = re.compile(r'<Nominal>(.*?)<', re.S)
            # name_c = re.compile(r'<Name>(.*?)<', re.S)
            # value_c = re.compile(r'<Value>(.*?)<', re.S)
            # for valute in valute_c.finditer(xml_string):
            #     valute = valute.group(1)
            #     code = code_c.search(valute)
            #     nominal = nominal_c.search(valute)
            #     name = name_c.search(valute)
            #     value = value_c.search(valute)
            #     if code and nominal and name and value:
            #         code, nominal, name, value = code.group(1), nominal.group(1), name.group(1), value.group(1)
            #         if code in show:
            #             object_list.append({
            #                 'date': date,
            #                 'code': code,
            #                 'nominal': nominal,
            #                 'name': name,
            #                 'value': value
            #             })

            for j in json_data:
                object_list.append({
                    'date': "",
                    'code': j['ccy'],
                    'nominal': 1,
                    'name': "",
                    'value': j['buy'] 
                })

        print object_list

        if object_list:
            # uah = .0
            # for obj in object_list:
            #     if obj['code'] == 'UAH':
            #         uah = float(obj['value'].replace(',', '.'))
            # object_list.append({
            #     'date': object_list[0]['date'],
            #     'code': 'RUB',
            #     'nominal': '1',
            #     'name': 'Российский Рубль',
            #     'value': '1'
            # })
            # for obj in object_list:
            #     if obj['code'] != 'UAH':
            #         obj['value'] = str(round(float(obj['value'].replace(',', '.'))*100/uah, 4)).replace('.', ',')
            # temp = []
            # for obj in object_list:
            #     print obj
            #     if obj['code'] != 'UAH':
            #         temp.append(obj)
            # object_list = temp
            try:
                # path = '/var/www/mkkiev/common/templatetags/currency.json'
                path = os.path.join(BASE_DIR, "common", "templatetags", "currency.json")
                with codecs.open(path, 'w', 'utf-8') as f:
                    f.write(json.dumps(object_list))
            except IOError, e:
                raise CommandError('%s Error writing json data file: %s' % (time_now, e))

        output.append('%s Successfully get currencies from cbr.ru' % time_now)
        return '\n'.join(output)
