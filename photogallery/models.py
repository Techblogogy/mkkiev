# coding: utf-8
from __future__ import unicode_literals

from django.db import models
from django.utils.translation import ugettext_lazy as _

from articles.models import Article, Category
from photogallery.managers import Manager
from photogallery.utils import upload_to


class Image(models.Model):
    image = models.ImageField(_('Фотография'), upload_to=upload_to, max_length=255, blank=True)
    description = models.CharField(_('Описание'), max_length=200, blank=True)
    article = models.ForeignKey(Article, on_delete=models.CASCADE, related_name='images', verbose_name=_('Галерея рисунков'))
    activity = models.BooleanField(_('Активность'), default=True)

    class Meta:
        db_table = 'articles_image'


class PhotoGallery(Article):
    objects = Manager()

    class Meta:
        proxy = True
        verbose_name = _('Фотогалерея')
        verbose_name_plural = _('Фотогалерея')

    def clean_fields(self, exclude=None):
        self.category = Category.objects.get(slug='photo-gallery')
        super(PhotoGallery, self).clean_fields(exclude)