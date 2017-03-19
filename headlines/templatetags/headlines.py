# coding: utf-8
from __future__ import unicode_literals

import os

from django.conf import settings
from django.template import Library

from ..models import Headline
from banners.models import Banner

register = Library()


@register.inclusion_tag('headlines/templatetags/headline.html')
def show_headline():
    pass


@register.inclusion_tag('headlines/templatetags/fps_slider.html')
def show_fps_slider():
    object_list = list(Headline.objects.filter(activity=True).prefetch_related('category')[:settings.HEADLINE_COUNT])
    # replace last slider with banner
    try:
        banner = Banner.objects.filter(category__slug='manset', activity=True).order_by('ordering')[:1][0]
        headline = Headline(title=banner.client.name)
        if os.path.splitext(banner.file.name)[1] != '.swf':
            headline.image = banner.file
        headline.get_absolute_url = banner.url
        headline.banner_id = banner.id
        object_list[-1] = headline
    except IndexError:
        pass
    return {'object_list': object_list}


@register.inclusion_tag('headlines/fps_slider_big_tags.html')
def show_fps_slider_big():
    return {'object_list': Headline.objects.filter(activity=True).prefetch_related('category')[:settings.HEADLINE_COUNT]}
