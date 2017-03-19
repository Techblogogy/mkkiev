# coding: utf-8
from __future__ import unicode_literals

from django.apps import AppConfig
from django.db.models.signals import post_save, post_delete, m2m_changed
from django.utils.translation import ugettext_lazy as _

from common.signals import invalidate_cache


class ArticlesConfig(AppConfig):
    name = 'articles'
    verbose_name = _('Статьи')

    def ready(self):
        from djangoapp.admin import admin_site
        from articles.models import Category, Tag, Article
        from articles.admin import CategoryAdmin, TagAdmin, ArticleAdmin
        post_save.connect(invalidate_cache, sender=Category, dispatch_uid='articles_category')
        post_delete.connect(invalidate_cache, sender=Category, dispatch_uid='articles_category')
        post_save.connect(invalidate_cache, sender=Tag, dispatch_uid='articles_tag')
        post_delete.connect(invalidate_cache, sender=Tag, dispatch_uid='articles_tag')
        post_save.connect(invalidate_cache, sender=Article, dispatch_uid='articles_article')
        post_delete.connect(invalidate_cache, sender=Article, dispatch_uid='articles_article')
        m2m_changed.connect(invalidate_cache, sender=Article, dispatch_uid='articles_article')
        admin_site.register(Tag, TagAdmin)
        admin_site.register(Category, CategoryAdmin)
        admin_site.register(Article, ArticleAdmin)
