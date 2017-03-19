# coding: utf-8
from __future__ import unicode_literals

from copy import deepcopy

from django.template import Library

register = Library()


@register.filter
def reorder(base_apps):
    if len(base_apps) == 1:
        return base_apps
    order_list = (
        ('news', [
            'articles_article',
            'news_news',
            'headlines_headline',
            'videogallery_videogallery',
            'photogallery_photogallery',
            'news_newscategory',
            'articles_tag'
        ]),
        ('pages', []),
        ('blogs', []),
        ('partners', []),
        ('polls', []),
        ('banner_adds', []),
        ('banners', []),
        ('registration', [
            'registration_user',
            'auth_group',
            'subscribes_subscribe',
            'polls_poll',
            'pages_page',
            'comments_comment',
            'sites_site',
        ])
    )
    new_apps = []
    for key_order_app_name, order_models in order_list:
        if order_models:
            new_models = []
            for order_model in order_models:
                order_app_name, _, order_model_name = order_model.partition('_')
                for app in base_apps:
                    if app['app_label'].lower() == order_app_name:
                        for model in app['models']:
                            _, _, model_name = model['admin_url'].rstrip('/').rpartition('/')
                            if model_name == order_model_name:
                                new_models.append(deepcopy(model))
            for app in base_apps:
                if app['app_label'] == key_order_app_name:
                    temp = deepcopy(app)
                    temp['models'] = new_models
                    new_apps.append(temp)
        else:
            for app in base_apps:
                if app['app_label'] == key_order_app_name:
                    new_apps.append(deepcopy(app))
    return new_apps
