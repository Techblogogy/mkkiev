# coding: utf-8
from __future__ import unicode_literals

from django.apps import AppConfig
from django.db.models.signals import post_delete, post_save, m2m_changed
from django.utils.translation import ugettext_lazy as _

from common.signals import invalidate_cache


class LogoConfig(AppConfig):
    name = 'mklogo'
    verbose_name = _('Logo')

    def ready(self):

        from djangoapp.admin import admin_site
        from mklogo.models import Logo
        from mklogo.admin import LogoAdmin

        post_save.connect(invalidate_cache, sender=Logo)
        post_delete.connect(invalidate_cache, sender=Logo)
        m2m_changed.connect(invalidate_cache, sender=Logo)

        admin_site.register(Logo, LogoAdmin)
