# coding: utf-8
from __future__ import unicode_literals

from django.db import models
from django.utils.encoding import python_2_unicode_compatible
from django.utils.translation import ugettext_lazy as _

SUBSCRIBE_ERROR_MESSAGES = {
    'unique': _('Этот почтовый адрес уже есть в списке рассылок'),
    'blank': _('Вы не заполнили почтовый адрес'),
    'invalid_choice': _('Невалидный почтовый адрес'),
}


@python_2_unicode_compatible
class Subscribe(models.Model):
    email = models.EmailField(_('Email'), unique=True, blank=False, error_messages=SUBSCRIBE_ERROR_MESSAGES)
    activity = models.BooleanField(_('Активность'), default=True)
    create_date = models.DateTimeField(_('Дата подписки'), auto_now_add=True)

    def __str__(self):
        return self.email

    class Meta:
        ordering = ('-create_date',)
        verbose_name = _('Подписка')
        verbose_name_plural = _('Подписки')