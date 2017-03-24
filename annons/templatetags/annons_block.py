from django import template
from annons.models import Annons

register = template.Library()


@register.inclusion_tag('annons/block.html')
def display_block():
    res = Annons.objects.all()#.values()

    # print res

    # cnt = 0
    # for r in res:
    #     cnt +=1
    #
    #     if (cnt > 3):
    #         r["display"] = "none"
    #     else:
    #         r["display"] = "block"

    return {'objs': res}
