const CACHE_NAME = 'ecosifaa-v2';
const urlsToCache = [
  '/',
  '/index.html',
  '/bitki-detay.html',
  '/script.js',
  '/offline.html',
  '/manifest.json',
  'https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css',
  'https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css',
  'https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js'
];

// Service Worker yüklendiğinde
self.addEventListener('install', event => {
  console.log('[ServiceWorker] Installing');
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => {
        console.log('[ServiceWorker] Caching app shell');
        return cache.addAll(urlsToCache);
      })
      .then(() => {
        console.log('[ServiceWorker] Skip waiting on install');
        return self.skipWaiting();
      })
  );
});

// Fetch olayı için
self.addEventListener('fetch', event => {
  console.log('[ServiceWorker] Fetch', event.request.url);
  
  // API istekleri için network-first, diğer kaynaklar için cache-first stratejisi
  if (event.request.url.includes('/api/')) {
    // API istekleri - network first
    event.respondWith(
      fetch(event.request)
        .then(response => {
          return response;
        })
        .catch(() => {
          console.log('[ServiceWorker] API fetch failed - falling back to offline page');
          return caches.match('/offline.html');
        })
    );
  } else {
    // Statik içerikler - cache first
    event.respondWith(
      caches.match(event.request)
        .then(response => {
          // Cache'de varsa, cache'den döndür
          if (response) {
            console.log('[ServiceWorker] Return from cache:', event.request.url);
            return response;
          }
          
          // Cache'de yoksa, ağdan al
          console.log('[ServiceWorker] Fetching resource:', event.request.url);
          return fetch(event.request)
            .then(response => {
              // Yanıtın geçerli olup olmadığını kontrol et
              if (!response || response.status !== 200 || response.type !== 'basic') {
                return response;
              }
              
              // Yanıtın bir klonunu oluşturup cache'e ekle
              const responseToCache = response.clone();
              
              caches.open(CACHE_NAME)
                .then(cache => {
                  console.log('[ServiceWorker] Caching new resource:', event.request.url);
                  cache.put(event.request, responseToCache);
                });
              
              return response;
            })
            .catch(error => {
              console.log('[ServiceWorker] Fetch failed:', error);
              // Ağ bağlantısı yoksa ve bu bir HTML isteğiyse
              if (event.request.headers.get('accept').includes('text/html')) {
                return caches.match('/offline.html');
              }
            });
        })
    );
  }
});

// Service worker güncellendiğinde
self.addEventListener('activate', event => {
  console.log('[ServiceWorker] Activating');
  const cacheWhitelist = [CACHE_NAME];
  
  event.waitUntil(
    caches.keys().then(cacheNames => {
      return Promise.all(
        cacheNames.map(cacheName => {
          if (cacheWhitelist.indexOf(cacheName) === -1) {
            console.log('[ServiceWorker] Deleting old cache:', cacheName);
            return caches.delete(cacheName);
          }
        })
      );
    }).then(() => {
      console.log('[ServiceWorker] Claiming clients');
      return self.clients.claim();
    })
  );
}); 