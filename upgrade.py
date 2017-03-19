# coding: utf-8
from __future__ import unicode_literals

import pip
from subprocess import call

for dist in pip.get_installed_distributions():
    if dist.project_name in ('Django', 'distribute'):
        continue
    call('pip install --upgrade %s' % dist.project_name, shell=True)

#call("pip install -U git+https://github.com/django/django.git")

#call("curl -O https://raw.github.com/pypa/pip/master/contrib/get-pip.py")
#call("python get-pip.py")