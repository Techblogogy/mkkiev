# coding: utf-8
from __future__ import unicode_literals

from django.apps import AppConfig
from django.db.models.signals import post_save, post_delete
from django.utils.translation import ugettext_lazy as _

from common.signals import invalidate_cache


class PagesConfig(AppConfig):
    name = 'pages'
    verbose_name = _('Pages')

    def ready(self):
        from djangoapp.admin import admin_site
        from pages.models import Page
        from pages.admin import PageAdmin
        post_save.connect(invalidate_cache, sender=Page)
        post_delete.connect(invalidate_cache, sender=Page)
        admin_site.register(Page, PageAdmin)
