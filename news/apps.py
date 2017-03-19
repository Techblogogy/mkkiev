# coding: utf-8
from __future__ import unicode_literals

from django.apps import AppConfig
from django.db.models.signals import post_save, post_delete, m2m_changed
from django.utils.translation import ugettext_lazy as _

from common.signals import invalidate_cache


class NewsConfig(AppConfig):
    name = 'news'
    verbose_name = _('Новости')

    def ready(self):
        from djangoapp.admin import admin_site
        from news.models import NewsCategory, News
        from news.admin import NewsCategoryAdmin, NewsAdmin
        post_save.connect(invalidate_cache, sender=NewsCategory)
        post_delete.connect(invalidate_cache, sender=NewsCategory)
        post_save.connect(invalidate_cache, sender=News)
        post_delete.connect(invalidate_cache, sender=News)
        m2m_changed.connect(invalidate_cache, sender=News)
        admin_site.register(NewsCategory, NewsCategoryAdmin)
        admin_site.register(News, NewsAdmin)
