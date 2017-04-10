# coding: utf-8
from __future__ import unicode_literals

import os
import json

from django.conf import settings
from django.http import HttpResponse
from django.utils.http import urlunquote_plus
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.decorators import user_passes_test

from common.slugify import slugify


@user_passes_test(lambda u: u.is_authenticated() and u.is_staff and u.is_active)
@csrf_exempt
def upload_image(request):
    upload_directory = os.path.join(settings.MEDIA_ROOT, 'images', 'upload')
    allowed_extensions = ('.jpg', '.jpeg', '.png', '.gif')
    size_limit = 375767
    uploaded = request.read
    file_size = int(uploaded.im_self.META['CONTENT_LENGTH'])
    file_name = uploaded.im_self.META['HTTP_X_FILE_NAME']
    file_name = urlunquote_plus(file_name)
    file_content = uploaded(file_size)
    file_name, extension = os.path.splitext(file_name)
    extension = extension.lower()
    if extension in allowed_extensions:
        file_name = slugify(file_name) + extension
        if file_size <= size_limit:
            file_path = os.path.join(upload_directory, file_name)
            if not os.path.exists(file_path):
                with open(file_path, 'wb+') as f:
                    f.write(file_content)
            content = {'success': True}
        else:
            content = {'error': 'File is too large.'}
    else:
        content = {'error': 'File has an invalid extension.'}
    return HttpResponse(json.dumps(content), content_type='application/json')
