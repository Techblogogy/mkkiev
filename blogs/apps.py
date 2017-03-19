# coding: utf-8
from __future__ import unicode_literals

from django.apps import AppConfig
from django.db.models.signals import post_save, post_delete, m2m_changed
from django.utils.translation import ugettext_lazy as _

from common.signals import invalidate_cache


class BlogsConfig(AppConfig):
    name = 'blogs'
    verbose_name = _('Блоги')

    def ready(self):
        from djangoapp.admin import admin_site
        from blogs.models import Author, Blog
        from blogs.admin import AuthorAdmin, BlogAdmin
        post_save.connect(invalidate_cache, sender=Author)
        post_delete.connect(invalidate_cache, sender=Author)
        post_save.connect(invalidate_cache, sender=Blog)
        post_delete.connect(invalidate_cache, sender=Blog)
        m2m_changed.connect(invalidate_cache, sender=Blog)
        admin_site.register(Author, AuthorAdmin)
        admin_site.register(Blog, BlogAdmin)
