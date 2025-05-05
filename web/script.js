// CSS Renk Düzeltme - Mavi -> Yeşil
(function() {
    // Depolanan düzeltme varsa uygula
    const storedFix = localStorage.getItem('ecosifaa-css-fix');
    if (storedFix) {
        const style = document.createElement('style');
        style.id = 'ecosifaa-fix';
        style.textContent = storedFix;
        
        // Sayfa yüklendiğinde ya da DOMContentLoaded'da ekle
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', function() {
                document.head.appendChild(style);
                console.log('EcoSifaa CSS düzeltmesi uygulandı');
            });
        } else {
            document.head.appendChild(style);
            console.log('EcoSifaa CSS düzeltmesi uygulandı');
        }
    }
})();

// API URL
const API_BASE_URL = 'http://localhost:8000/api';

// DOM elementi yüklendiğinde
document.addEventListener('DOMContentLoaded', function() {
    // Popüler bitkileri yükle
    fetchPopularPlants();
    
    // Login formlarını dinle
    setupLoginForms();
    
    // PWA kurulum
    setupPWA();

    // Kullanıcı Girişi ve Oturum Yönetimi
    const loginButton = document.getElementById('loginButton');
    const userDropdown = document.getElementById('userDropdown');
    const userPhoto = document.getElementById('userPhoto');
    const userName = document.getElementById('userName');
    const adminLink = document.getElementById('adminLink');

    // Kullanıcı oturum durumunu kontrol et
    fetch('/api/user')
        .then(response => response.json())
        .then(data => {
            if (data.isAuthenticated) {
                updateUserUI(data.user);
            }
        })
        .catch(error => console.error('Kullanıcı bilgisi alınamadı:', error));

    // Giriş butonu tıklama olayı
    loginButton.addEventListener('click', () => {
        window.location.href = '/auth/google';
    });

    // Kullanıcı arayüzünü güncelle
    function updateUserUI(user) {
        if (user) {
            loginButton.style.display = 'none';
            userDropdown.style.display = 'block';
            userPhoto.src = user.photo;
            userName.textContent = user.displayName;
            
            if (user.isAdmin) {
                adminLink.style.display = 'block';
            }
        } else {
            loginButton.style.display = 'block';
            userDropdown.style.display = 'none';
        }
    }

    // Çıkış yapma işlemi
    document.querySelector('.logout-btn')?.addEventListener('click', (e) => {
        e.preventDefault();
        fetch('/logout', { method: 'GET' })
            .then(() => {
                window.location.href = '/';
            })
            .catch(error => console.error('Çıkış yapılamadı:', error));
    });
});

// Login formlarını ayarla
function setupLoginForms() {
    const userLoginForm = document.getElementById('userLoginForm');
    const adminLoginForm = document.getElementById('adminLoginForm');
    const googleLoginBtn = document.querySelector('.btn-google');
    
    if (userLoginForm) {
        userLoginForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const email = document.getElementById('userEmail').value;
            const password = document.getElementById('userPassword').value;
            
            // Normalde burada API'ye istek yapılır
            console.log('Kullanıcı girişi:', email, password);
            
            // Demo amaçlı basit kontrol
            if (email && password) {
                alert('Başarıyla giriş yaptınız!');
                localStorage.setItem('userLoggedIn', 'true');
                localStorage.setItem('userEmail', email);
                updateLoginStatus();
                
                // Modal'ı kapat
                const loginModal = bootstrap.Modal.getInstance(document.getElementById('loginModal'));
                loginModal.hide();
            }
        });
    }
    
    if (adminLoginForm) {
        adminLoginForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const username = document.getElementById('adminUsername').value;
            const password = document.getElementById('adminPassword').value;
            
            // Demo amaçlı basit admin kontrolü
            if (username === 'admin' && password === 'admin123') {
                alert('Admin olarak giriş yaptınız!');
                localStorage.setItem('adminLoggedIn', 'true');
                localStorage.setItem('adminUsername', username);
                updateLoginStatus();
                
                // Admin paneline yönlendir
                window.location.href = 'admin-panel.html';
                
                // Modal'ı kapat
                const loginModal = bootstrap.Modal.getInstance(document.getElementById('loginModal'));
                loginModal.hide();
            } else {
                alert('Hatalı admin bilgileri!');
            }
        });
    }
    
    if (googleLoginBtn) {
        googleLoginBtn.addEventListener('click', function(e) {
            e.preventDefault();
            
            // Google ile giriş demo
            simulateGoogleLogin();
        });
    }
    
    // Sayfa yüklendiğinde giriş durumunu kontrol et
    updateLoginStatus();
}

