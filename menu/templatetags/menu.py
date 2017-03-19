# coding: utf-8
from __future__ import unicode_literals

from django import template
from django.core.exceptions import ObjectDoesNotExist

from articles.models import Article
from news.models import NewsCategory


register = template.Library()


@register.inclusion_tag('menu/templatetags/top.html', takes_context=True)
def show_top_menu(context):
    path = ''
    try:
        path = context['request'].path.strip('/').split('/')[0]
    except KeyError:
        pass
    return {'object_list': NewsCategory.objects.filter(main_category=True, activity=True).order_by('ordering'), 'path': path}


@register.inclusion_tag('menu/templatetags/footer.html', takes_context=True)
def show_footer_menu(context):
    path = ''
    try:
        path = context['request'].path.strip('/').split('/')[0]
    except KeyError:
        pass
    return {'object_list': NewsCategory.objects.filter(main_category=False, activity=True), 'path': path}


@register.inclusion_tag('menu/templatetags/context.html')
def show_context_menu(tag='caricature'):
    query_set = Article.objects.filter(activity=True)
    try:
        image = query_set.filter(category__slug='photo-gallery').latest()
    except ObjectDoesNotExist:
        image = Article(title='Sundown in Istanbul', image='images/zakat_stambul.JPG')
    try:
        video = query_set.filter(category__slug='video-gallery').latest()
    except ObjectDoesNotExist:
        video = Article(title='Arrow - first left to right', image='images/photo1_1.png')
    try:
        caricature = query_set.filter(tags__slug=tag).latest()
    except ObjectDoesNotExist:
        caricature = Article(title='Israil\'s global world chess master class', image='images/blog/cizgiyorum_israil.jpg')
    return {'video': video, 'image': image, 'caricature': caricature, 'tag': tag}
