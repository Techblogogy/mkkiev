# coding: utf-8
from __future__ import unicode_literals

import os
from random import choice, shuffle

from django.template import Library, Node, Context, Template, loader, TemplateSyntaxError
from django.conf import settings
from django.utils.safestring import mark_safe

from ..models import Banner, Category

register = Library()


##########
# Banner #
##########


class BannerNode(Node):
    def __init__(self, category, max_count, is_js):
        self.category = category
        self.max_count = max_count
        self.is_js = is_js

    def render_banner(self):
        if not self.banner.code:
            if self.banner.width is None:
                if self.banner.category.width is None:
                    self.banner.width = ''
                else:
                    self.banner.width = self.banner.category.width
            if self.banner.height is None:
                if self.banner.category.height is None:
                    self.banner.height = ''
                else:
                    self.banner.height = self.banner.category.height
            if os.path.splitext(self.banner.file.name)[1] == '.swf':
                t = loader.get_template('banners/flash_banner.html')
            else:
                t = loader.get_template('banners/image_banner.html')
            return t.render(Context({'object': self.banner, 'category': self.category}))
        else:
            t = Template(
                '<div id="banner-{{ id }}" class="js-banner" style="width:{{ width }}px;height:{{ height }}px;">%s</div>' % self.banner.code)
            return t.render(Context({
                'id': self.banner.id,
                'width': self.banner.width,
                'height': self.banner.height,
                'file': self.banner.file.url
            }))

    def render(self, context):
        if not self.category in context:
            query_set = Banner.objects.select_related()
            query_set = query_set.filter(activity=True, category__slug=self.category)
            query_set = query_set.order_by('ordering').iterator()
            context[self.category] = {'query_set': query_set}
        count = 0
        content = ''
        if 'query_set' not in context[self.category]:
            return ''
        if 'previous' not in context[self.category]:
            try:
                previous = context[self.category]['query_set'].next()
            except StopIteration:
                return ''
        else:
            previous = context[self.category]['previous']
        banners = [previous]
        while True:
            try:
                current = context[self.category]['query_set'].next()
            except StopIteration:
                current = False
            if current and previous and current.ordering == previous.ordering:
                banners.append(current)
            else:
                if self.is_js:
                    if len(banners) > 1:
                        is_first = True
                        content += '<div class="js-change_banner">'
                        shuffle(banners)
                        for banner in banners:
                            self.banner = banner
                            if is_first:
                                content += '<div>'
                                is_first = False
                            else:
                                content += '<div style="display:none">'
                            content += self.render_banner()
                            content += '</div>'
                        content += '</div>'
                    else:
                        self.banner = banners[0]
                        content += self.render_banner()
                else:
                    self.banner = choice(banners)
                    content += self.render_banner()
                banners = [current]
                if os.path.splitext(self.banner.file.name)[1] == '.swf' and not self.banner.code:
                    try:
                        context['banner'].append(self.banner.id)
                    except KeyError:
                        pass
                count += 1
                if not current:
                    context[self.category]['previous'] = previous
                    del context[self.category]['query_set']
                    break
                if self.max_count is not None and count >= self.max_count:
                    context[self.category]['previous'] = current
                    break
            previous = current
        return content


@register.tag
def show_banner(parser, token):
    args = token.split_contents()
    try:
        category = args[1]
    except IndexError:
        raise TemplateSyntaxError("%r tag requires at last one arguments" % args[0])
    try:
        try:
            max_count = int(args[2])
            if max_count <= 0:
                max_count = None
        except ValueError:
            raise TemplateSyntaxError("%r tag's second argument should be integer bigger or equal zero" % args[0])
    except IndexError:
        max_count = None
    try:
        is_js = args[3]
        is_js = True
    except IndexError:
        is_js = False

    return BannerNode(category.strip('"' + "'"), max_count, is_js)


################
# Banner Extra #
################


class BannerNodeExtra(Node):
    def __init__(self, category_slug):
        self.category_slug = category_slug
        self.banner = None

    def render_banner(self):
        if not self.banner.code:
            if self.banner.width is None or self.banner.height is None:
                self.banner.width = ''
                self.banner.height = ''
                try:
                    category = self.banner.categories.get(slug=self.category_slug, activity=True)
                    if category.width is not None:
                        self.banner.width = category.width
                    if category.height is not None:
                        self.banner.height = category.height
                except Category.DoesNotExist:
                    pass
            if os.path.splitext(self.banner.file.name)[1] == '.swf':
                t = loader.get_template('banners/flash_banner.html')
            else:
                t = loader.get_template('banners/image_banner.html')
            return t.render(Context({'object': self.banner}))
        else:
            t = Template('<div id="banner-{{ id }}" class="js-banner" style="width:{{ width }}px;height:{{ height }}px;">%s</div>' % self.banner.code)
            # t = Template('<div id="banner-{{ id }}" class="js-banner">%s</div>' % self.banner.code)
            return t.render(Context({'id': self.banner.id, 'width': self.banner.width, 'height': self.banner.height, 'file': self.banner.file.url}))
            # return t.render(Context({'id': self.banner.id, 'file': self.banner.file.url}))

    def render(self, context):
        try:
            category_slug = self.category_slug.resolve(context)
        except AttributeError:
            category_slug = self.category_slug
        banners = Banner.objects.filter(activity=True, categories__slug=category_slug).order_by("?")
        i = 0
        content = ''
        for banner in banners:
            self.banner = banner
            content += '<div>' if i == 0 else '<div style="display:none">'
            content += self.render_banner()
            content += '</div>'
            i += 1
        if i == 1:
            content = content[5:-6]
        elif i > 1:
            content = '<div class="js-change_banner">%s</div>' % (content,)
        else:
            content = ''
            
        return content


@register.tag
def show_banner_extra(parser, token):
    args = token.split_contents()

    print args

    try:
        category_slug = args[1]
    except IndexError:
        raise TemplateSyntaxError("%r tag requires at last one arguments" % args[0])

    category_slug = parser.compile_filter(category_slug)

    return BannerNodeExtra(category_slug)


####################
# Banner swfobject #
####################


@register.simple_tag(takes_context=True)
def show_banner_swfobject(context):
    s = ''
    try:
        for banner_id in context['banner']:
            s += 'swfobject.registerObject("swfobj-%s", "9.0.0");' % (banner_id,)
    except KeyError:
        pass
    return mark_safe('<script>%s</script>' % (s,))


#################
# Simple Banner #
#################


@register.simple_tag()
def show_simple_banner(src, href='', alt='', target='_blank'):
    return '<div class="js-banner"><a href="%s" target="%s" rel="nofollow"><img src="%s" alt="%s" /></a></div>' % (
        href, target, settings.MEDIA_URL + src, alt)
