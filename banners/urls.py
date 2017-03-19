# coding: utf-8
from __future__ import unicode_literals

from django.conf.urls import url
from banners.views import banner_click, android_xml

urlpatterns = [
    url(r'^click/banner-(?P<id>[\d]+)/$', banner_click),
    url(r'^xml/$', android_xml),
]
