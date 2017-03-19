# coding: utf-8
from __future__ import unicode_literals

from django.conf.urls import url, include

from articles.urls import main_patterns, feed_patterns
from common.urls import inherit

main_patterns = inherit('videogallery.views', main_patterns)
feed_patterns = inherit('videogallery.feeds', feed_patterns, False)

urlpatterns = [
    url(r'^', include(main_patterns)),
    url(r'^', include(feed_patterns)),
]