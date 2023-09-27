from django.contrib import admin
from .models import Cacti

# Register your models here.


@admin.register(Cacti)
class CactiAdmin(admin.ModelAdmin):
    readonly_fields = ["image_preview"]

    fields = [
        "name",
        "image",
    ]

    list_display = ["name", "image_preview"]

    search_fields = [
        "name",
    ]
