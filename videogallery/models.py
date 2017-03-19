# coding: utf-8
from __future__ import unicode_literals

from django.utils.translation import ugettext_lazy as _

from articles.models import Article, Category
from videogallery.managers import Manager


class VideoGallery(Article):
    objects = Manager()

    class Meta:
        proxy = True
        verbose_name = _('Видео')
        verbose_name_plural = _('Видео')

    def clean_fields(self, exclude=None):
        self.category = Category.objects.get(slug='video-gallery')
        super(VideoGallery, self).clean_fields(exclude)