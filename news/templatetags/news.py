# coding: utf-8
from __future__ import unicode_literals

from django import template
from django.utils.translation import ugettext_lazy as _

from ..models import News, NewsCategory

register = template.Library()


@register.inclusion_tag('news/templatetags/main.html')
def show_news(slug=None, count=3):
    category = NewsCategory(slug='news', name=_('Все новости'))
    queryset = News.objects.filter(activity=True).select_related('category')
    if slug[:1] == '-':  # exclude by pattern '-blog'
        queryset = queryset.exclude(category__slug=slug[1:])
    elif slug is not None:
        category = NewsCategory.objects.get(slug=slug)
        queryset = queryset.filter(category=category)
    return {'object_list': queryset[:count], 'category': category}
