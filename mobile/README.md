# EcoSifaa Mobil Uygulaması

Flutter ile geliştirilmiş şifalı bitkiler uygulaması.

## Kurulum

1. Flutter SDK'yı kurun: [Flutter Kurulum](https://flutter.dev/docs/get-started/install)

2. Bağımlılıkları yükleyin:
```bash
cd ecosifaa_app
flutter pub get
```

3. `.env` dosyasını oluşturun:
```
API_BASE_URL=http://10.0.2.2:8000/api/v1  # Emülatör için
# veya
API_BASE_URL=http://192.168.1.100:8000/api/v1  # Gerçek cihaz için (IP adresinizi kullanın)
```

4. Uygulamayı çalıştırın:
```bash
flutter run
```

## Özellikler

- Şifalı bitkiler listesi ve detayları
- Rahatsızlıklar listesi ve detayları
- Tedavi önerileri
- Kullanıcı profili ve favoriler
- Çevrimdışı erişim
- Karanlık/Aydınlık tema desteği

## Cihazlar

Uygulama, aşağıdaki platformlarda çalışacak şekilde tasarlanmıştır:
- Android
- iOS
- Web (Flutter web desteği)

## API Bağlantısı

Mobil uygulama, REST API ile backend'e bağlanır. API bağlantısı, `lib/api/api_service.dart` dosyasında yapılandırılmıştır.

API_BASE_URL değişkeninin doğru şekilde ayarlandığından emin olun:
- Android emülatörü için: `http://10.0.2.2:8000/api/v1`
- iOS emülatörü için: `http://127.0.0.1:8000/api/v1`
- Gerçek cihazlar için: `http://192.168.1.100:8000/api/v1` (bilgisayarınızın IP adresi) 