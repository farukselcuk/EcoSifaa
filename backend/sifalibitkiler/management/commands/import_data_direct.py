from django.core.management.base import BaseCommand
from sifalibitkiler.models import Bitki, Karisim

class Command(BaseCommand):
    help = 'Bitkiler ve karışımlar verilerini doğrudan içeri aktarır'

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

    def handle(self, *args, **options):
        # Bitki verileri
        bitkiler_data = []
        
        bitki_adlari = [
            "Papatya", "Nane", "Zencefil", "Adaçayı", "Ihlamur", "Kekik", "Melisa", "Lavanta", "Rezene", "Çörek Otu",
            "Isırgan", "Anason", "Tarçın", "Karanfil", "Şerbetçi Otu", "Ekinezya", "Hibiskus", "Biberiye", "Yeşil Çay", "Yasemin",
            "Fesleğen", "Defne Yaprağı", "Ginseng", "Ardıç", "Limon Otu", "Aloe Vera", "Kuşburnu", "Zerdeçal", "Gül", "Kakule",
            "Hardal Tohumu", "Havuç Tohumu", "Kedi Otu", "Baldıran", "Sinameki", "Sığır Kuyruğu", "Altın Otu", "Çam Kozalağı", "Meşe Kabuğu", "Funda",
            "İncir Yaprağı", "Şeftali Yaprağı", "Yaban Mersini", "Ahududu", "Kiraz Sapı", "Kantaron", "Şimşir", "Kekreyemiş", "Kızılcık", "Pelin Otu"
        ]
        
        faydalar = [
            "Uyku problemleri, anksiyete", "Sindirim sorunları, mide bulantısı", "Mide bulantısı, iltihaplanma", "Boğaz ağrısı, enfeksiyon", 
            "Soğuk algınlığı, öksürük", "Bağışıklık sistemi, enfeksiyon", "Uyku düzeni, stres", "Rahatlama, stres", "Gaz sorunları, sindirim", "Bağışıklık, iltihaplanma",
            "Alerji, eklem ağrıları", "Gaz giderici, stres azaltıcı", "Kan şekeri düzenleme, bağışıklık", "Diş ağrısı, nefes tazeleme", "Uyku problemleri, stres", 
            "Bağışıklık güçlendirme", "Tansiyon düzenleme", "Hafıza güçlendirme", "Kilo kontrolü, antioksidan", "Stres azaltıcı, rahatlama",
            "Sindirim düzenleme", "Soğuk algınlığı, boğaz ağrısı", "Enerji artışı, bağışıklık", "İdrar söktürücü", "Stres, rahatlama", 
            "Cilt iyileşmesi, sindirim", "Bağışıklık, cilt sağlığı", "Bağışıklık sistemi", "Cilt sağlığı", "Sindirim düzenleme", 
            "Ağrı kesici", "Hormonal denge", "Uyku problemleri", "Ağrılar, kas spazmı", "Kabızlık", "Solunum yolları", "İltihap azaltıcı", "Deri hastalıkları", 
            "İdrar söktürücü", "Kan şekeri düzenleme", "Görme güçlendirme", "Bağışıklık sistemi", "Ödem atıcı", "Yanık tedavisi", "Antibakteriyel", "Kilo kontrolü", 
            "Bağışıklık güçlendirme", "Karaciğer sağlığı", "Karaciğer sağlığı"
        ]
        
        kullanim_durumlari = [
            "Rahatlama ve uyku için", "Sindirim bozukluklarında", "Bulantı sırasında", "Enfeksiyon riskinde", "Soğuk algınlığı belirtilerinde", 
            "Bağışıklık zayıflığında", "Stres altında", "Rahatlamak için", "Şişkinlik ve gaz şikayetlerinde", "Bağışıklık zayıflığında", 
            "Eklem ağrılarında", "Gaz problemlerinde", "Kan şekeri dalgalanmalarında", "Diş ağrısında", "Uyku sorunlarında", 
            "Bağışıklık zayıflığında", "Yüksek tansiyonda", "Zihinsel yorgunlukta", "Metabolizma hızlandırmak için", "Rahatlama ve stres yönetiminde", 
            "Sindirim kolaylaştırmada", "Boğaz ağrısında", "Enerji ihtiyacında", "Ödem sorunlarında", "Stres azaltmada", 
            "Cilt bakımında", "Soğuk algınlığında", "Bağışıklık güçlendirmede", "Cilt problemlerinde", "Sindirim desteğinde", 
            "Ağrı yönetiminde", "Hormonal dengeyi sağlamak için", "Uyku için", "Kas ağrılarında", "Kabızlık giderme", "Solunum desteğinde", 
            "İltihap kontrolü", "Cilt sağlığı", "İdrar söktürmek için", "Kan şekeri dengesinde", "Görme sağlığında", "Bağışıklık artırmada", 
            "Şişkinlik gidermede", "Yanık tedavilerinde", "Antiseptik amaçlarla", "Kilo kontrolünde", "Karaciğer fonksiyonlarını desteklemede",
            "Karaciğer fonksiyonlarını desteklemede", "Karaciğer fonksiyonlarını desteklemede"
        ]

        kullanim_alanlari = [
            "Çay olarak tüketilir", "Çay olarak tüketilir", "Çay olarak tüketilir", "Çay olarak tüketilir", "Çay olarak tüketilir",
            "Çay olarak tüketilir", "Çay olarak tüketilir", "Çay olarak tüketilir", "Çay olarak tüketilir", "Çay olarak tüketilir",
            "Çay olarak tüketilir", "Çay olarak tüketilir", "Çay olarak tüketilir", "Çay olarak tüketilir", "Çay olarak tüketilir",
            "Çay olarak tüketilir", "Çay olarak tüketilir", "Çay olarak tüketilir", "Çay olarak tüketilir", "Çay olarak tüketilir",
            "Çay olarak tüketilir", "Çay olarak tüketilir", "Çay olarak tüketilir", "Çay olarak tüketilir", "Çay olarak tüketilir",
            "Harici kullanım", "Çay olarak tüketilir", "Çay olarak tüketilir", "Çay olarak tüketilir", "Çay olarak tüketilir",
            "Çay olarak tüketilir", "Çay olarak tüketilir", "Çay olarak tüketilir", "Çay olarak tüketilir", "Çay olarak tüketilir",
            "Çay olarak tüketilir", "Çay olarak tüketilir", "Çay olarak tüketilir", "Çay olarak tüketilir", "Çay olarak tüketilir",
            "Çay olarak tüketilir", "Çay olarak tüketilir", "Çay olarak tüketilir", "Çay olarak tüketilir", "Çay olarak tüketilir",
            "Çay olarak tüketilir", "Çay olarak tüketilir", "Çay olarak tüketilir", "Çay olarak tüketilir", "Çay olarak tüketilir"
        ]
        
        hazirlama_sekilleri = [
            "1 çay kaşığı çiçek, sıcak suya demlenir.", "2-3 yaprak taze veya kuru çay yapılır.", "1 dilim taze zencefil, kaynar suya eklenir.", 
            "1 tatlı kaşığı kuru yaprak, sıcak suya eklenir.", "1 tatlı kaşığı çiçek, 200 ml suyla demlenir.", 
            "1 çay kaşığı kuru ot, sıcak suyla demlenir.", "1 tatlı kaşığı kuru yaprak, sıcak suyla demleme.", "Bir tutam kuru çiçek, sıcak suda demlenir.", 
            "1 tatlı kaşığı tohum, sıcak suda bekletilir.", "1 tatlı kaşığı tohum, sıcak suyla karıştırılır.", 
            "1 tatlı kaşığı kuru yaprak, sıcak suda demlenir.", "1 tatlı kaşığı tohum, sıcak suda kaynatılır.", "1 çubuk tarçın, kaynar suya eklenir.", 
            "3-4 karanfil, sıcak suya demlenir.", "1 tatlı kaşığı kuru ot, sıcak suya eklenir.", "1 tatlı kaşığı çay, kaynar suda bekletilir.", 
            "1 çorba kaşığı kuru çiçek, sıcak suda bekletilir.", "2-3 dal taze yaprak, sıcak suyla demlenir.", "1 tatlı kaşığı kuru çay, sıcak suyla demlenir.", 
            "1 tatlı kaşığı kuru çiçek, sıcak suyla bekletilir.", "2-3 yaprak taze fesleğen, çay olarak hazırlanır.", 
            "1-2 yaprak kuru defne, çay olarak demlenir.", "1 tatlı kaşığı toz kök, sıcak suya karıştırılır.", "1 tatlı kaşığı kuru meyve, sıcak suyla bekletilir.", 
            "1 tatlı kaşığı kuru ot, sıcak suda bekletilir.", "1 tatlı kaşığı jel, doğrudan uygulanır.", "1 tatlı kaşığı kuru meyve, sıcak suyla demlenir.", 
            "1 çay kaşığı toz, sıcak suyla karıştırılır.", "1 tatlı kaşığı kuru yaprak, sıcak suyla demlenir.", "2-3 çekirdek, kaynar suya eklenir.", 
            "1 tatlı kaşığı toz, sıcak suyla karıştırılır.", "1 tatlı kaşığı tohum, sıcak suya karıştırılır.", "1 tatlı kaşığı kuru ot, çay olarak hazırlanır.", 
            "1 tatlı kaşığı kök, sıcak suya karıştırılır.", "1 tatlı kaşığı toz, sıcak suyla bekletilir.", "1 tatlı kaşığı çiçek, sıcak suda kaynatılır.", 
            "1 tatlı kaşığı kuru ot, çay yapılır.", "1 tatlı kaşığı kuru kozalak, sıcak suda bekletilir.", "1 tatlı kaşığı toz, sıcak suyla demlenir.", 
            "1 tatlı kaşığı kuru yaprak, sıcak suyla bekletilir.", "1 tatlı kaşığı kuru yaprak, sıcak suyla demlenir.", "1 tatlı kaşığı kuru meyve, sıcak suyla bekletilir.", 
            "1 tatlı kaşığı kuru yaprak, sıcak suyla demlenir.", "1 tatlı kaşığı kuru yaprak, sıcak suyla hazırlanır.", "1 tatlı kaşığı çiçek, sıcak suda bekletilir.", 
            "1 tatlı kaşığı kuru yaprak, sıcak suya eklenir.", "1 tatlı kaşığı kuru yaprak, sıcak suyla hazırlanır.", "1 tatlı kaşığı kuru meyve, sıcak suya eklenir.", 
            "1 tatlı kaşığı kuru ot, sıcak suda bekletilir.", "1 tatlı kaşığı kuru ot, sıcak suda bekletilir.", "1 tatlı kaşığı kuru ot, sıcak suda bekletilir."
        ]

        for i in range(len(bitki_adlari)):
            bitkiler_data.append({
                'isim': bitki_adlari[i],
                'tip': self._belirle_bitki_tipi(bitki_adlari[i]),
                'faydalar': faydalar[i],
                'kullanim': kullanim_durumlari[i],
                'kullanim_alani': kullanim_alanlari[i],
                'hazirlama': hazirlama_sekilleri[i],
            })

        # Karışım verileri
        karisimlar_data = [
            {
                'isim': 'Bal + Su',
                'faydalar': 'Sindirim düzenleme, enerji artırma',
                'kullanim_durumu': 'Sabahları enerji artırmak için',
                'hazirlama': '1 tatlı kaşığı bal, 1 bardak ılık suyla karıştırılır ve sabah içilir.'
            },
            {
                'isim': 'Limon + Pekmez',
                'faydalar': 'Bağışıklık güçlendirme, enerji artışı',
                'kullanim_durumu': 'Enerji ihtiyacında',
                'hazirlama': '1 tatlı kaşığı pekmez, yarım limon suyu ile karıştırılır ve aç karnına içilir.'
            },
            {
                'isim': 'Maydanoz Kürü',
                'faydalar': 'Karaciğer temizleme, ödem atıcı',
                'kullanim_durumu': 'Karaciğer sağlığını desteklemek için',
                'hazirlama': '1 demet maydanoz, 1 bardak su ile blenderda karıştırılıp sabah içilir.'
            },
            {
                'isim': 'Zerdeçal + Bal',
                'faydalar': 'Bağışıklık artırıcı, iltihap azaltıcı',
                'kullanim_durumu': 'Bağışıklık zayıflığında',
                'hazirlama': '1 tatlı kaşığı bal, yarım çay kaşığı toz zerdeçal ile karıştırılarak tüketilir.'
            },
            {
                'isim': 'Elma Sirkesi + Su',
                'faydalar': 'Metabolizma hızlandırma, kan şekeri dengeleme',
                'kullanim_durumu': 'Kilo vermek veya enerji artırmak için',
                'hazirlama': '1 tatlı kaşığı elma sirkesi, 1 bardak suya eklenip yemeklerden önce içilir.'
            },
            {
                'isim': 'Tarçın + Bal',
                'faydalar': 'Bağışıklık artırıcı, boğaz ağrısı giderici',
                'kullanim_durumu': 'Boğaz ağrılarında',
                'hazirlama': '1 tatlı kaşığı bal, 1 çay kaşığı toz tarçın ile karıştırılarak tüketilir.'
            },
            {
                'isim': 'Zencefil + Limon',
                'faydalar': 'Mide rahatlatıcı, bağışıklık artırıcı',
                'kullanim_durumu': 'Soğuk algınlığı belirtilerinde',
                'hazirlama': '1 dilim taze zencefil ve 1 dilim limon, 1 bardak sıcak suda demlenir.'
            },
            {
                'isim': 'Sarımsak + Bal',
                'faydalar': 'Soğuk algınlığına karşı koruma',
                'kullanim_durumu': 'Hastalıklardan korunmak için',
                'hazirlama': '1 diş ezilmiş sarımsak, 1 tatlı kaşığı bal ile karıştırılarak tüketilir.'
            },
            {
                'isim': 'Keten Tohumu + Yoğurt',
                'faydalar': 'Bağırsak sağlığı, sindirim düzenleme',
                'kullanim_durumu': 'Sindirim problemlerinde',
                'hazirlama': '1 tatlı kaşığı öğütülmüş keten tohumu, 1 kase yoğurtla karıştırılarak yenir.'
            },
            {
                'isim': 'Havuç Suyu + Zencefil',
                'faydalar': 'Bağışıklık güçlendirme, enerji artışı',
                'kullanim_durumu': 'Bağışıklık zayıflığında',
                'hazirlama': '1 bardak taze havuç suyu, yarım çay kaşığı rendelenmiş zencefil ile karıştırılır.'
            },
            {
                'isim': 'Karanfil + Su',
                'faydalar': 'Ağız kokusu giderici, sindirim düzenleyici',
                'kullanim_durumu': 'Ağız hijyenini sağlamak için',
                'hazirlama': '5-6 karanfil, 1 bardak sıcak suda 10 dakika bekletilir ve içilir.'
            },
            {
                'isim': 'Adaçayı + Limon',
                'faydalar': 'Soğuk algınlığı, boğaz rahatlatıcı',
                'kullanim_durumu': 'Soğuk algınlığı belirtilerinde',
                'hazirlama': '1 tatlı kaşığı adaçayı, 1 dilim limon ile 200 ml sıcak suda demlenir.'
            },
            {
                'isim': 'Rezene + Anason',
                'faydalar': 'Gaz giderici, rahatlatıcı',
                'kullanim_durumu': 'Gaz ve şişkinlik problemlerinde',
                'hazirlama': '1 tatlı kaşığı rezene ve anason, 1 bardak sıcak suda 10 dakika bekletilir.'
            },
            {
                'isim': 'Ihlamur + Bal',
                'faydalar': 'Soğuk algınlığı, öksürük rahatlatıcı',
                'kullanim_durumu': 'Öksürük ve balgam söktürücü olarak',
                'hazirlama': '1 tatlı kaşığı ıhlamur, 1 bardak sıcak suya bal eklenerek demlenir.'
            },
            {
                'isim': 'Nane + Limon',
                'faydalar': 'Bulantı giderici, bağışıklık güçlendirme',
                'kullanim_durumu': 'Mide rahatlatmak için',
                'hazirlama': '1 tatlı kaşığı kuru nane, 1 dilim limon ile sıcak suda kaynatılır.'
            },
            {
                'isim': 'Kuşburnu + Tarçın',
                'faydalar': 'C vitamini takviyesi, bağışıklık artırıcı',
                'kullanim_durumu': 'Bağışıklık güçlendirmek için',
                'hazirlama': '1 tatlı kaşığı kuşburnu, 1 çubuk tarçın ile sıcak suda demlenir.'
            },
            {
                'isim': 'Hibiskus + Elma Suyu',
                'faydalar': 'Tansiyon düzenleme, enerji artırıcı',
                'kullanim_durumu': 'Enerji artırmak için',
                'hazirlama': '1 tatlı kaşığı hibiskus, 1 bardak elma suyuna eklenip bekletilir.'
            },
            {
                'isim': 'Biberiye + Bal',
                'faydalar': 'Hafıza güçlendirme, bağışıklık artırıcı',
                'kullanim_durumu': 'Zihinsel yorgunluğu gidermek için',
                'hazirlama': '1 tatlı kaşığı biberiye, 1 tatlı kaşığı bal ile karıştırılarak tüketilir.'
            },
            {
                'isim': 'Kekik + Limon',
                'faydalar': 'Soğuk algınlığı, solunum rahatlatıcı',
                'kullanim_durumu': 'Soğuk algınlığı durumunda',
                'hazirlama': '1 tatlı kaşığı kuru kekik, yarım limon suyu ile sıcak suda demlenir.'
            },
            {
                'isim': 'Lavanta + Süt',
                'faydalar': 'Uyku düzenleme, sinir yatıştırıcı',
                'kullanim_durumu': 'Uyku öncesi rahatlamak için',
                'hazirlama': '1 tatlı kaşığı kuru lavanta, 1 bardak ılık sütle karıştırılarak içilir.'
            }
        ]

        # Bitkileri veritabanına ekle
        for bitki_data in bitkiler_data:
            bitki, created = Bitki.objects.get_or_create(
                isim=bitki_data['isim'],
                defaults={
                    'tip': bitki_data['tip'],
                    'faydalar': bitki_data['faydalar'],
                    'kullanim': bitki_data['kullanim'],
                    'kullanim_alani': bitki_data['kullanim_alani'],
                    'hazirlama': bitki_data['hazirlama'],
                }
            )
            if created:
                self.stdout.write(self.style.SUCCESS(f'Bitki eklendi: {bitki.isim}'))
            else:
                self.stdout.write(self.style.WARNING(f'Bitki zaten mevcut: {bitki.isim}'))

        # Karışımları veritabanına ekle
        for karisim_data in karisimlar_data:
            karisim, created = Karisim.objects.get_or_create(
                isim=karisim_data['isim'],
                defaults={
                    'faydalar': karisim_data['faydalar'],
                    'kullanim_durumu': karisim_data['kullanim_durumu'],
                    'hazirlama': karisim_data['hazirlama'],
                }
            )
            
            # Karışımdaki bitkileri bul ve ekle
            bitki_isimleri = karisim_data['isim'].split(' + ')
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