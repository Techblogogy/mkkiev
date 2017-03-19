# coding: utf-8
from __future__ import unicode_literals

from datetime import timedelta

from django.db import models
from django.conf import settings
from django.utils import timezone
from django.utils.encoding import python_2_unicode_compatible
from django.utils.translation import ugettext_lazy as _

from articles.utils import upload_to
from common.templatetags.common import do_newscut, remove_tags


@python_2_unicode_compatible
class Category(models.Model):
    name = models.CharField(_('Название'), max_length=200)
    slug = models.SlugField(max_length=200, unique=True)
    ordering = models.PositiveIntegerField(_('Сортировка'), default=500)
    activity = models.BooleanField(_('Активность'), default=True)
    main_category = models.BooleanField(_('Показывать в меню'), default=False)
    objects = models.Manager()

    @models.permalink
    def get_absolute_url(self):
        return 'articles:category:list', [self.slug]

    def __str__(self):
        return self.name

    class Meta:
        ordering = ('ordering',)
        verbose_name = _('Категория')
        verbose_name_plural = _('Категории')


@python_2_unicode_compatible
class Tag(models.Model):
    name = models.CharField(_('Название'), max_length=200)
    slug = models.SlugField(max_length=200, unique=True)
    ordering = models.PositiveIntegerField(_('Сортировка'), default=500)
    activity = models.BooleanField(_('Активность'), default=True)
    objects = models.Manager()

    def __str__(self):
        return self.name
 
    class Meta:
        ordering = ('name', 'ordering')
        verbose_name = _('Тег')
        verbose_name_plural = _('Теги')


ARTICLE_CONTENT_HELP_TEXT = '''
<a href="http://blogerator.ru/page/markdown-izjashhnoe-formatirovanie-dlja-web-20">Markdown</a> — очень простой и изящный синтаксис разметки текста.
<a href="http://mkkiev.in.ua/tutorial/markdown/">Руководство</a>.
<a href="#" onclick="alert('Разрыв строки создаётся при использовании двух или более пробелов.\\nАбзацы создаются пустой строкой.\\nВыделение текста: _курсив_, *выделенное слово*, **жирный шрифт**.\\nЗаголовки: #первый уровень, ##второй уровень и т.д. Можно использовать подчеркивание знаками: «=» задает первый уровень, дефисами «-» - второй.\\nЦитаты определяются угловой скобкой: >текст цитаты.\\nСписки: для неупорядоченных элементов используются символы «*„, “-» или «+»; для упорядоченных элементов используются цифры.\\nДля форматирования блока кода его выделяют обратным апострофом «`», или каждую строку кода начинают с четырёх или более пробелов.\\nГоризонтальная черта: три или более дефиса или звездочки.\\nСсылки: [текст ссылки](url).\\nИзображения: ![alt текст](url_изображения).\\nЧтобы вставить спецсимвол, используемый в разметке, как обычный символ, его нужно предварить символом обратной косой черты.')">Справка (?)</a>
'''


@python_2_unicode_compatible
class Article(models.Model):
    title = models.CharField(_('Заголовок'), max_length=200)
    slug = models.SlugField(max_length=200, unique_for_date='pub_date', help_text=_('Автоматически генерируется из заголовка (лат.буквы и -)'))
    activity = models.BooleanField(_('Активность'), default=True)
    category = models.ForeignKey(Category, on_delete=models.SET_DEFAULT, default=0, verbose_name=_('Категория'))
    content = models.TextField(_('Новость'), help_text=ARTICLE_CONTENT_HELP_TEXT)
    caption = models.CharField(_('Подпись'), help_text=_('Например: Явуз Билиджи, Джихан'), blank=True, max_length=255)
    image = models.ImageField(_('Фотография'), upload_to=upload_to, max_length=255, blank=True)
    #video = models.FileField(_('Видео'), upload_to='video/', help_text=_('видео файлы...'))
    video = models.URLField(_('Видео'), max_length=255)
    tags = models.ManyToManyField(Tag, blank=True, verbose_name=_('Тэги'), related_name='articles')
    slug_date = models.DateField(_('Дата публикации Y-d-m'))
    pub_date = models.DateTimeField(_('Дата публикации'), blank=True)
    write_date = models.DateTimeField(_('Дата написания'), blank=True, null=True)
    publisher = models.ForeignKey(settings.AUTH_USER_MODEL, null=True, blank=True, on_delete=models.PROTECT, related_name='publisher_articles', verbose_name=_('Опубликовал'), help_text=_('По умолчанию текущий пользователь'), limit_choices_to={'is_staff': True})
    create_date = models.DateTimeField(_('Дата создания статьи'), auto_now_add=True)
    creator = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.PROTECT, related_name='creator_articles', verbose_name=_('Cоздатель'), editable=False)
    edit_date = models.DateTimeField(_('Дата редактирования статьи'), auto_now=True)
    editor = models.ForeignKey(settings.AUTH_USER_MODEL, blank=True, null=True, on_delete=models.PROTECT, related_name='editor_articles', verbose_name=_('Редактор'), editable=False)
    free = models.BooleanField(_('Свободен'), default=True)
    author = models.ForeignKey(settings.AUTH_USER_MODEL, blank=True, null=True, on_delete=models.PROTECT, related_name='author_articles', verbose_name=_('Автор'))
    show = models.BooleanField(_('Показывать для SEO полный путь'), default=False)
    headline = models.BooleanField(_('Маншет'), default=False)
    aside = models.BooleanField(_('Блок по теме'), default=True)
    version = models.PositiveIntegerField(_('Версия'), default=1, editable=False)
    pageviews = models.IntegerField(_('Просмотры'), blank=True, default=0, editable=False)
    ordering = models.PositiveIntegerField(_('Сортировка'), blank=True, null=True)
    related = models.ManyToManyField('self', blank=True, verbose_name=_('Материалы по теме'), limit_choices_to={'pub_date__gte': (timezone.now() + timedelta(days=-365))})
    objects = models.Manager()

    def __str__(self):
        return self.title

    def author_full_name(self):
        return self.author.full_name()
    author_full_name.short_description = _('Автор')

    def description(self):
        return remove_tags(do_newscut(self.content), "p b i")

    def url_slug_date(self):
        return self.slug_date.strftime('%Y/%m/%d')

    def get_image_url(self):
        try:
            return self.image.url
        except StandardError:
            return ''

    def get_next(self):
        return self.get_next_by_pub_date(activity=True)

    def get_previous(self):
        return self.get_previous_by_pub_date(activity=True)

    @models.permalink
    def get_absolute_url(self):
        category_slug = self.category.slug
        if category_slug == 'blog' and self.author is not None:
            return 'blogs:author:detail', [self.author.username, self.url_slug_date(), self.slug]
        return 'articles:category:detail', [category_slug, self.url_slug_date(), self.slug]

    class Meta:
        ordering = ('-pub_date',)
        unique_together = ('slug_date', 'slug')
        get_latest_by = 'pub_date'
        verbose_name = _('Статья')
        verbose_name_plural = _('Все статьи')