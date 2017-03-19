# coding: utf-8
from __future__ import unicode_literals

from django.forms import Textarea
from django.forms.utils import flatatt
from django.template.loader import render_to_string
from django.utils.encoding import force_text
from django.utils.translation import get_language

from pagedown import html2text


class PageDown(Textarea):

    def render(self, name, value, attrs=None):
        html, md = '', ''
        if value is not None:
            html = force_text(value)
            html = html.replace('<!--more-->', '<hr/>')
            html2text.BODY_WIDTH = 0
            html2text.INLINE_LINKS = False
            md = html2text.html2text(html)
        final_attrs = self.build_attrs(attrs, name=name)
        return render_to_string('pagedown/widget.html', {'final_attrs': flatatt(final_attrs), 'html': html, 'md': md})

    class Media:
        css = {'all': ('pagedown/css/style.css', 'pagedown/css/fileuploader.css')}
        js = (
            'pagedown/js/fileuploader.js',
            'pagedown/js/Markdown.Converter.js',
            'pagedown/js/Markdown.Sanitizer.js',
            'pagedown/js/Markdown.Editor.js',
            'pagedown/js/local/Markdown.local.{}.js'.format(get_language()[:2]),
        )
