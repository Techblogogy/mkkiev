# coding: utf-8
from __future__ import unicode_literals

import os
from urlparse import parse_qs, urlsplit

from django.template import Library
from django.utils.html import format_html

from ..models import VideoGallery


register = Library()


@register.simple_tag()
def show_video(url, width=305):
    url_parts = urlsplit(str(url))
    if url_parts.scheme != 'http' and url_parts.scheme != 'https':
        return url
    if url_parts.netloc == 'www.dailymotion.com':
        height = int(width/(16/9.))
        key = os.path.relpath(url_parts.path, '/video').split('_', 1)[0]
        return format_html('<iframe frameborder="0" width="{}" height="{}" src="http://www.dailymotion.com/embed/video/{}?theme=denim&foreground=#92ADE0&highlight=#A2ACBF&background=#202226"></iframe>', width, height, key)
    elif url_parts.netloc == "www.metacafe.com":
        height = int(width/(16/9.))
        key = os.path.relpath(url_parts.path, '/watch').split('/', 1)[0]
        src = str(url).replace('/watch/','/fplayer/').rstrip('/')+'.swf'
        return format_html('<embed flashVars="playerVars=autoPlay=no" width="{}" height="{}" src="{}" wmode="transparent" allowFullScreen="true" allowScriptAccess="always" name="Metacafe_{}" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash"></embed>', width, height, src, key)
    elif url_parts.netloc == 'www.youtube.com':
        height = int(width/(16/9.))
        key = url_parts.query.lstrip('v=')
        return format_html('<iframe width="{}" height="{}" src="http://www.youtube.com/embed/{}" frameborder="0" allowfullscreen></iframe>', width, height, key)
    elif url_parts.netloc == 'video.yahoo.com':
        height = int(width/(16/9.))
        key = url_parts.path.split('/')[3]
        return format_html('<object width="{}" height="{}"><param name="movie" value="http://d.yimg.com/nl/vyc/site/player.swf"></param><param name="wmode" value="opaque"></param><param node="allowFullScreen" value="true"></param><param name="flashVars" value="vid={}&amp;lang=en-US"></param><embed width="443" height="249" src="http://d.yimg.com/nl/vyc/site/player.swf" type="application/x-shockwave-flash" flashvars="vid={}&amp;autoPlay=true&amp;volume=100&amp;enableFullScreen=1&amp;lang=en-US"></embed></object>', width, height, key, key)
    elif url_parts.netloc == 'rutube.ru':
        # http://rutube.ru/tracks/4919735.html?v=592d15e9c4614604eb98ba6836d53c09
        height = int(width/(16/9.))
        qs = parse_qs(url_parts.query)
        key = qs['v'][0]
        return format_html('<object width="{}" height="{}"><param name="movie" value="http://video.rutube.ru/{}"></param><param name="wmode" value="window"></param><param name="allowFullScreen" value="true"></param><embed width="{}" height="{}" src="http://video.rutube.ru/{}" type="application/x-shockwave-flash" wmode="window" allowFullScreen="true" ></embed></object>', width, height, key, width, height, key)
    elif url_parts.netloc == 'twitter.com':
        # https://twitter.com/DuncanCStone/status/665957265392975872
        key = os.path.relpath(url_parts.path, '/watch').rsplit('/', 1)[1]
        return format_html('<div id="twttr{}"></div><script>window.twttr=(function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],t=window.twttr||{};if(d.getElementById(id))return t;js=d.createElement(s);js.id=id;js.src="https://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js, fjs);t._e=[];t.ready=function(f) {t._e.push(f);};return t;}(document,"script","twitter-wjs"));twttr.ready(function(twttr){twttr.widgets.createTweet("{}",document.getElementById("twttr{}"))});</script>', key, key, key)
    return url


@register.inclusion_tag('videogallery/templatetags/videogallery.html')
def show_videogallery():
    return {'object': VideoGallery.objects.filter(activity=True).latest()}
