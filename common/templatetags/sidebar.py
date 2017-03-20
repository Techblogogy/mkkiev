# coding: utf-8
from __future__ import unicode_literals

import json
import codecs
import os

from django.core.cache import caches, InvalidCacheBackendError
from django.template import Library
from django.template.loader import render_to_string
from django.utils import timezone
from django.utils.safestring import mark_safe
from django.utils.translation import ugettext_lazy as _

from djangoapp.settings import BASE_DIR

from articles.models import Article, Tag
from .namaz_times import ftime, namaz_times
from .namaz_umma_ru import NAMAZ_UMMA_RU

register = Library()


@register.simple_tag(takes_context=True)
def show_namaz_times(context):
    if 'SECOND_PASS_RENDER' not in context:
        return mark_safe('{% load sidebar %}{% show_namaz_times %}')
    key = 'show_namaz_times_tag'
    timeout = 600
    try:
        cache = caches['alternate']
        result = cache.get(key)
        if result is None:
            ezan, gunes, ogle, ikindi, aksam, yatsi = namaz_times(timezone.now().date(), 25, 55.755786, 37.617633, 4, 1, 12.0, 11.5, ftime)
            result = {'ezan': ezan, 'gunes': gunes, 'ogle': ogle, 'ikindi': ikindi, 'aksam': aksam, 'yatsi': yatsi}
            cache.set(key, result, timeout)
        return render_to_string('common/templatetags/namaz_times.html', result)
    except InvalidCacheBackendError:
        pass


@register.simple_tag(takes_context=True)
def show_namaz_umma_ru(context):
    if 'SECOND_PASS_RENDER' not in context:
        return mark_safe('{% load sidebar %}{% show_namaz_umma_ru %}')
    try:
        object_list = []
        for city in 'Moskova', 'Sankt-Peterburg', 'Ufa', 'Kazan':
            nt = NAMAZ_UMMA_RU[city][timezone.now().timetuple().tm_yday - 1]
            object_list.append({'city': city, 'ezan': nt[0], 'gunes': nt[1], 'ogle': nt[2], 'ikindi': nt[3], 'aksam': nt[4], 'yatsi': nt[5]})
        return render_to_string('common/templatetags/namaz_times.html', {'object_list': object_list})
    except KeyError:
        pass


@register.simple_tag(takes_context=True)
def show_weather(context):
    # print "Weather"
    if 'SECOND_PASS_RENDER' not in context:
        return mark_safe('{% load sidebar %}{% show_weather %}')
    try:
        # path = '/var/www/mkkiev/common/templatetags/weather.json'
        path = os.path.join(BASE_DIR, "common", "templatetags", "weather.json")
        with codecs.open(path, 'r', 'utf-8') as f:
            json_string = f.read()
        object_list = json.loads(json_string)
    except (IOError, AttributeError):
        object_list = {}

    return render_to_string('common/templatetags/weather.html', {'object_list': object_list})


@register.simple_tag(takes_context=True)
def show_currency(context):
    if 'SECOND_PASS_RENDER' not in context:
        return mark_safe('{% load sidebar %}{% show_currency %}')
    try:
        # path = '/var/www/mkkiev/common/templatetags/currency.json'
        path = os.path.join(BASE_DIR, "common", "templatetags", "currency.json")
        with codecs.open(path, 'r', 'utf-8') as f:
            json_string = f.read()
        object_list = json.loads(json_string)
    except (IOError, AttributeError):
        object_list = {}
    return render_to_string('common/templatetags/currency.html', {'object_list': object_list})


@register.simple_tag(takes_context=True)
def show_popular(context, slug='popular'):
    if 'SECOND_PASS_RENDER' not in context:
        return mark_safe('{% load sidebar %}{% show_popular %}')
    object_list = Article.objects.filter(tags__slug=slug).order_by('pageviews')[:8]
    return render_to_string('common/templatetags/slidebox.html', {'object_list': object_list, 'title': _('Самое читаемое'), 'slug': slug})


@register.inclusion_tag('common/templatetags/slidebox.html')
def show_slidebox(slug, count=7):
    object_list = {}
    try:
        tag = Tag.objects.get(slug=slug)
    except Tag.DoesNotExist:
        return {'object_list': object_list}
    object_list = Article.objects.filter(tags=tag, activity=True).select_related('category')[:count]
    return {'object_list': object_list, 'title': tag.name, 'slug': slug}
