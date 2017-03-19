# coding: utf-8
from __future__ import unicode_literals

from django.db import models
from django.contrib.auth.models import AbstractUser
from django.utils.encoding import python_2_unicode_compatible
from django.utils.translation import ugettext_lazy as _


@python_2_unicode_compatible
class User(AbstractUser):
    location = models.CharField(_('Принадлежность'), max_length=200, blank=True, help_text=_('Например: Киев и т.д.'))
    image = models.ImageField(_('Фотография'), upload_to='userpics', max_length=100, blank=True)

    def full_name(self):
        full_name = '%s %s' % (self.first_name, self.last_name)
        return full_name if full_name.strip() else self.username

    def __str__(self):
        return self.full_name()

    class Meta:
        db_table = 'auth_user'
        ordering = ('first_name', 'last_name')
        verbose_name = _('Пользователь')
        verbose_name_plural = _('Пользователи')