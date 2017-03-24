from django.shortcuts import render

from banner_adds.models import Banneradds

def render_banners():

    entries = Banneradds.objects.all()
    print entries
