# coding: utf-8
from __future__ import unicode_literals

import re
from datetime import datetime

from django import template
from django.core.urlresolvers import resolve
from django.template import Context
from django.template.loader import render_to_string
from django.utils import timezone
from django.conf import settings
from django.template.defaultfilters import date
from django.utils.encoding import force_unicode, force_text
from django.contrib.sites.shortcuts import get_current_site
from django.utils.html import format_html
from django.utils.safestring import mark_safe
from django.utils.text import Truncator

register = template.Library()


@register.simple_tag(takes_context=True)
def show_now(context, format_string):
    if 'SECOND_PASS_RENDER' not in context:
        return mark_safe('{% load common %}{% show_now "' + format_string + '" %}')
    tzinfo = timezone.get_current_timezone() if settings.USE_TZ else None
    return date(datetime.now(tz=tzinfo), format_string)


@register.simple_tag(takes_context=True)
def show_pageviews(context, pageviews):
    if 'SECOND_PASS_RENDER' not in context:
        return mark_safe('{% load common %}{% show_pageviews "' + str(pageviews) + '" %}')
    if not pageviews >= 0:
        pageviews = '…'
    return format_html('<span class="pageviews"><span></span> {}</span>', pageviews)


@register.simple_tag(takes_context=True)
def show_header_logo(context, text):
    tag = 'h1'
    request = context.get('request', False)
    if getattr(request, 'path', False) != '/':
        tag = 'div'
    return format_html('<a href="/" rel="home"><{} class="header_logo-image">{}</{}></a>', tag, text, tag)


@register.simple_tag(takes_context=True)
def siteurl(context):
    name = ''
    try:
        current_site = get_current_site(context['request'])
        name = current_site.name
    except KeyError:
        pass
    return name


class TitleNode(template.Node):
    def __init__(self, nodelist):
        self.nodelist = nodelist

    def render(self, context):
        title = self.nodelist.render(context).strip()
        if getattr(settings, 'SITE_TITLE') and settings.SITE_TITLE:
            return ('%s | ' % title if title else '') + settings.SITE_TITLE
        else:
            return title


@register.tag
def title(parser, token):
    nodelist = parser.parse(('endtitle',))
    parser.delete_first_token()
    return TitleNode(nodelist)


def do_newscut(s, num=200, sep='<!--more-->'):
    try:
        num = int(num)
    except ValueError:
        return s
    s = force_unicode(s)
    s = s.strip()
    head = s
    head_ = ''
    words = []
    r = re.compile(r'<[^>]*?>')
    while True:
        head, _, tail = head.partition(sep)
        if not tail:
            break
        _head = r.sub(' ', force_text(head + head_)).strip()
        if _head == '':
            head = tail
            continue
        _words = _head.split()
        if num <= len(_words):
            head = head_ + head
            words = head.split()
            break
        head_, head = head, tail
    if not words:
        head, _, tail = s.partition('</p>')
        if tail:
            return head
        return Truncator(s.replace(sep, '')).words(num, html=True)
    return ' '.join(words)


@register.filter
def newscut(s, num=200):
    return do_newscut(s, num)
newscut.is_safe = True


@register.filter
def removenewscut(s, sep='<!--more-->'):
    s = force_unicode(s)
    return s.replace(sep, '')
removenewscut.is_safe = True


@register.filter
def addaside(s, object_list, sep='<!--aside-->', n=1):
    s = force_unicode(s)
    try:
        c = Context({'object': object_list[0]})
        t = template.loader.get_template('common/templatetags/article_aside.html')
    except StandardError:
        return s
    aside = t.render(c)
    try:
        s.index(sep)
        return s.replace(sep, aside)
    except ValueError:
        pass
    chunks = s.split('</p>', n)
    n = len(chunks) - 1
    if n > 1:
        if len(chunks[-1]) < 400:
            return '</p>'.join(chunks[:n-1]+[aside+chunks[-2]]+chunks[-1:])
        return '</p>'.join(chunks[:n]+[aside+chunks[-1]])
    return aside + s
removenewscut.is_safe = True


@register.filter
def endtext(s, end_text='&nbsp;→'):
    s = force_unicode(s).strip()
    chunks = s.rpartition('</p>')
    if chunks[:2] != ('', ''):
        return chunks[0].rstrip() + '&nbsp;' + end_text + chunks[1] + chunks[2]
    return s.rstrip() + '&nbsp;' + end_text
endtext.is_safe = True


@register.filter
def pagination(pages, num):
    """
    Filter paginator page_range list to avoid long list

    page_range = [1,  2,  3,  [4,  5,  6,]  7,  8,  9, ->
                  head_offset   head_cut     left   #

               ->  10,  11,  [12,  13,  14],  15,  16,  17]
                   right       tail_cut       tail_offset
    """
    pages = list(pages)
    head_offset, head_cut, left, right, tail_cut, tail_offset = 3, 3, 2, 2, 3, 3
    # first cut tail
    if num + right + tail_cut + tail_offset <= len(pages):
        pages[num + right:-tail_offset] = [None]
        # then cut head
    if num > head_offset + head_cut + left:
        pages[head_offset:num - left - 1] = [None]
    return pages
pagination.is_safe = True


@register.simple_tag(takes_context=True)
def paginationquery(context):
    path_query = context['request'].GET.get('tag', False)
    return '?tag=%s&' % path_query if path_query else '?'


@register.simple_tag(takes_context=True)
def show_adminmenu(context, app_name=None, object_id=None):
    if 'SECOND_PASS_RENDER' not in context:
        if not context['request'].user.is_staff:
            return ''
        app_name = resolve(context['request'].path).namespace
        app_name, _, _ = app_name.partition(':')
        if app_name == 'news':
            app_name = 'articles'
        object_id = context['object'].id
        return mark_safe('{%% load news %%}{%% show_adminmenu "%s" %s %%}' % (app_name, object_id))
    try:
        model = app_name.rstrip('s')
        return render_to_string('common/templatetags/adminmenu.html', {'path': 'admin:%s_%s_change' % (app_name, model), 'object_id': object_id})
    except StandardError:
        return ''


def remove_tags(html, tags):
    """Returns the given HTML with given tags removed."""
    tags = [re.escape(tag) for tag in tags.split()]
    tags_re = '(%s)' % '|'.join(tags)
    starttag_re = re.compile(r'<%s(/?>|(\s+[^>]*>))' % tags_re, re.U)
    endtag_re = re.compile('</%s>' % tags_re)
    html = starttag_re.sub('', html)
    html = endtag_re.sub('', html)
    return html


@register.filter
def removetags(html, tags):
    return remove_tags(html, tags)
removetags.is_safe = True
