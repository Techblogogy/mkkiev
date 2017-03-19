# coding: utf-8
from __future__ import unicode_literals

import os

from django.contrib.syndication.views import Feed
from django.shortcuts import get_object_or_404
from django.utils.feedgenerator import Rss201rev2Feed, Atom1Feed, rfc2822_date
from django.conf import settings

from articles.models import Article, Category
from common.templatetags.common import do_newscut as newscut
from common.templatetags.image import do_thumb


class RssFeed(Feed):
    feed_type = Rss201rev2Feed
    title = settings.RSS_NEWS['title']
    link = settings.RSS_NEWS['link']
    description = settings.RSS_NEWS['description']

    def get_object(self, request, *args, **kwargs):
        if 'category_slug' in kwargs:
            return get_object_or_404(Category, slug=kwargs['category_slug'], activity=True)

    def items(self, obj):
        queryset = Article.objects.filter(activity=True)
        if obj:
            queryset = queryset.filter(category=obj)
        return queryset[:20]

    def item_title(self, item):
        return item.title
    
    def item_pubdate(self, item):
        return item.pub_date

    def item_description(self, item):
        try:
            img = '<img align="left" hspace="5" width="143" height="90" src="%s" alt=""/>' % do_thumb(item.image, '1')
        except ValueError:
            img = ''
        return newscut(img + item.content, 300)
    
    def item_link(self, item):
        return os.path.join(self.link, item.get_absolute_url())

    def item_author_name(self, item):
        try:
            author = '%s %s' % (item.author.first_name, item.author.last_name)
            author = author.strip()
            if not author:
                return item.author.username
        except AttributeError:
            pass

    def item_categories(self, item):
        return item.category.name,

    def item_enclosure_url(self, item):
        try:
            return item.image.url
        except ValueError:
            pass

    def item_enclosure_mime_type(self, item):
        try:
            ext = os.path.splitext(item.image.path)[1]
        except ValueError:
            return None
        else:
            ext = ext[1:].lower()
        if ext in ('jpeg', 'jpg'):
            return 'image/jpeg'
        elif ext == 'gif':
            return 'image/gif'
        elif ext == 'png':
            return 'image/png'

    def item_enclosure_length(self, item):
        try:
            return os.path.getsize(item.image.path)
        except OSError:
            return None

    def item_extra_kwargs(self, item):
        kwargs = super(RssFeed, self).item_extra_kwargs(item)
        kwargs.update({'caption': item.caption.replace('|', ','), 'video': item.video})
        return kwargs


class AtomFeed(RssFeed):
    feed_type = Atom1Feed
    subtitle = RssFeed.description


class Yandex2Feed(Rss201rev2Feed):

    def add_root_elements(self, handler):
        handler.addQuickElement('title', settings.RSS_NEWS['title'])
        handler.addQuickElement('link', settings.RSS_NEWS['link'])
        handler.addQuickElement("description", self.feed['description'])
        if self.feed['language'] is not None:
            handler.addQuickElement("language", self.feed['language'])
        for cat in self.feed['categories']:
            handler.addQuickElement("category", cat)
        if self.feed['feed_copyright'] is not None:
            handler.addQuickElement("copyright", self.feed['feed_copyright'])
        handler.addQuickElement("lastBuildDate", rfc2822_date(self.latest_post_date()))
        if self.feed['ttl'] is not None:
            handler.addQuickElement("ttl", self.feed['ttl'])
        handler.startElement('image', {})
        handler.addQuickElement('url', settings.RSS_NEWS['image'])
        handler.endElement('image')

    def add_item_elements(self, handler, item):
        fulltext = item['description']
        item['description'] = newscut(fulltext, 300)
        super(Yandex2Feed, self).add_item_elements(handler, item)
        handler.addQuickElement('yandex:full-text', fulltext.replace('<!--more-->', ''))
        handler.addQuickElement('yandex:caption', item.get('caption', ''))
        handler.addQuickElement('yandex:video', '', {'url': item.get('video', ''), 'length': '', 'type': 'video/x-flv'})

    def rss_attributes(self):
        return {
            'xmlns:yandex': 'http://news.yandex.ru',
            'xmlns:media': 'http://search.yahoo.com/mrss/',
            'version': '2.0',
        }


class YandexFeed(RssFeed):
    feed_type = Yandex2Feed

    def item_description(self, item):
        return item.content
