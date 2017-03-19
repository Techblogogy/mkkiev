# coding: utf-8
from __future__ import unicode_literals

from django.conf.urls import patterns, include, url


urlpatterns = patterns('pages.views',
    url(r'^(?P<url>(:?[\w/-]+/)?)$', 'page'),
)