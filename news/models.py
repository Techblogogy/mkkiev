# coding: utf-8
from __future__ import unicode_literals

from django.db import models
from django.utils.translation import ugettext_lazy as _

from articles.models import Category, Article
from news.managers import CategoryManager, Manager


class NewsCategory(Category):
    objects = CategoryManager()

    @models.permalink
    def get_absolute_url(self):
        return 'news:category:list', [self.slug]

    class Meta:
        proxy = True
        verbose_name = _('Категория')
        verbose_name_plural = _('Категории')


class News(Article):
    objects = Manager()

    @models.permalink
    def get_absolute_url(self):
        category_slug = self.category.slug
        if category_slug == 'blog':
            return 'blogs:author:detail', [self.author.username, self.url_slug_date(), self.slug]
        return 'news:category:detail', [category_slug, self.url_slug_date(), self.slug]

    class Meta:
        proxy = True
        verbose_name = _('Новость')
        verbose_name_plural = _('Новости')