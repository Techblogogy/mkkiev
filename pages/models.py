# coding: utf-8
from __future__ import unicode_literals

from django.db import models
from django.core.urlresolvers import get_script_prefix
from django.utils.translation import ugettext_lazy as _
from django.utils.encoding import iri_to_uri, python_2_unicode_compatible


@python_2_unicode_compatible
class Page(models.Model):
    url = models.CharField(_('URL'), max_length=100, db_index=True)
    title = models.CharField(_('title'), max_length=200)
    keywords = models.CharField(_('ключевые слова'), max_length=255, blank=True,
                                help_text=_('С прописными буквами через запятую'))
    description = models.CharField(_('описание'), max_length=255, blank=True)
    content = models.TextField(_('content'), blank=True)
    enable_comments = models.BooleanField(_('enable comments'), default=False, blank=True)
    template_name = models.CharField(_('template title'), max_length=70, blank=True,
                                     help_text=_("Example: 'pages/contact_page.html'. "
                                                 "If this isn't provided, the system will use 'pages/default.html'."))
    registration_required = models.BooleanField(_('registration required'), default=False, blank=True,
                                                help_text=_("If this is checked, only logged-in users"
                                                            " will be able to view the page."))

    class Meta:
        verbose_name = _('page')
        verbose_name_plural = _('pages')
        ordering = ('url',)
        default_permissions = ('add', 'change', 'delete', 'view')

    def __str__(self):
        return "%s -- %s" % (self.url, self.title)

    def get_absolute_url(self):
        # Handle script prefix manually because we bypass reverse()
        return iri_to_uri(get_script_prefix().rstrip('/') + self.url)