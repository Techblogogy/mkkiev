# coding: utf-8
from __future__ import unicode_literals

import datetime

from django.utils import timezone
from django.db import models
from django.utils.encoding import python_2_unicode_compatible
from django.utils.translation import ugettext_lazy as _


@python_2_unicode_compatible
class Poll(models.Model):
    question_text = models.CharField(_('Вопрос'), max_length=200)
    pub_date = models.DateTimeField(_('Дата публикации'), blank=True)

    def __str__(self):
        return self.question_text

    def was_published_recently(self):
        now = timezone.now()
        return now - datetime.timedelta(days=1) <= self.pub_date < now
    was_published_recently.admin_order_field = 'pub_date'
    was_published_recently.boolean = True
    was_published_recently.short_description = _('Опубликовано?')

    @property
    def all_votes(self):
        try:
            return self.cached_all_votes
        except AttributeError:
            self.cached_all_votes = sum([i.votes for i in self.choice_set.all()])
            return self.cached_all_votes

    class Meta:
        verbose_name = _('Опрос')
        verbose_name_plural = _('Опросы')


@python_2_unicode_compatible
class Choice(models.Model):
    poll = models.ForeignKey(Poll)
    choice_text = models.CharField(_('Ответ'), max_length=200)
    votes = models.IntegerField(_('Кол-во голосов'), default=0)

    def __str__(self):
        return self.choice_text

    @property
    def votes_percent(self):
        try:
            return round(float(self.votes) / self.poll.all_votes * 100, 2)
        except ZeroDivisionError:
            return None

    class Meta:
        verbose_name = _('Выбор')
        verbose_name_plural = _('Выбор')
