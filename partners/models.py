from __future__ import unicode_literals

from django.db import models

from django.utils.translation import ugettext_lazy as _


class Partner(models.Model):

    slug = models.CharField(max_length=200)
    url = models.URLField(_('URL'), blank=True, help_text=_(''))
    image = models.FileField(_('File'), upload_to='banners', help_text=_('gif, jpg, png...'))

    height = models.PositiveIntegerField(_('Height'))

    def publish(self):
        self.save()
