# coding: utf-8
from __future__ import unicode_literals

from django.db import models
from django.utils.encoding import python_2_unicode_compatible
from django.utils.translation import ugettext_lazy as _


@python_2_unicode_compatible
class Category(models.Model):
    name = models.CharField(_('Название'), max_length=200)
    slug = models.SlugField(max_length=200, unique=True)
    width = models.PositiveIntegerField(_('Ширина колонки (px)'), null=True, blank=True)
    height = models.PositiveIntegerField(_('Высота баннера'), null=True, blank=True)
    main = models.BooleanField(_('Главная категория'), default=True)
    ordering = models.PositiveIntegerField(_('Сортировка'), default=500)
    activity = models.BooleanField(_('Активность'), default=True)

    def __str__(self):
        return self.name

    class Meta:
        ordering = ('-main', 'ordering', 'name')
        verbose_name = _('Категория')
        verbose_name_plural = _('Категории')


@python_2_unicode_compatible
class Client(models.Model):
    name = models.CharField(_('Название'), max_length=200)
    slug = models.SlugField(max_length=200, unique=True)
    url = models.URLField(_('Cайт клиента'), blank=True)
    email = models.EmailField(_('Е-маил'), blank=True)
    ordering = models.PositiveIntegerField(_('Сортировка'), default=500)
    activity = models.BooleanField(_('Активность'), default=True)

    def __str__(self):
        return self.name

    class Meta:
        ordering = ('ordering',)
        verbose_name = _('Клиент')
        verbose_name_plural = _('Клиенты')


@python_2_unicode_compatible
class Banner(models.Model):
    category = models.ForeignKey(Category, null=True, blank=True, on_delete=models.CASCADE, verbose_name=_('Категория'), related_name='banners', limit_choices_to={"main":True})
    categories = models.ManyToManyField(Category, blank=True, verbose_name=_('Фильтр по новости'), related_name='extra_banners', limit_choices_to={"main":False})
    client = models.ForeignKey(Client, on_delete=models.CASCADE, verbose_name=_('Клиент'), related_name='clients')
    url = models.URLField(_('URL клика'), blank=True, help_text=_('По умолчанию указанный у клиента или встроенный в флеш'))
    create_date = models.DateTimeField(_('Дата создания'), auto_now_add=True)
    ordering = models.PositiveIntegerField(_('Сортировка'), null=True, blank=True, help_text=_('По умолчанию последний в этой категории'))
    activity = models.BooleanField(_('Активность'), default=True)
    is_shown = models.BooleanField(_('В показе'), default=False)
    show_count = models.PositiveIntegerField(_('Кол-во показов'), default=0)
    max_show_count = models.PositiveIntegerField(_('Максимальное кол-во показов'), null=True, blank=True, help_text=_('По умолчанию неограниченное кол-во'))
    clicks = models.PositiveIntegerField(_('Клики'), default=0)
    file = models.FileField(_('Файл'), upload_to='banners', help_text=_('c расширениями gif, jpg, png, swf...'))
    width = models.PositiveIntegerField(_('Ширина'), null=True, blank=True)
    height = models.PositiveIntegerField(_('Высота'), null=True, blank=True)
    code = models.TextField(_('Код баннера'), blank=True, help_text=_('Пользовательский код баннера. Используйте теги: {{ file }}, {{ width}}, {{ height }}.'))

    def __str__(self):
        return self.client.name
        
    def admin_show_count(self):
        if self.max_show_count is not None:
            return '%s из %s' % (self.show_count, self.max_show_count)
        else:
            return self.show_count
    admin_show_count.short_description = _('Кол-во показов')
    
    def admin_clicks(self):
        show_count_percent = round(self.clicks*100.0/self.show_count, 2) if self.show_count > 0 else 0.
        return '%s - %.2f' % (self.clicks, show_count_percent) + '%'
    admin_clicks.short_description = _('Клики')

    class Meta:
        ordering = ('category__ordering', 'ordering')
        verbose_name = _('Баннер')
        verbose_name_plural = _('Баннеры')
