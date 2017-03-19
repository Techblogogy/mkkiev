# coding: utf-8
from __future__ import unicode_literals

from django.shortcuts import get_object_or_404
from django.utils.feedgenerator import Atom1Feed

from registration.models import User
from blogs.models import Blog
from articles import feeds


class RssFeed(feeds.RssFeed):
    def get_object(self, request, *args, **kwargs):
        if 'author' in kwargs:
            return get_object_or_404(User, username=kwargs['author'])

    def items(self, obj):
        queryset = Blog.objects.filter(activity=True)
        if obj:
            queryset = queryset.filter(author=obj)
        return queryset[:20]


class AtomFeed(RssFeed):
    feed_type = Atom1Feed
    subtitle = RssFeed.description


class YandexFeed(RssFeed):
    feed_type = feeds.Yandex2Feed

    def item_description(self, item):
        return item.content
