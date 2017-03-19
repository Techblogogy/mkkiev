# coding: utf-8
from __future__ import unicode_literals

import os
from urlparse import urlsplit, urlunsplit
from hashlib import md5
from PIL import Image, ImageFilter

from django.conf import settings
from django.template import Library, TemplateSyntaxError, Node

register = Library()


def do_image(path, root, url, thumb_width, thumb_height, thumb_type=None, is_filtered=False, thumb_name='cache'):
    if not os.path.exists(path):
        return url
    thumb_type = str(thumb_width) + 'x' + str(thumb_height) if thumb_type is None else str(thumb_type)
    thumb_width, thumb_height = int(thumb_width), int(thumb_height)
    if urlsplit(path).scheme:
        image_file = md5(path).hexdigest() + os.path.splitext(path)[1]
        image_dir = 'images'
    else:
        image_dir, image_file = os.path.split(path)
        media_root = settings.MEDIA_ROOT if not root else root
        image_dir = os.path.relpath(image_dir, media_root)
    thumb_dir = os.path.join(settings.MEDIA_ROOT, thumb_name, thumb_type, image_dir)
    if not os.path.exists(thumb_dir):
        try:
            os.makedirs(thumb_dir)
        except OSError:
            return url
    thumb_path = os.path.join(thumb_dir, image_file)
    if os.path.exists(thumb_path) and os.path.getmtime(path) > os.path.getmtime(thumb_path):
        try:
            os.unlink(thumb_path)
        except OSError:
            pass
    if not os.path.exists(thumb_path):
        try:
            image = Image.open(path)
        except IOError:
            return url
        if is_filtered:
            try:
                image = image.filter(ImageFilter.DETAIL)
            except ValueError:
                pass
        image_width, image_height = image.size
        image_ratio = image_width / float(image_height)
        thumb_ratio = thumb_width / float(thumb_height)
        if thumb_ratio < image_ratio:
            crop_width = int(image_height * thumb_ratio)
            crop_height = image_height
            offset_width = int((image_width - crop_width) / 2.)
            offset_height = 0
        else:
            crop_width = image_width
            crop_height = int(crop_width / thumb_ratio)
            offset_width = 0
            offset_height = int((image_height - crop_height) / 2.)
        try:
            image = image.crop((offset_width, offset_height, offset_width + crop_width, offset_height + crop_height))
        except IOError:
            return url
        image = image.resize((thumb_width, thumb_height), Image.ANTIALIAS)
        try:
            image.save(thumb_path, image.format)
        except KeyError:
            return url
    media_url_len = len(settings.MEDIA_URL)
    return url[:media_url_len] + os.path.join(thumb_name, thumb_type) + '/' + url[media_url_len:]


def parse_thumb_setting(thumb_width):
    if not thumb_width:
        return
    thumb = getattr(settings, 'THUMBS', False)
    if not thumb:
        return
    ratio = thumb.get('default_ratio', 4 / 3.)
    line_height = thumb.get('line_height', 18.)
    width, height, is_filtered, force = False, False, False, False
    if 'sizes' in thumb:
        key = str(thumb_width)
        if key in thumb['sizes']:
            width = thumb['sizes'][key].get('width', False)
            if width:
                try:
                    width = int(width)
                except ValueError:
                    raise TemplateSyntaxError("Can't define image thumb width '%s'" % width)
            height = thumb['sizes'][key].get('height', False)
            if height:
                try:
                    height = int(height)
                except ValueError:
                    raise TemplateSyntaxError("Can't define image thumb height '%s'" % height)
            if not height:
                temp_ratio = thumb['sizes'][key].get('ratio', False)
                if temp_ratio:
                    try:
                        ratio = float(temp_ratio)
                    except ValueError:
                        raise TemplateSyntaxError("Can't define image thumb ratio '%s'" % ratio)
            is_filtered = thumb['sizes'][key].get('is_filtered', False)
            if is_filtered:
                try:
                    is_filtered = bool(is_filtered)
                except ValueError:
                    raise TemplateSyntaxError("Can't define image thumb is_filtered '%s'" % is_filtered)
            force = thumb['sizes'][key].get('force', False)
            if force:
                try:
                    force = bool(force)
                except ValueError:
                    raise TemplateSyntaxError("Can't define image thumb force '%s'" % force)
    if not width:
        try:
            width = int(thumb_width)
        except ValueError:
            raise TemplateSyntaxError("Can't define image thumb width '%s'" % thumb_width)
    if width <= 0:
        return
    if not height:
        height = width / ratio
        remainder = height % line_height
        if remainder > line_height / 2. or force:
            height = int(height + line_height - remainder)
        else:
            height = int(height - remainder)
    return width, height, is_filtered


def do_thumb(image_object, thumb_width=None):
    try:
        path, url = image_object.path, image_object.url
    except (AttributeError, ValueError):
        path, url = '', ''
    try:
        width, height, is_filtered = parse_thumb_setting(thumb_width)
    except (ValueError, TypeError):
        return url
    else:
        try:
            root = image_object.root
        except (AttributeError, ValueError):
            root = ''
        return do_image(path, root, url, width, height, thumb_width, is_filtered)


@register.filter
def media(image_object, media):
    if media:
        class File:
            def __init__(self, path, url, root):
                self.path, self.url, self.root = str(path), str(url), str(root)
        path = os.path.relpath(getattr(image_object, 'path', ''), settings.MEDIA_ROOT)
        path = os.path.join(media['root'], path)
        url_parts = list(urlsplit(getattr(image_object, 'url', '')))
        url_parts[1] = urlsplit(media['url']).netloc
        url = urlunsplit(url_parts)
        return File(path, url, media['root'])
    return image_object


class ImageNode(Node):
    def __init__(self, nodelist, image_object, thumb_width):
        self.nodelist = nodelist
        self.image_object = image_object
        self.thumb_width = thumb_width

    def render(self, context):
        image_object = self.image_object.resolve(context)
        try:
            thumb_width = self.thumb_width.resolve(context).strip('\'"')
        except AttributeError:
            thumb_width = self.thumb_width
        width, height = '', ''
        try:
            path, url = image_object.path, image_object.url
        except (AttributeError, ValueError):
            path, url = '', ''
        else:
            try:
                width, height = image_object.width, image_object.height
            except (AttributeError, TypeError, ValueError, IOError):
                pass
        try:
            width, height, is_filtered = parse_thumb_setting(thumb_width)
        except (ValueError, TypeError):
            src = url
        else:
            try:
                root = image_object.root
            except (AttributeError, ValueError):
                root = ''
            src = do_image(path, root, url, width, height, thumb_width, is_filtered)
        context['src'] = src
        context['width'] = width
        context['height'] = height
        return self.nodelist.render(context).strip()


@register.tag
def image(parser, token):
    bits = token.contents.split()
    if len(bits) < 2:
        raise TemplateSyntaxError("'%s' takes at least one argument (file object)" % bits[0])
    image_object = parser.compile_filter(bits[1])
    try:
        thumb_width = parser.compile_filter(bits[2])
    except IndexError:
        thumb_width = None
    nodelist = parser.parse(('endimage',))
    parser.delete_first_token()
    return ImageNode(nodelist, image_object, thumb_width)