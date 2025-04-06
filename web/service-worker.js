const CACHE_NAME = 'ecosifaa-v1';
const urlsToCache = [
  '/',
  '/index.html',
  '/bitki-detay.html',
  '/script.js',
  '/manifest.json',
  'https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css',
  'https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css',
  'https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js'
];

// Service Worker yüklendiğinde
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => {
        console.log('Opened cache');
        return cache.addAll(urlsToCache);
      })
  );
});

// Fetch olayı için
self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request)
      .then(response => {
        // Cache'de varsa, cache'den döndür
        if (response) {
          return response;
        }
        
        // Cache'de yoksa, ağdan al
        return fetch(event.request)
          .then(response => {
            // API istekleri için caching yapmıyoruz
            if (!response || response.status !== 200 || response.type !== 'basic' || 
                event.request.url.includes('/api/')) {
              return response;
            }
            
            // Yanıtın bir klonunu oluşturup cache'e ekle
            const responseToCache = response.clone();
            
            caches.open(CACHE_NAME)
              .then(cache => {
                cache.put(event.request, responseToCache);
              });
            
            return response;
          })
          .catch(() => {
            // Ağ bağlantısı yoksa ve bu bir HTML isteğiyse
            if (event.request.headers.get('accept').includes('text/html')) {
              return caches.match('/offline.html');
            }
          });
      })
  );
});

// Service worker güncellendiğinde
self.addEventListener('activate', event => {
  const cacheWhitelist = [CACHE_NAME];
  
  event.waitUntil(
    caches.keys().then(cacheNames => {
      return Promise.all(
        cacheNames.map(cacheName => {
          if (cacheWhitelist.indexOf(cacheName) === -1) {
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
}); 