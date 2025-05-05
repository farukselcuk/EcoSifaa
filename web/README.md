# EcoSifaa - Şifalı Bitkiler Web Arayüzü

EcoSifaa, şifalı bitkiler ve onların özellikleri hakkında bilgiler sunan web tabanlı bir veritabanıdır.

## Hızlı Başlangıç

EcoSifaa web arayüzünü başlatmak için:

1. **Windows**:
   - Klasördeki `ecosifaa-baslat.bat` dosyasına çift tıklayın

2. **Manuel başlatma**:
   - Terminal veya komut istemcisinde:
   ```
   cd web
   npm start
   ```

## Erişim Adresleri

- **Ana Sayfa**: http://localhost:8080
- **Admin Paneli**: http://localhost:8080/admin

## Admin Girişi

- **Kullanıcı Adı**: admin
- **Şifre**: admin123

## Geliştirici Bilgileri

Bu web arayüzü aşağıdaki teknolojileri kullanmaktadır:

- HTML5, CSS3 ve JavaScript
- Bootstrap 5 UI Framework
- Express.js (Web Sunucusu)
- PWA (Progressive Web App) özellikleri

## Yardım & Destek

Sorunlar için: `info@ecosifaa.com`

## Dosyalar

- `index.html` - Ana sayfa
- `bitki-detay.html` - Bitki detay sayfası
- `offline.html` - Çevrimdışı sayfa
- `styles.css` - Stil dosyası
- `script.js` - JavaScript kodları
- `service-worker.js` - PWA service worker
- `manifest.json` - PWA manifest dosyası

## Çalıştırma

Basit bir HTTP sunucusu ile çalıştırabilirsiniz:

```bash
# Python ile
python -m http.server 5000

# Ya da Node.js ile
npx serve -p 5000
```

## PWA Desteği

Web uygulaması PWA (Progressive Web App) özelliklerine sahiptir:

- Çevrimdışı çalışma
- Ana ekrana ekleme
- Cache stratejisi
- Yükleme bildirimi

Gerçek bir mobil cihaz üzerinde PWA kurulumu için HTTPS gereklidir. Geliştirme aşamasında PWA, sadece "localhost" üzerinde HTTP protokolüyle kurulabilir.

## API Bağlantısı

Web uygulaması, backend API ile iletişim kurar. API URL'sini `script.js` dosyasının en başındaki değişken ile ayarlayabilirsiniz:

```javascript
const API_BASE_URL = 'http://localhost:8000/api';
``` 