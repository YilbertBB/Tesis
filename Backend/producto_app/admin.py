from django.contrib import admin
from .models import Categoria, Producto, Entidad
from django.db import models

# Register your models here.
admin.site.register(Categoria)
admin.site.register(Entidad)
admin.site.register(Producto)