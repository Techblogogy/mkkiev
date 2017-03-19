# coding: utf-8
from __future__ import unicode_literals

import os
import xml.etree.ElementTree as ET

from django.db.models import F
from django.http import HttpResponse

from banners.models import Banner


def banner_click(request, id):
    Banner.objects.filter(pk=id).update(clicks=F('clicks') + 1)
    return HttpResponse()


def android_xml(request):
    root = ET.Element('advertisement')
    for obj in Banner.objects.filter(activity=True, category__slug='android-application'):
        item = ET.SubElement(root, 'item')
        link = ET.SubElement(item, 'link')
        link.text = obj.url
        if obj.file:
            ext = os.path.splitext(obj.file.name)[1].lstrip('.').lower()
            if ext == 'swf':
                file_type = 'application/x-shockwave-flash'
            else:
                file_type = 'image/%s' % ext.replace('jpg', 'jpeg')
            item = ET.SubElement(item, 'enclosure', {'url': obj.file.url, 'length': str(obj.file.size), 'type': file_type})
            item.text = ''
        else:
            item = ET.SubElement(item, 'enclosure', {'url': '', 'length': '', 'tyoe': 'plain/txt'})
            item.text = obj.code
    xml = '<?xml version="1.0" encoding="utf-8"?>' + ET.tostring(root)
    return HttpResponse(xml, content_type='text/xml')