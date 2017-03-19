# coding: utf-8
from __future__ import unicode_literals

from django.utils.feedgenerator import Atom1Feed

from articles import feeds
from photogallery.models import PhotoGallery


class RssFeed(feeds.RssFeed):
    def items(self, obj):
        return PhotoGallery.objects.filter(activity=True)[:20]


class AtomFeed(feeds.RssFeed):
    feed_type = Atom1Feed
    subtitle = RssFeed.description


class YandexFeed(feeds.RssFeed):
    feed_type = feeds.Yandex2Feed

    def item_description(self, item):
        return item.content