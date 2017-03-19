# coding: utf-8
from __future__ import unicode_literals

from django.conf.urls import url, include

from common.urls import inherit
from photogallery.views import DetailViewOld
from articles.urls import main_patterns, feed_patterns

main_patterns = inherit('photogallery.views', main_patterns)
feed_patterns = inherit('photogallery.feeds', feed_patterns, False)

urlpatterns = [
    url(r'^[\w-]+/(?P<id>\d+)-[^/]+\.html$', DetailViewOld.as_view()),
    url(r'^', include(main_patterns)),
    url(r'^', include(feed_patterns)),
]