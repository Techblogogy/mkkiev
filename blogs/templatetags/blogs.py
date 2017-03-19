# coding: utf-8
from __future__ import unicode_literals

from django.template import Library

from articles.models import Category
from ..models import Blog


register = Library()


@register.inclusion_tag('blogs/templatetags/main.html')
def show_blogs():
    return {'object_list': Blog.objects.filter(activity=True).select_related('author')[:3],
            'category': Category.objects.get(slug='blog')}


@register.inclusion_tag('blogs/templatetags/sidebar.html')
def show_sidebar_blogs(count=5):
    return {'object_list': Blog.objects.filter(activity=True).select_related('author')[:count],
            'category': Category.objects.get(slug='blog')}
