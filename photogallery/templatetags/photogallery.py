# coding: utf-8
from __future__ import unicode_literals

from django.template import Library

from ..models import PhotoGallery


register = Library()


@register.inclusion_tag('photogallery/templatetags/photogallery.html')
def show_photogallery():
    return {'object': PhotoGallery.objects.latest()}