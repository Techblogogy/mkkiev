from __future__ import unicode_literals

from django.apps import AppConfig
from django.db.models.signals import post_delete, post_save, m2m_changed
from django.utils.translation import ugettext_lazy as _

from common.signals import invalidate_cache


class PartnersConfig(AppConfig):
    name = 'Partners'
    verbose_name = _('Partners')

    def ready(self):

        from djangoapp.admin import admin_site
        from Partners.models import Partner
        from Partners.admin import PartnerAdmin

        post_save.connect(invalidate_cache, sender=Partner)
        post_delete.connect(invalidate_cache, sender=Partner)
        m2m_changed.connect(invalidate_cache, sender=Partner)

        admin_site.register(Partner, PartnerAdmin)
