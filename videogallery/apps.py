# coding: utf-8
from __future__ import unicode_literals

from django.apps import AppConfig
from django.db.models.signals import post_save, post_delete, m2m_changed
from django.utils.translation import ugettext_lazy as _

from common.signals import invalidate_cache


class VideoGalleryConfig(AppConfig):
    name = 'videogallery'
    verbose_name = _('Видеогалерея')

    def ready(self):
        from djangoapp.admin import admin_site
        from videogallery.models import VideoGallery
        from videogallery.admin import VideoGalleryAdmin
        post_save.connect(invalidate_cache, sender=VideoGallery)
        post_delete.connect(invalidate_cache, sender=VideoGallery)
        m2m_changed.connect(invalidate_cache, sender=VideoGallery)
        admin_site.register(VideoGallery, VideoGalleryAdmin)
