# coding: utf-8
from __future__ import unicode_literals

from django.utils.translation import ugettext as _

from articles import views
from articles.models import Category
from photogallery.models import Image, PhotoGallery


class DetailView(views.DetailView):
    template_name = 'photogallery/detail.html'

    def get_context_data(self, **kwargs):
        context = super(DetailView, self).get_context_data(**kwargs)
        context['image_list'] = Image.objects.filter(article=self.object, activity=True)
        return context


class DetailViewOld(DetailView):
    pass


class BaseListView(views.BaseListView):
    model = PhotoGallery
    category = Category(slug='photogallery', name=_('Фотогалерея'))
    template_name = 'photogallery/list.html'
    paginate_by = 20


class DayArchiveView(views.DayArchiveView, BaseListView):
    template_name = 'photogallery/list.html'


class WeekArchiveView(views.WeekArchiveView, BaseListView):
    template_name = 'photogallery/list.html'


class MonthArchiveView(views.MonthArchiveView, BaseListView):
    template_name = 'photogallery/list.html'


class YearArchiveView(views.YearArchiveView, BaseListView):
    template_name = 'photogallery/list.html'


class ListView(BaseListView, views.ListView):
    pass