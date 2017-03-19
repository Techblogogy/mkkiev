# coding: utf-8
from __future__ import unicode_literals

from django.apps import AppConfig
from django.db.models.signals import post_save, post_delete, m2m_changed
from django.utils.translation import ugettext_lazy as _

from common.signals import invalidate_cache


class PhotoGalleryConfig(AppConfig):
    name = 'photogallery'
    verbose_name = _('Фотогалерея')

    def ready(self):
        from djangoapp.admin import admin_site
        from photogallery.models import Image, PhotoGallery
        from photogallery.admin import PhotoGalleryAdmin
        post_save.connect(invalidate_cache, sender=Image)
        post_delete.connect(invalidate_cache, sender=Image)
        post_save.connect(invalidate_cache, sender=PhotoGallery)
        post_delete.connect(invalidate_cache, sender=PhotoGallery)
        m2m_changed.connect(invalidate_cache, sender=PhotoGallery)
        admin_site.register(PhotoGallery, PhotoGalleryAdmin)
