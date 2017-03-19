from django import template
from banner_adds.models import Banneradds


register = template.Library()


@register.inclusion_tag('banner_adds/banner_468x60.html')
def display_banner(args):
    res = Banneradds.objects.filter(slug=args)
    return {'obj': res[0]}

@register.inclusion_tag('banner_adds/banner_250.html')
def display_banner_square(args):
    res = Banneradds.objects.filter(slug=args)
    return {'obj': res[0]}

@register.inclusion_tag('banner_adds/banner_850x200.html')
def display_banner_footer(args):
    res = Banneradds.objects.filter(slug=args)
    return {'obj': res[0]}
