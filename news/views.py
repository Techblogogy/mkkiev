# coding: utf-8
from __future__ import unicode_literals

from django.utils.translation import ugettext as _

from articles import views
from news.models import NewsCategory, News


class DetailView(views.DetailView):
    template_name = 'news/detail.html'


class BaseListView(views.BaseListView):
    model = News
    category = NewsCategory(slug='news', name=_('Все новости'))
    template_name = 'news/list.html'


class DayArchiveView(views.DayArchiveView, BaseListView):
    template_name = 'news/list.html'


class WeekArchiveView(views.WeekArchiveView, BaseListView):
    template_name = 'news/list.html'


class MonthArchiveView(views.MonthArchiveView, BaseListView):
    template_name = 'news/list.html'


class YearArchiveView(views.YearArchiveView, BaseListView):
    template_name = 'news/list.html'


class ListView(BaseListView, views.ListView):
    pass
