from django import template
from annons.models import Annons

register = template.Library()


@register.inclusion_tag('annons/block.html')
def display_block():
    res = Annons.objects.all()
    return {'objs': res}
