# coding: utf-8
from __future__ import unicode_literals

import os
from time import time
from hashlib import md5

from common.slugify import slugify


def upload_to(instance, filename):
    filename, ext = os.path.splitext(filename)
    filename = '.'.join((slugify(chunk) for chunk in filename.split('.')))
    if not filename:
        filename = md5(str(instance.pk) + str(time())).hexdigest()
    ext = ext.lower()
    if ext not in ('.jpg', '.jpeg', '.gif', '.png'):
        ext = '.unknown'
    slug = instance.category.slug
    count = 1
    while os.path.exists(os.path.join('images', slug, filename + ext)):
        filename, _, current = filename.rpartition('_')
        try:
            count = int(current) + 1
        except ValueError:
            pass
        filename += filename + '_' + count
        count += 1
    return os.path.join('images', slug, filename + ext)