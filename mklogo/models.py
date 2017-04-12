# coding: utf-8
from __future__ import unicode_literals

from django.db import models

from django.utils.translation import ugettext_lazy as _


class Logo(models.Model):

    slug = models.CharField(_("Slug"), max_length=200)
    image = models.FileField(_('Файл'), upload_to='logos', help_text=_('jpg, png...'))

    # width = models.PositiveIntegerField(_('Width'))
    # height = models.PositiveIntegerField(_('Height'))

    def publish(self):
        self.save()

    class Meta:
        verbose_name = _('Logo')
        verbose_name_plural = _('Logo')
