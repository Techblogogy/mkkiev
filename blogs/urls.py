# coding: utf-8
from __future__ import unicode_literals

from django.conf.urls import url, include

from articles.urls import main_patterns, feed_patterns
from blogs.views import AuthorListView
from common.urls import inherit

main_patterns = inherit('blogs.views', main_patterns)
feed_patterns = inherit('blogs.feeds', feed_patterns, False)

urlpatterns = [
    url(r'^', include(feed_patterns)),
    url(r'^', include(main_patterns)),
    url(r'^authors/', AuthorListView.as_view()),
    url(r'^(?P<author>[\w-]+)/', include(main_patterns, 'author')),
    url(r'^(?P<author>[\w-]+)/', include(feed_patterns)),
]
