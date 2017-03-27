# coding: utf-8
from __future__ import unicode_literals

from django.apps import AppConfig
from django.db.models.signals import post_delete, post_save, m2m_changed
from django.utils.translation import ugettext_lazy as _

from common.signals import invalidate_cache


class AnnonsConfig(AppConfig):
    name = 'annons'
    verbose_name = _('Анонсы')

    def ready(self):

        from djangoapp.admin import admin_site
        from annons.models import Annons
        from annons.admin import AnnonsAdmin

        post_save.connect(invalidate_cache, sender=Annons)
        post_delete.connect(invalidate_cache, sender=Annons)
        m2m_changed.connect(invalidate_cache, sender=Annons)

        admin_site.register(Annons, AnnonsAdmin)
