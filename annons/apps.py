from __future__ import unicode_literals

from django.apps import AppConfig
from django.db.models.signals import post_delete, post_save, m2m_changed
from django.utils.translation import ugettext_lazy as _

from common.signals import invalidate_cache


class AnnonsConfig(AppConfig):
    name = 'banner_adds'
    verbose_name = _('Banners')

    def ready(self):

        from djangoapp.admin import admin_site
        from banner_adds.models import Banneradds
        from banner_adds.admin import BanneraddsAdmin

        post_save.connect(invalidate_cache, sender=Banneradds)
        post_delete.connect(invalidate_cache, sender=Banneradds)
        m2m_changed.connect(invalidate_cache, sender=Banneradds)

        admin_site.register(Banneradds, BanneraddsAdmin)

        from banner_adds.views import render_banners
        render_banners()
