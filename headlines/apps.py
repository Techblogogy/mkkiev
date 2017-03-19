# coding: utf-8
from __future__ import unicode_literals

from django.apps import AppConfig
from django.db.models.signals import post_save, post_delete, m2m_changed
from django.utils.translation import ugettext_lazy as _

from common.signals import invalidate_cache


class HeadlinesConfig(AppConfig):
    name = 'headlines'
    verbose_name = _('Маншет')

    def ready(self):
        from djangoapp.admin import admin_site
        from headlines.models import Headline
        from headlines.admin import HeadlineAdmin
        post_save.connect(invalidate_cache, sender=Headline)
        post_delete.connect(invalidate_cache, sender=Headline)
        m2m_changed.connect(invalidate_cache, sender=Headline)
        admin_site.register(Headline, HeadlineAdmin)
