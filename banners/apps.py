# coding: utf-8
from __future__ import unicode_literals

from django.apps import AppConfig
from django.db.models.signals import post_delete, post_save, m2m_changed
from django.utils.translation import ugettext_lazy as _

from common.signals import invalidate_cache


class BannersConfig(AppConfig):
    name = 'banners'
    verbose_name = _('Баннеры')

    def ready(self):
        from djangoapp.admin import admin_site
        from banners.models import Category, Client, Banner
        from banners.admin import CategoryAdmin, ClientAdmin, BannerAdmin
        post_save.connect(invalidate_cache, sender=Category)
        post_delete.connect(invalidate_cache, sender=Category)
        post_save.connect(invalidate_cache, sender=Client)
        post_delete.connect(invalidate_cache, sender=Client)
        post_save.connect(invalidate_cache, sender=Banner)
        post_delete.connect(invalidate_cache, sender=Banner)
        m2m_changed.connect(invalidate_cache, sender=Banner, dispatch_uid='banners_banner')
        
        admin_site.register(Category, CategoryAdmin)
        admin_site.register(Client, ClientAdmin)
        admin_site.register(Banner, BannerAdmin)
