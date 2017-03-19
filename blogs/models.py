# coding: utf-8
from __future__ import unicode_literals

from django.db import models
from django.core.exceptions import ValidationError
from django.utils.translation import ugettext_lazy as _

from registration.models import User
from articles.models import Category, Article
from blogs.managers import Manager, AuthorManager


class Author(User):
    objects = AuthorManager()

    class Meta:
        proxy = True
        ordering = ('first_name', 'last_name')
        verbose_name = _('Автор')
        verbose_name_plural = _('Авторы')


class Blog(Article):
    objects = Manager()

    @models.permalink
    def get_absolute_url(self):
        if self.author is None:
            return 'articles:category:detail', ['blog', self.url_slug_date(), self.slug]
        return 'blogs:author:detail', [self.author.username, self.url_slug_date(), self.slug]

    class Meta:
        proxy = True
        verbose_name = _('Блог')
        verbose_name_plural = _('Блоги')

    def clean_fields(self, exclude=None):
        self.category = Category.objects.get(slug='blog')
        super(Blog, self).clean_fields(exclude)

    def clean(self):
        if not self.author:
            raise ValidationError('Выберите автора блога')