# coding: utf-8
from __future__ import unicode_literals

from django.conf.urls import include, url

from articles.urls import main_patterns, feed_patterns
from common.urls import inherit

main_patterns = inherit('news.views', main_patterns)
feed_patterns = inherit('news.feeds', feed_patterns, False)

urlpatterns = [
    url(r'^news/', include(main_patterns)),
    url(r'^news/', include(feed_patterns)),
    url(r'^(?P<category_slug>[\w-]+)/', include(main_patterns, 'category')),
    url(r'^(?P<category_slug>[\w-]+)/', include(feed_patterns)),
]