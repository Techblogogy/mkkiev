# coding: utf-8
from __future__ import unicode_literals

from django.utils.translation import ugettext as _

from articles.models import Category
from articles import views
from videogallery.models import VideoGallery


class DetailView(views.DetailView):
    template_name = 'videogallery/detail.html'


class BaseListView(views.BaseListView):
    model = VideoGallery
    category = Category(slug='videogallery', name=_('Видеогалерея'))
    template_name = 'videogallery/list.html'
    paginate_by = 20


class DayArchiveView(views.DayArchiveView, BaseListView):
    template_name = 'videogallery/list.html'


class WeekArchiveView(views.WeekArchiveView, BaseListView):
    template_name = 'videogallery/list.html'


class MonthArchiveView(views.MonthArchiveView, BaseListView):
    template_name = 'videogallery/list.html'


class YearArchiveView(views.YearArchiveView, BaseListView):
    template_name = 'videogallery/list.html'


class ListView(BaseListView, views.ListView):
    pass
