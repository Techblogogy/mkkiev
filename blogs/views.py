# coding: utf-8
from __future__ import unicode_literals

from django.db.models import Count
from django.shortcuts import get_object_or_404

from articles.models import Category
from articles import views
from blogs.models import Blog, Author


class DetailView(views.DetailView):
    template_name = 'blogs/detail.html'

    def get_context_data(self, **kwargs):
        context = super(DetailView, self).get_context_data(**kwargs)
        context['author_articles_list'] = self.object.author.author_articles.exclude(id=self.object.id)
        return context


class BaseListView(views.BaseListView):
    model = Blog
    category = Category.objects.get(slug='blog')
    template_name = 'blogs/list.html'

    def get_queryset(self):
        queryset = super(BaseListView, self).get_queryset()
        if 'author' in self.kwargs:
            self.author = get_object_or_404(Author, username=self.kwargs['author'])
            queryset = queryset.filter(author=self.author)
        return queryset


class DayArchiveView(views.DayArchiveView, BaseListView):
    template_name = 'blogs/list.html'


class WeekArchiveView(views.WeekArchiveView, BaseListView):
    template_name = 'blogs/list.html'


class MonthArchiveView(views.MonthArchiveView, BaseListView):
    template_name = 'blogs/list.html'


class YearArchiveView(views.YearArchiveView, BaseListView):
    template_name = 'blogs/list.html'


class ListView(BaseListView, views.ListView):
    pass


class AuthorListView(views.ListView):
    template_name = 'blogs/authors.html'

    def get_queryset(self):
        queryset = Author.objects.annotate(article_count=Count('author_articles'))
        return queryset.filter(article_count__gt=0)
