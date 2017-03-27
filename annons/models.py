# coding: utf-8
from __future__ import unicode_literals

from django.db import models

from django.utils.translation import ugettext_lazy as _


class Annons(models.Model):

    title = models.CharField(_("Текст"), max_length=200)
    url = models.URLField(_('URL'), blank=True, help_text=_(''))
    image = models.FileField(_('Файл'), upload_to='banners', help_text=_('gif, jpg, png...'))

    # width = models.PositiveIntegerField(_('Width'))
    # height = models.PositiveIntegerField(_('Height'))

    def publish(self):
        self.save()

    class Meta:
        verbose_name = _('Анонс')
        verbose_name_plural = _('Анонсы')
