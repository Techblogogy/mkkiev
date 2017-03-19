# coding: utf-8
from __future__ import unicode_literals

import calendar
import datetime

from django.db.models import Q
from django.views import generic
from django.shortcuts import get_object_or_404
from django.utils.translation import ugettext as _
from django.views.generic import TemplateView

from articles.models import Article, Category, Tag


class DetailView(generic.DetailView):
    template_name = 'articles/detail.html'

    def get_context_data(self, **kwargs):
        context = super(DetailView, self).get_context_data(**kwargs)
        context['tags_list'] = self.object.tags.filter(activity=True)
        context['related_list'] = self.object.related.filter(activity=True)
        queryset = Article.objects.exclude(id=self.object.id).filter(category=self.object.category, activity=True)
        if context['tags_list']:
            queryset = queryset.filter(tags__in=context['tags_list']).distinct()
        context['similiar_list'] = queryset[:5]
        return context

    def get_object(self, queryset=None):
        date = self.kwargs.get('slug_date').replace('/', '-')
        slug = self.kwargs.get('slug')
        return get_object_or_404(Article, Q(activity=True) | Q(show=True), slug_date=date, slug=slug)


class DetailViewOld(DetailView):
    def get_context_data(self, **kwargs):
        context = super(DetailViewOld, self).get_context_data(**kwargs)
        context['noindex'] = True
        return context

    def get_object(self, queryset=None):
        return get_object_or_404(Article, id=self.kwargs['id'], activity=True)


class BaseListView(generic.list.BaseListView):
    model = Article
    category = Category(slug='news', name=_('Все статьи'))
    tag = None
    template_name = 'articles/list.html'
    paginate_by = 20

    def get_queryset(self):
        queryset = super(BaseListView, self).get_queryset()
        queryset = queryset.filter(activity=True).prefetch_related('category')
        if 'category_slug' in self.kwargs and self.kwargs['category_slug'] not in ('news', 'articles'):
            self.category = get_object_or_404(Category, slug=self.kwargs['category_slug'], activity=True)
            queryset = queryset.filter(category=self.category)
        if 'tag' in self.request.GET:
            tag_list = self.request.GET['tag']
            self.tag = Tag.objects.filter(slug__in=tag_list.split(), activity=True)
            queryset = queryset.filter(tags__in=self.tag)
            if 'popular' in tag_list:  # popular tag for popular news
                queryset = queryset.order_by('-pageviews')
        return queryset


class DayArchiveView(generic.DayArchiveView, BaseListView):
    template_name = 'articles/list.html'
    date_field = 'pub_date'
    month_format = '%m'


class WeekArchiveView(generic.WeekArchiveView, BaseListView):
    template_name = 'articles/list.html'
    date_field = "pub_date"
    week_format = "%W"
    make_object_list = True
    allow_future = True


class MonthArchiveView(generic.MonthArchiveView, BaseListView):
    template_name = 'articles/list.html'
    date_field = 'pub_date'
    month_format = '%m'


class YearArchiveView(generic.YearArchiveView, BaseListView):
    template_name = 'articles/list.html'
    date_field = 'pub_date'
    make_object_list = True


class ListView(BaseListView, generic.ListView):
    pass


class ArchiveView(TemplateView):
    template_name = "articles/archive.html"

    def get_context_data(self, **kwargs):
        context = super(ArchiveView, self).get_context_data(**kwargs)
        # Get all unique dates from articles
        dates = Article.objects.values_list('slug_date', flat=True).order_by('slug_date').distinct()
        # Get unique years
        years = []
        for date in dates:
            year = date.year
            if year not in years:
                years.append(year)
        context['years'] = years
        # Filter calendar
        today = datetime.date.today()
        try:
            year = int(self.kwargs['year'])
            if year not in years:
                year = today.year
        except (KeyError, ValueError):
            year = today.year
        context['current_year'] = year
        current = True
        switch = False
        calendar_list = []
        for row in calendar.Calendar().yeardatescalendar(year, 2):
            rows = []
            for month in row:
                months = []
                first = True
                for week in month:
                    weeks = []
                    for date in week:
                        if date > today:
                            current = False
                        if date.day == 1 and not first:
                            switch = not switch
                        if not switch:
                            date = False
                        show_date = date in dates and current
                        weeks.append((show_date, date))
                        first = False
                    months.append(weeks)
                rows.append(months)
            if current:
                calendar_list.append(rows)
        context['calendar'] = calendar_list
        context['week_list'] = [datetime.date(year=2012, month=1, day=day) for day in range(2, 9)]
        return context
