# coding: utf-8
from __future__ import unicode_literals
from importlib import import_module

from django.conf.urls import url
from django.contrib.sitemaps import views as sitemaps_views
from django.contrib.flatpages.sitemaps import FlatPageSitemap
from django.contrib.sitemaps import GenericSitemap
from django.core.urlresolvers import RegexURLPattern

from articles.models import Category, Article
from common.views import json_article_detail, sidebar_feed


def inherit(mod_name, patterns, cbv=True):
    """
    Inherit class based view class or feed class
    """
    pattern_list = []
    for t in patterns:
        class_name = t.callback.__name__ if cbv else t.callback.__class__.__name__
        callback = getattr(import_module(mod_name), class_name)
        callback = callback.as_view() if cbv else callback()
        pattern_list.append(RegexURLPattern(t._regex, callback, t.default_args, t.name))
    return pattern_list


sitemaps ={'flatpages': FlatPageSitemap}
for category in Category.objects.filter(activity=True):
    try:
        queryset = Article.objects.filter(category=category, activity=True)
    except Article.DoesNotExist:
        pass
    else:
        sitemaps[category.slug] = GenericSitemap({'queryset': queryset, 'date_field': 'pub_date'}, priority=0.6, changefreq='always')

urlpatterns = [
    url(r'^sitemap.xml$', sitemaps_views.index, {'sitemaps': sitemaps, 'sitemap_url_name': 'sitemaps'}),
    url(r'^sitemap-(?P<section>.+)\.xml$', sitemaps_views.sitemap, {'sitemaps': sitemaps}, name='sitemaps'),
    url(r'^json/article/detail/(?P<id>\d+)/$', json_article_detail),
    url(r'^sidebar.json$', sidebar_feed),
]