// Giriş durumunu güncelle
function updateLoginStatus() {
    const userLoggedIn = localStorage.getItem('userLoggedIn') === 'true';
    const adminLoggedIn = localStorage.getItem('adminLoggedIn') === 'true';
    
    const loginBtn = document.querySelector('.btn-user-action');
    
    if (loginBtn) {
        if (userLoggedIn) {
            const userEmail = localStorage.getItem('userEmail');
            loginBtn.innerHTML = `<i class="bi bi-person-check-fill"></i> ${userEmail.split('@')[0]}`;
            loginBtn.setAttribute('data-bs-target', '#userDropdown');
        } else if (adminLoggedIn) {
            const adminUsername = localStorage.getItem('adminUsername');
            loginBtn.innerHTML = `<i class="bi bi-shield-lock-fill"></i> ${adminUsername}`;
            loginBtn.setAttribute('data-bs-target', '#adminDropdown');
        } else {
            loginBtn.innerHTML = `<i class="bi bi-person-circle"></i> Giriş Yap`;
            loginBtn.setAttribute('data-bs-target', '#loginModal');
        }
    }
}

// Google ile giriş simülasyonu
function simulateGoogleLogin() {
    // Gerçek bir uygulamada burada Google OAuth kullanılır
    console.log('Google ile giriş yapılıyor...');
    
    setTimeout(() => {
        const randomUser = `user${Math.floor(Math.random() * 1000)}@gmail.com`;
        localStorage.setItem('userLoggedIn', 'true');
        localStorage.setItem('userEmail', randomUser);
        localStorage.setItem('loginMethod', 'google');
        
        updateLoginStatus();
        alert(`Google hesabı ile giriş yapıldı: ${randomUser}`);
        
        // Modal'ı kapat
        const loginModal = bootstrap.Modal.getInstance(document.getElementById('loginModal'));
        loginModal.hide();
    }, 1000);
}

// Çıkış yap
function logout() {
    localStorage.removeItem('userLoggedIn');
    localStorage.removeItem('userEmail');
    localStorage.removeItem('adminLoggedIn');
    localStorage.removeItem('adminUsername');
    localStorage.removeItem('loginMethod');
    
    updateLoginStatus();
    alert('Başarıyla çıkış yaptınız!');
}

// PWA kurulum işlevini ayarla
function setupPWA() {
    let deferredPrompt;
    const installPrompt = document.getElementById('install-prompt');
    const installButton = document.getElementById('install-button');
    const closePrompt = document.getElementById('close-prompt');
    
    // Service Worker kayıt
    if ('serviceWorker' in navigator) {
        window.addEventListener('load', () => {
            navigator.serviceWorker.register('/service-worker.js')
                .then(registration => {
                    console.log('ServiceWorker başarıyla kaydedildi:', registration.scope);
                })
                .catch(error => {
                    console.error('ServiceWorker kaydı başarısız:', error);
                });
        });
    } else {
        console.warn('Service worker bu tarayıcıda desteklenmiyor.');
    }
    
    // PWA kurulum bildirimini göster
    window.addEventListener('beforeinstallprompt', (e) => {
        console.log('PWA kurulum bildirimi tetiklendi');
        e.preventDefault();
        deferredPrompt = e;
        
        // Kurulum bildirimi varsa göster
        if (installPrompt) {
            installPrompt.style.display = 'block';
        }
    });
    
    // Kurulum butonunu ayarla
    if (installButton) {
        installButton.addEventListener('click', async () => {
            if (!deferredPrompt) {
                console.log('Kurulum isteği bulunamadı');
                return;
            }
            
            console.log('Kurulum isteği gösteriliyor');
            deferredPrompt.prompt();
            
            // Kullanıcı yanıtını bekle
            const { outcome } = await deferredPrompt.userChoice;
            console.log(`Kullanıcı kurulumu ${outcome === 'accepted' ? 'kabul etti' : 'reddetti'}`);
            
            // prompt'u sıfırla
            deferredPrompt = null;
            
            // Bildirimi gizle
            if (installPrompt) {
                installPrompt.style.display = 'none';
            }
        });
    }
    
    // Kapat butonunu ayarla
    if (closePrompt) {
        closePrompt.addEventListener('click', () => {
            if (installPrompt) {
                installPrompt.style.display = 'none';
            }
        });
    }
    
    // PWA kurulumunun tamamlandığını kontrol et
    window.addEventListener('appinstalled', (e) => {
        console.log('PWA başarıyla kuruldu');
        // Bildirimi gizle
        if (installPrompt) {
            installPrompt.style.display = 'none';
        }
    });
}

// Popüler bitkileri getir
async function fetchPopularPlants() {
    try {
        const response = await fetch(`${API_BASE_URL}/bitkiler/`);
        
        if (!response.ok) {
            throw new Error('Bitkiler yüklenirken bir hata oluştu');
        }
        
        const data = await response.json();
        
        // En fazla 6 bitki göster
        const plants = data.results ? data.results.slice(0, 6) : data.slice(0, 6);
        displayPlants(plants);
    } catch (error) {
        console.error('Bitkiler yüklenirken hata oluştu:', error);
        // Hata durumunda örnek verileri göster
        displaySamplePlants();
    }
}

