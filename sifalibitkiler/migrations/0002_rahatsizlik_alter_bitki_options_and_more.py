# Generated by Django 5.1.7 on 2025-03-22 17:13

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('sifalibitkiler', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Rahatsizlik',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('isim', models.CharField(max_length=100)),
                ('aciklama', models.TextField(blank=True)),
                ('olusturulma_tarihi', models.DateTimeField(auto_now_add=True)),
                ('guncellenme_tarihi', models.DateTimeField(auto_now=True)),
            ],
            options={
                'verbose_name': 'Rahatsızlık',
                'verbose_name_plural': 'Rahatsızlıklar',
            },
        ),
        migrations.AlterModelOptions(
            name='bitki',
            options={'verbose_name': 'Bitki', 'verbose_name_plural': 'Bitkiler'},
        ),
        migrations.RenameField(
            model_name='bitki',
            old_name='guncelleme_tarihi',
            new_name='guncellenme_tarihi',
        ),
        migrations.RenameField(
            model_name='bitki',
            old_name='olusturma_tarihi',
            new_name='olusturulma_tarihi',
        ),
        migrations.AlterField(
            model_name='bitki',
            name='doz',
            field=models.TextField(),
        ),
        migrations.RemoveField(
            model_name='bitki',
            name='rahatsizliklar',
        ),
        migrations.AlterField(
            model_name='bitki',
            name='tip',
            field=models.CharField(choices=[('tekli', 'Tekli Bitki'), ('karisim', 'Karışım')], max_length=10),
        ),
        migrations.AddField(
            model_name='bitki',
            name='rahatsizliklar',
            field=models.ManyToManyField(related_name='bitkiler', to='sifalibitkiler.rahatsizlik'),
        ),
    ]
