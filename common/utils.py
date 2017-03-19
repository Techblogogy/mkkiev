# coding: utf-8
from __future__ import unicode_literals

from django.contrib.sites.models import Site
from django.utils.cache import cc_delim_re


def drop_vary_headers(response, headers_to_drop):
    """
    Remove an item from the "Vary" header of an ``HttpResponse`` object.
    If no items remain, delete the "Vary" header.
    This does the opposite effect of django.utils.cache.patch_vary_headers.
    """
    if response.has_header('Vary'):
        vary_headers = cc_delim_re.split(response['Vary'])
    else:
        vary_headers = []

    headers_to_drop = [header.lower() for header in headers_to_drop]

    updated_vary_headers = []
    for header in vary_headers:
        if len(header):
            if header.lower() not in headers_to_drop:
                updated_vary_headers.append(header)

    if len(updated_vary_headers):
        response['Vary'] = ', '.join(updated_vary_headers)
    else:
        del response['Vary']


def get_current_site():
    return 1  # Site.objects.get_current()
