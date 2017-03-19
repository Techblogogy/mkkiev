# coding: utf-8
from __future__ import unicode_literals

from django.conf.urls import include, url

from articles import views, feeds

main_patterns = [
    url(r'^(?P<slug_date>\d{4}/\d{2}/\d{2})/(?P<slug>[\w-]+)\.html$', views.DetailView.as_view(), name='detail'),
    url(r'^(?P<year>\d{4})/(?P<month>\d{2})/(?P<day>\d{2})/$', views.DayArchiveView.as_view(), name='day_list'),
    url(r'^(?P<year>\d{4})/week/(?P<week>\d+)/$', views.WeekArchiveView.as_view(), name='week_list'),
    url(r'^(?P<year>\d{4})/(?P<month>\d{2})/$', views.MonthArchiveView.as_view(), name='month_list'),
    url(r'^(?P<year>\d{4})/$', views.YearArchiveView.as_view(), name='year_list'),
    url(r'^$', views.ListView.as_view(), name='list'),
]

feed_patterns = [
    url(r'^rss/yandex/$', feeds.YandexFeed(), name='yandex'),
    url(r'^rss/$', feeds.RssFeed(), name='rss'),
    url(r'^atom/$', feeds.AtomFeed(), name='atom'),
]

archive_patterns = [
    url(r'^(?P<year>\d{4})/$', views.ArchiveView.as_view(), name="list"),
    url(r'^$', views.ArchiveView.as_view(), name="index"),
]

urlpatterns = [
    url(r'^(?P<category_slug>[\w-]+)/(?P<id>\d+)-[^/]+\.html$', views.DetailViewOld.as_view()),
    url(r'^(?P<category_slug>[\w-]+)/', include(main_patterns, 'category')),
]