# EcoSifaa API

Django REST API ile geliştirilmiş şifalı bitkiler veritabanı.

## Kurulum

1. Bağımlılıkları yükleyin:
```bash
pip install -r requirements.txt
```

2. Veritabanını oluşturun:
```bash
python manage.py migrate
```

3. Admin kullanıcısı oluşturun:
```bash
python manage.py createsuperuser
```

4. Sunucuyu başlatın:
```bash
python manage.py runserver 0.0.0.0:8000
```

## API Endpoint'leri

- `/api/v1/bitkiler/` - Bitki listesi
- `/api/v1/bitkiler/{id}/` - Bitki detayları
- `/api/v1/rahatsizliklar/` - Rahatsızlık listesi
- `/api/v1/rahatsizliklar/{id}/` - Rahatsızlık detayları
- `/api/v1/tedavi-onerileri/` - Tedavi önerileri

## Notlar

API'nin gerçek bir mobil cihazdan erişilebilir olması için `settings.py` dosyasında aşağıdaki ayarları yapın:

```python
ALLOWED_HOSTS = ['localhost', '127.0.0.1', '192.168.1.100']  # IP adresinizi ekleyin
CORS_ALLOWED_ORIGINS = [
    "http://localhost:3000",
    "http://127.0.0.1:3000",
    "http://localhost:8000",
    "http://127.0.0.1:8000",
    "http://192.168.1.100:8000",  # IP adresinizi ekleyin
]
``` 