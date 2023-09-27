from django.db import models
from django.utils.html import mark_safe

# Create your models here.


class Cacti(models.Model):
    name = models.CharField(max_length=30, default="Olea Brassica" )
    image = models.ImageField(upload_to="images/")
    



    class Meta:
        verbose_name = "cactus"
        verbose_name_plural = "cacti"

    def __str__(self):
        return self.name

    def image_preview(self): #new
        return mark_safe(f'<img src = "{self.image.url}" width = "150" />')