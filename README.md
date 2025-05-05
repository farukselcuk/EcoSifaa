# EcoSifaa - Şifalı Bitkiler Uygulaması

Şifalı bitkiler veritabanı ve rehberi - Web, Mobil ve PWA uygulaması.

## Proje Yapısı

```
/ecosifaa
│
├── /api              - Django REST API
│   ├── /ecosifa      - Django proje ana klasörü
│   ├── /sifalibitkiler - Ana Django uygulaması
│   ├── manage.py     - Django yönetim aracı
│   └── requirements.txt - Python bağımlılıkları
│
├── /web              - Web uygulaması (HTML, CSS, JS)
│   ├── index.html    - Ana sayfa
│   ├── styles.css    - Stil dosyası
│   ├── script.js     - JavaScript kodları
│   ├── manifest.json - PWA yapılandırması
│   └── service-worker.js - PWA service worker
│
└── /mobile           - Flutter mobil uygulaması
    └── /ecosifaa_app - Flutter projesi
        ├── lib/      - Dart kodları
        ├── assets/   - Resim ve diğer dosyalar
        └── pubspec.yaml - Flutter bağımlılıkları
```

## Kurulum

### API (Backend)

```bash
cd api
pip install -r requirements.txt
python manage.py migrate
python manage.py runserver 0.0.0.0:8000
```

### Web Uygulaması

```bash
cd web
# Basit bir HTTP sunucusu ile çalıştırma
python -m http.server 5000
```

### Mobil Uygulama

```bash
cd mobile/ecosifaa_app
flutter pub get
flutter run
```

## Kullanım

- Web: http://localhost:5000
- API: http://localhost:8000/api/
- Mobil: Flutter uygulamasını fiziksel cihaz veya emülatörde çalıştırın

## Not

Mobil uygulamayı fiziksel cihazda çalıştırmak için API_BASE_URL değişkenini `.env` dosyasında bilgisayarınızın IP adresi ile güncelleyin:

```
API_BASE_URL=http://192.168.1.100:8000/api/v1
``` 