// Bitkileri görüntüle
function displayPlants(plants) {
    const plantsContainer = document.getElementById('plants-container');
    
    if (!plantsContainer) {
        console.error('plants-container elementi bulunamadı');
        return;
    }
    
    // İçeriği temizle
    plantsContainer.innerHTML = '';
    
    // Her bitki için bir kart oluştur
    plants.forEach(plant => {
        const plantCard = createPlantCard(plant);
        plantsContainer.appendChild(plantCard);
    });
}

// Bitki kartı oluştur
function createPlantCard(plant) {
    const colDiv = document.createElement('div');
    colDiv.className = 'col-md-4 mb-4';
    
    const cardDiv = document.createElement('div');
    cardDiv.className = 'card plant-card shadow-sm h-100';
    
    // Resim
    const imgElement = document.createElement('img');
    imgElement.className = 'card-img-top plant-image';
    imgElement.src = plant.resim || 'https://via.placeholder.com/300x200?text=Resim+Yok';
    imgElement.alt = plant.isim;
    imgElement.onerror = function() {
        this.src = 'https://via.placeholder.com/300x200?text=Resim+Yok';
    };
    
    // Kart içeriği
    const cardBody = document.createElement('div');
    cardBody.className = 'card-body';
    
    // Başlık
    const title = document.createElement('h5');
    title.className = 'card-title';
    title.textContent = plant.isim;
    
    // Bilimsel ad
    let scientificName = '';
    if (plant.bilimsel_ad) {
        scientificName = document.createElement('p');
        scientificName.className = 'card-text text-muted fst-italic';
        const small = document.createElement('small');
        small.textContent = plant.bilimsel_ad;
        scientificName.appendChild(small);
    }
    
    // Tip
    const badge = document.createElement('span');
    badge.className = 'badge bg-success mb-2';
    badge.textContent = plant.tip;
    
    // Açıklama
    const description = document.createElement('p');
    description.className = 'card-text';
    description.textContent = plant.faydalar ? 
        (plant.faydalar.length > 100 ? plant.faydalar.substring(0, 100) + '...' : plant.faydalar) : 
        'Açıklama bulunmamaktadır.';
    
    // Detay butonu
    const cardFooter = document.createElement('div');
    cardFooter.className = 'card-footer bg-white border-top-0';
    
    const detailButton = document.createElement('a');
    detailButton.className = 'btn btn-outline-success w-100';
    detailButton.textContent = 'Detayları Gör';
    detailButton.href = `bitki-detay.html?id=${plant.id}`;
    
    // Elementleri birleştir
    cardBody.appendChild(title);
    if (scientificName) cardBody.appendChild(scientificName);
    cardBody.appendChild(badge);
    cardBody.appendChild(description);
    
    cardFooter.appendChild(detailButton);
    
    cardDiv.appendChild(imgElement);
    cardDiv.appendChild(cardBody);
    cardDiv.appendChild(cardFooter);
    
    colDiv.appendChild(cardDiv);
    
    return colDiv;
}

// Örnek verileri göster (API çalışmadığında)
function displaySamplePlants() {
    const samplePlants = [
        {
            id: 1,
            isim: 'Lavanta',
            bilimsel_ad: 'Lavandula angustifolia',
            tip: 'Çiçek',
            faydalar: 'Lavanta, rahatlatıcı etkisi ile bilinen aromatik bir bitkidir. Stres, anksiyete ve uykusuzluk gibi durumlarda yardımcı olabilir.',
            resim: 'https://images.unsplash.com/photo-1546387903-6d82d96ccca6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1471&q=80'
        },
        {
            id: 2,
            isim: 'Nane',
            bilimsel_ad: 'Mentha piperita',
            tip: 'Yaprak',
            faydalar: 'Nane, sindirim sistemini rahatlatıcı etkisi ile bilinir. Mide bulantısı, hazımsızlık ve bağırsak gazı gibi sorunlarda yardımcı olur.',
            resim: 'https://images.unsplash.com/photo-1593484812012-3e2fe2a61f76?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80'
        },
        {
            id: 3,
            isim: 'Adaçayı',
            bilimsel_ad: 'Salvia officinalis',
            tip: 'Ot',
            faydalar: 'Adaçayı, antiseptik ve iltihap giderici özelliklere sahiptir. Boğaz ağrısı, öksürük ve sindirim sorunlarında kullanılabilir.',
            resim: 'https://images.unsplash.com/photo-1590421958459-071ca4271af6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80'
        }
    ];
    
    displayPlants(samplePlants);
} 