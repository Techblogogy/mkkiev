# coding: utf-8
from __future__ import unicode_literals

from django.utils.feedgenerator import Atom1Feed, Rss201rev2Feed

from articles import feeds
from videogallery.models import VideoGallery


class RssFeed(feeds.RssFeed):
    feed_type = Rss201rev2Feed

    def items(self, obj):
        return VideoGallery.objects.filter(activity=True)[:20]


class AtomFeed(RssFeed):
    feed_type = Atom1Feed
    subtitle = RssFeed.description


class YandexFeed(RssFeed):
    feed_type = feeds.Yandex2Feed

    def item_description(self, item):
        return item.content