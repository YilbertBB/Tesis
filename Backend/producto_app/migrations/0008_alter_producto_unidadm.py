# Generated by Django 5.0.6 on 2024-06-16 15:18

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('producto_app', '0007_producto_unidadm_alter_producto_modelo_3d'),
    ]

    operations = [
        migrations.AlterField(
            model_name='producto',
            name='unidadM',
            field=models.CharField(choices=[('m', 'Metros'), ('in', 'Pulgadas'), ('cm', 'Centímetros')], default='metros', max_length=50),
        ),
    ]
