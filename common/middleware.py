# coding: utf-8
from __future__ import unicode_literals

import re
from django import template
from django.middleware import cache
from django.utils.cache import patch_response_headers, add_never_cache_headers, get_max_age, learn_cache_key, has_vary_header

second_pass_re = re.compile(r'\{\%[^%]*\%\}')


class SecondPassRenderMiddleware(object):
    """Template second pass renderer middleware"""

    def process_response(self, request, response):
        if request.path.startswith('/admin/') or request.path.startswith('/sitemap'):
            return response
        if response.streaming or response.status_code != 200:
            return response
        if response.has_header('content-type') and not response['content-type'].startswith("text/html"):
            return response
        try:
            c = template.Context({'SECOND_PASS_RENDER': True})
            t = template.Template(response.content)
            response.content = t.render(c)
        except StandardError:
            pass #response.content = second_pass_re.sub('', response.content)
        return response


class UpdateCacheMiddleware(cache.UpdateCacheMiddleware):

    def process_response(self, request, response):
        if not self._should_update_cache(request, response):
            return response

        if response.streaming or response.status_code != 200:
            return response

        if not request.COOKIES and response.cookies and has_vary_header(response, 'Cookie'):
            return response

        if (request.path.startswith('/admin/') or request.path.startswith('/sitemap') or
                request.path[-12:] == '/rss/yandex/' or request.path == 'sidebar.json'):
            return response

        timeout = get_max_age(response)
        if timeout is None:
            timeout = self.cache_timeout
        elif timeout == 0:
            return response
        #patch_response_headers(response, 5)
        if timeout:
            cache_key = learn_cache_key(request, response, timeout, self.key_prefix, cache=self.cache)
            if hasattr(response, 'render') and callable(response.render):
                response.add_post_render_callback(lambda r: self.cache.set(cache_key, r, timeout))
            else:
                self.cache.set(cache_key, response, timeout)
        return response


class FetchFromCacheMiddleware(cache.FetchFromCacheMiddleware):
    def process_request(self, request):
        if (request.path.startswith('/admin/') or request.path.startswith('/sitemap')
                or request.path[-12:] == '/rss/yandex/' or request.path == 'sidebar.json'):
            return None
        return super(FetchFromCacheMiddleware, self).process_request(request)
