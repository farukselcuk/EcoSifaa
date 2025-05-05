from django.core.management.base import BaseCommand
from django.utils.text import slugify
from sifalibitkiler.models import Bitki, Karisim
import pandas as pd
import os

class Command(BaseCommand):
    help = 'Bitkiler ve karışımlar verilerini içeri aktarır'

    def handle(self, *args, **options):
        # Bitkiler verilerini oku
        bitkiler_path = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(__file__)))), 'Bitkiler.txt')
        with open(bitkiler_path, 'r', encoding='utf-8') as f:
            bitkiler_content = f.read()
        
        # Karışımlar verilerini oku
        karisimlar_path = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(__file__)))), 'Karışımlar.txt')
        with open(karisimlar_path, 'r', encoding='utf-8') as f:
            karisimlar_content = f.read()

        # Bitkiler verilerini işle
        exec(bitkiler_content)
        bitkiler_df = locals()['df']

        # Karışımlar verilerini işle
        exec(karisimlar_content)
        karisimlar_df = locals()['mixture_df']

        # Bitkileri veritabanına ekle
        for _, row in bitkiler_df.iterrows():
            bitki_tipi = self._belirle_bitki_tipi(row['Bitki Adı'])
            bitki, created = Bitki.objects.get_or_create(
                isim=row['Bitki Adı'],
                defaults={
                    'tip': bitki_tipi,
                    'faydalar': row['İyi Geldiği Hastalıklar'],
                    'kullanim': row['Kullanım Durumu'],
                    'hazirlama': row['Kullanım Şekli ve Dozu'],
                }
            )
            if created:
                self.stdout.write(self.style.SUCCESS(f'Bitki eklendi: {bitki.isim}'))
            else:
                self.stdout.write(self.style.WARNING(f'Bitki zaten mevcut: {bitki.isim}'))

        # Karışımları veritabanına ekle
        for _, row in karisimlar_df.iterrows():
            karisim, created = Karisim.objects.get_or_create(
                isim=row['Karışım Adı'],
                defaults={
                    'faydalar': row['Faydaları'],
                    'kullanim_durumu': row['Kullanım Durumu'],
                    'hazirlama': row['Kullanım Şekli ve Dozu'],
                }
            )
            
            # Karışımdaki bitkileri bul ve ekle
            bitki_isimleri = row['Karışım Adı'].split(' + ')
            for bitki_ismi in bitki_isimleri:
                try:
                    bitki = Bitki.objects.get(isim__icontains=bitki_ismi.strip())
                    karisim.bitkiler.add(bitki)
                except Bitki.DoesNotExist:
                    self.stdout.write(self.style.WARNING(f'Bitki bulunamadı: {bitki_ismi}'))
            
            if created:
                self.stdout.write(self.style.SUCCESS(f'Karışım eklendi: {karisim.isim}'))
            else:
                self.stdout.write(self.style.WARNING(f'Karışım zaten mevcut: {karisim.isim}'))

    def _belirle_bitki_tipi(self, isim):
        isim = isim.lower()
        if any(kelime in isim for kelime in ['otu', 'çayı']):
            return 'ot'
        elif any(kelime in isim for kelime in ['ağacı', 'kabuğu']):
            return 'agac'
        elif any(kelime in isim for kelime in ['çiçeği', 'çiçek']):
            return 'cicek'
        elif any(kelime in isim for kelime in ['meyvesi', 'meyve']):
            return 'meyve'
        elif any(kelime in isim for kelime in ['kökü', 'kök']):
            return 'kök'
        elif any(kelime in isim for kelime in ['tohumu', 'tohum']):
            return 'tohum'
        elif any(kelime in isim for kelime in ['yaprağı', 'yaprak']):
            return 'yaprak'
        else:
            return 'diger' 