# coding: utf-8
from __future__ import unicode_literals

from django.utils.feedgenerator import Atom1Feed

from articles import feeds
from news.models import News


class RssFeed(feeds.RssFeed):
    def items(self, obj):
        queryset = News.objects.filter(activity=True)
        if obj:
            queryset = queryset.filter(category=obj)
        return queryset[:20]


class AtomFeed(RssFeed):
    feed_type = Atom1Feed
    subtitle = RssFeed.description


class YandexFeed(RssFeed):
    feed_type = feeds.Yandex2Feed

    def item_description(self, item):
        return item.content