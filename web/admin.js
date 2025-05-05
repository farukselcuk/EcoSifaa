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

// Admin Panel JavaScript

// API URL
const API_BASE_URL = 'http://localhost:8000/api';

// DOM Yükleme
document.addEventListener('DOMContentLoaded', function() {
    // Admin giriş kontrolü
    checkAdminLogin();
    
    // Sidebar navigasyon
    setupNavigation();
    
    // Bitkiler sayfasını yükle
    loadBitkiler();
    
    // Bitki arama ve filtreleme
    setupBitkiFilters();
    
    // Bitki kaydetme butonu
    document.getElementById('bitkiKaydetBtn').addEventListener('click', saveBitki);
    
    // Kullanıcı kaydetme butonu
    document.getElementById('kullaniciKaydetBtn').addEventListener('click', saveKullanici);
});

// Admin giriş kontrolü
function checkAdminLogin() {
    const adminLoggedIn = localStorage.getItem('adminLoggedIn') === 'true';
    const adminUsername = localStorage.getItem('adminUsername');
    
    if (!adminLoggedIn) {
        // Admin girişi yoksa ana sayfaya yönlendir
        window.location.href = 'index.html';
        return;
    }
    
    // Admin adını görüntüle
    if (adminUsername) {
        document.getElementById('admin-username').textContent = adminUsername;
    }
}

// Çıkış yapma
function logout() {
    localStorage.removeItem('adminLoggedIn');
    localStorage.removeItem('adminUsername');
    window.location.href = 'index.html';
}

// Sidebar navigasyon ayarları
function setupNavigation() {
    const navItems = document.querySelectorAll('.list-group-item');
    const panels = document.querySelectorAll('.panel-content');
    
    navItems.forEach(item => {
        item.addEventListener('click', function(e) {
            e.preventDefault();
            
            // Active class'ı kaldır
            navItems.forEach(nav => nav.classList.remove('active'));
            
            // Active class'ı ekle
            this.classList.add('active');
            
            // Panel ID'sini al
            const targetId = this.id.replace('nav-', 'panel-');
            
            // Tüm panelleri gizle
            panels.forEach(panel => panel.classList.add('d-none'));
            
            // Hedef paneli göster
            document.getElementById(targetId).classList.remove('d-none');
            
            // İlgili içeriği yükle
            if (targetId === 'panel-bitkiler') {
                loadBitkiler();
            } else if (targetId === 'panel-kullanicilar') {
                loadKullanicilar();
            }
        });
    });
}

// Bitkiler listesini yükle
function loadBitkiler() {
    const tbody = document.querySelector('#bitkilerTablosu tbody');
    
    // Yükleme göster
    tbody.innerHTML = `
        <tr>
            <td colspan="6" class="text-center py-4">
                <div class="spinner-border text-success" role="status">
                    <span class="visually-hidden">Yükleniyor...</span>
                </div>
                <p class="mt-2">Bitkiler yükleniyor...</p>
            </td>
        </tr>
    `;
    
    // API'den veri çek
    fetchBitkiler()
        .then(bitkiler => {
            displayBitkiler(bitkiler);
        })
        .catch(error => {
            console.error('Bitkiler yüklenirken hata:', error);
            tbody.innerHTML = `
                <tr>
                    <td colspan="6" class="text-center py-4 text-danger">
                        <i class="bi bi-exclamation-triangle-fill fs-4"></i>
                        <p class="mt-2">Bitkiler yüklenirken bir hata oluştu. Lütfen tekrar deneyin.</p>
                    </td>
                </tr>
            `;
        });
    
    // Rahatsızlıklar için checklist yükle
    loadRahatsizliklar();
}

// Bitkiler verisini getir
async function fetchBitkiler() {
    try {
        // Gerçek bir API varsa şöyle olurdu:
        // const response = await fetch(`${API_BASE_URL}/bitkiler/`);
        // if (!response.ok) throw new Error('API error');
        // return await response.json();
        
        // Örnek veri
        return [
            {
                id: 1,
                isim: 'Lavanta',
                bilimsel_ad: 'Lavandula angustifolia',
                tip: 'Çiçek',
                resim: 'https://images.unsplash.com/photo-1546387903-6d82d96ccca6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1471&q=80',
                faydalar: 'Lavanta, rahatlatıcı etkisi ile bilinen aromatik bir bitkidir.'
            },
            {
                id: 2,
                isim: 'Nane',
                bilimsel_ad: 'Mentha piperita',
                tip: 'Yaprak',
                resim: 'https://images.unsplash.com/photo-1593484812012-3e2fe2a61f76?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
                faydalar: 'Nane, sindirim sistemini rahatlatıcı etkisi ile bilinir.'
            },
            {
                id: 3,
                isim: 'Adaçayı',
                bilimsel_ad: 'Salvia officinalis',
                tip: 'Ot',
                resim: 'https://images.unsplash.com/photo-1590421958459-071ca4271af6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
                faydalar: 'Adaçayı, antiseptik ve iltihap giderici özelliklere sahiptir.'
            }
        ];
    } catch (error) {
        console.error('API error:', error);
        throw error;
    }
}

// Bitkiler verisini tabloya doldur
function displayBitkiler(bitkiler) {
    const tbody = document.querySelector('#bitkilerTablosu tbody');
    
    if (bitkiler.length === 0) {
        tbody.innerHTML = `
            <tr>
                <td colspan="6" class="text-center py-4">
                    <p>Henüz bitki bulunmamaktadır.</p>
                </td>
            </tr>
        `;
        return;
    }
    
    document.getElementById('toplamBitki').textContent = bitkiler.length;
    
    tbody.innerHTML = '';
    bitkiler.forEach(bitki => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${bitki.id}</td>
            <td>
                <img src="${bitki.resim || 'https://via.placeholder.com/60x60?text=Resim+Yok'}" 
                     alt="${bitki.isim}" class="img-thumbnail" 
                     onerror="this.src='https://via.placeholder.com/60x60?text=Resim+Yok'">
            </td>
            <td>${bitki.isim}</td>
            <td><em>${bitki.bilimsel_ad || '-'}</em></td>
            <td><span class="badge bg-success badge-status">${bitki.tip}</span></td>
            <td>
                <button class="btn btn-sm btn-info btn-action" onclick="editBitki(${bitki.id})">
                    <i class="bi bi-pencil-square"></i>
                </button>
                <button class="btn btn-sm btn-danger btn-action" onclick="deleteBitki(${bitki.id})">
                    <i class="bi bi-trash"></i>
                </button>
            </td>
        `;
        tbody.appendChild(row);
    });
}

// Bitki filtreleme ayarları
function setupBitkiFilters() {
    const searchInput = document.getElementById('bitkiArama');
    const filterBtn = document.getElementById('bitkiFiltrelemeBtn');
    
    searchInput.addEventListener('input', function() {
        // Burada gerçek bir uygulamada debounce kullanılabilir
        if (this.value.length >= 2 || this.value.length === 0) {
            filterBitkiler();
        }
    });
    
    filterBtn.addEventListener('click', filterBitkiler);
}

// Bitkileri filtrele
function filterBitkiler() {
    const searchTerm = document.getElementById('bitkiArama').value.toLowerCase();
    const tipFilter = document.getElementById('bitkiTipFiltreleme').value;
    
    fetchBitkiler()
        .then(bitkiler => {
            // Filtreleme uygula
            const filteredBitkiler = bitkiler.filter(bitki => {
                const nameMatch = bitki.isim.toLowerCase().includes(searchTerm) || 
                                 (bitki.bilimsel_ad && bitki.bilimsel_ad.toLowerCase().includes(searchTerm));
                const tipMatch = tipFilter ? bitki.tip === tipFilter : true;
                
                return nameMatch && tipMatch;
            });
            
            displayBitkiler(filteredBitkiler);
        })
        .catch(error => console.error('Filtreleme sırasında hata:', error));
}

// Rahatsızlıklar listesini yükle
function loadRahatsizliklar() {
    const container = document.getElementById('rahatsizliklarListesi');
    
    // Gerçek bir API varsa şöyle olurdu:
    // fetch(`${API_BASE_URL}/rahatsizliklar/`)
    //    .then(response => response.json())
    //    .then(data => { ... })
    
    // Örnek veri
    const rahatsizliklar = [
        { id: 1, isim: 'Baş ağrısı' },
        { id: 2, isim: 'Sindirim sorunları' },
        { id: 3, isim: 'Uyku bozukluğu' },
        { id: 4, isim: 'Stres' },
        { id: 5, isim: 'Soğuk algınlığı' },
        { id: 6, isim: 'Öksürük' },
        { id: 7, isim: 'Cilt problemleri' }
    ];
    
    container.innerHTML = '';
    rahatsizliklar.forEach(rahatsizlik => {
        const item = document.createElement('div');
        item.className = 'form-check rahatsizlik-item';
        item.innerHTML = `
            <input class="form-check-input" type="checkbox" value="${rahatsizlik.id}" id="rahatsizlik-${rahatsizlik.id}">
            <label class="form-check-label" for="rahatsizlik-${rahatsizlik.id}">
                ${rahatsizlik.isim}
            </label>
        `;
        container.appendChild(item);
    });
}

// Yeni bitki kaydet
function saveBitki() {
    const bitkiAdi = document.getElementById('bitkiAdi').value;
    const bitkiBilimselAd = document.getElementById('bitkiBilimselAd').value;
    const bitkiTip = document.getElementById('bitkiTip').value;
    const bitkiResimURL = document.getElementById('bitkiResimURL').value;
    const bitkiFaydalar = document.getElementById('bitkiFaydalar').value;
    const bitkiKullanim = document.getElementById('bitkiKullanim').value;
    
    // Form kontrolü
    if (!bitkiAdi || !bitkiTip || !bitkiFaydalar) {
        alert('Lütfen zorunlu alanları doldurun.');
        return;
    }
    
    // Seçili rahatsızlıkları al
    const rahatsizliklar = [];
    document.querySelectorAll('#rahatsizliklarListesi input[type="checkbox"]:checked').forEach(cb => {
        rahatsizliklar.push(parseInt(cb.value));
    });
    
    // Yeni bitki objesi
    const yeniBitki = {
        isim: bitkiAdi,
        bilimsel_ad: bitkiBilimselAd,
        tip: bitkiTip,
        resim: bitkiResimURL,
        faydalar: bitkiFaydalar,
        kullanim: bitkiKullanim,
        rahatsizliklar: rahatsizliklar
    };
    
    // Gerçek bir API varsa şöyle olurdu:
    // fetch(`${API_BASE_URL}/bitkiler/`, {
    //     method: 'POST',
    //     headers: {
    //         'Content-Type': 'application/json',
    //     },
    //     body: JSON.stringify(yeniBitki)
    // })
    // .then(response => response.json())
    // .then(data => {
    //     // Başarılı kayıt
    // })
    // .catch(error => {
    //     // Hata
    // });
    
    // Örnek işlem
    console.log('Yeni bitki kaydediliyor:', yeniBitki);
    alert('Bitki başarıyla kaydedildi.');
    
    // Modal'ı kapat
    const modal = bootstrap.Modal.getInstance(document.getElementById('bitkiEkleModal'));
    modal.hide();
    
    // Formu temizle
    document.getElementById('bitkiEkleForm').reset();
    
    // Bitkiler listesini yeniden yükle
    loadBitkiler();
}

// Bitki düzenle
function editBitki(id) {
    // Bitki detaylarını getir
    fetchBitkiler()
        .then(bitkiler => {
            const bitki = bitkiler.find(b => b.id === id);
            if (!bitki) throw new Error('Bitki bulunamadı');
            
            // Form alanlarını doldur
            document.getElementById('bitkiAdi').value = bitki.isim;
            document.getElementById('bitkiBilimselAd').value = bitki.bilimsel_ad || '';
            document.getElementById('bitkiTip').value = bitki.tip;
            document.getElementById('bitkiResimURL').value = bitki.resim || '';
            document.getElementById('bitkiFaydalar').value = bitki.faydalar;
            document.getElementById('bitkiKullanim').value = bitki.kullanim || '';
            
            // Modal'ı aç
            const modal = new bootstrap.Modal(document.getElementById('bitkiEkleModal'));
            modal.show();
        })
        .catch(error => {
            console.error('Bitki detayları alınırken hata:', error);
            alert('Bitki detayları alınamadı.');
        });
}

// Bitki sil
function deleteBitki(id) {
    if (confirm('Bu bitkiyi silmek istediğinizden emin misiniz?')) {
        // Gerçek bir API varsa şöyle olurdu:
        // fetch(`${API_BASE_URL}/bitkiler/${id}/`, {
        //     method: 'DELETE'
        // })
        // .then(response => {
        //     if (!response.ok) throw new Error('API error');
        //     return response.json();
        // })
        // .then(() => {
        //     // Başarılı silme
        // })
        // .catch(error => {
        //     // Hata
        // });
        
        // Örnek işlem
        console.log(`Bitki #${id} siliniyor...`);
        alert('Bitki başarıyla silindi.');
        
        // Bitkiler listesini yeniden yükle
        loadBitkiler();
    }
}

// Kullanıcılar listesini yükle
function loadKullanicilar() {
    const tbody = document.querySelector('#kullanicilarTablosu tbody');
    
    // Yükleme göster
    tbody.innerHTML = `
        <tr>
            <td colspan="6" class="text-center py-4">
                <div class="spinner-border text-success" role="status">
                    <span class="visually-hidden">Yükleniyor...</span>
                </div>
                <p class="mt-2">Kullanıcılar yükleniyor...</p>
            </td>
        </tr>
    `;
    
    // Örnek veri
    const kullanicilar = [
        { id: 1, username: 'admin', email: 'admin@example.com', role: 'admin', status: 'active' },
        { id: 2, username: 'editor1', email: 'editor@example.com', role: 'editor', status: 'active' },
        { id: 3, username: 'user1', email: 'user1@example.com', role: 'user', status: 'active' },
        { id: 4, username: 'user2', email: 'user2@example.com', role: 'user', status: 'inactive' }
    ];
    
    // Kullanıcıları tabloya doldur
    tbody.innerHTML = '';
    kullanicilar.forEach(user => {
        const statusClass = user.status === 'active' ? 'success' : 'secondary';
        const statusText = user.status === 'active' ? 'Aktif' : 'Pasif';
        
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${user.id}</td>
            <td>${user.username}</td>
            <td>${user.email}</td>
            <td>
                <span class="badge bg-${getRoleBadgeClass(user.role)}">
                    ${getRoleDisplayName(user.role)}
                </span>
            </td>
            <td>
                <span class="badge bg-${statusClass}">${statusText}</span>
            </td>
            <td>
                <button class="btn btn-sm btn-info btn-action" onclick="editKullanici(${user.id})">
                    <i class="bi bi-pencil-square"></i>
                </button>
                <button class="btn btn-sm btn-danger btn-action" onclick="deleteKullanici(${user.id})">
                    <i class="bi bi-trash"></i>
                </button>
            </td>
        `;
        tbody.appendChild(row);
    });
}

// Kullanıcı rolü badge class
function getRoleBadgeClass(role) {
    switch (role) {
        case 'admin': return 'danger';
        case 'editor': return 'warning';
        case 'user': return 'info';
        default: return 'secondary';
    }
}

// Kullanıcı rolü görünen adı
function getRoleDisplayName(role) {
    switch (role) {
        case 'admin': return 'Admin';
        case 'editor': return 'Editör';
        case 'user': return 'Kullanıcı';
        default: return role;
    }
}

// Yeni kullanıcı ekle
function saveKullanici() {
    const username = document.getElementById('kullaniciAdi').value;
    const email = document.getElementById('kullaniciEmail').value;
    const password = document.getElementById('kullaniciSifre').value;
    const role = document.getElementById('kullaniciRol').value;
    
    // Form kontrolü
    if (!username || !email || !password) {
        alert('Lütfen zorunlu alanları doldurun.');
        return;
    }
    
    // Yeni kullanıcı objesi
    const yeniKullanici = {
        username,
        email,
        password,
        role
    };
    
    // Gerçek bir API varsa şöyle olurdu
    // ...
    
    // Örnek işlem
    console.log('Yeni kullanıcı kaydediliyor:', yeniKullanici);
    alert('Kullanıcı başarıyla kaydedildi.');
    
    // Modal'ı kapat
    const modal = bootstrap.Modal.getInstance(document.getElementById('kullaniciEkleModal'));
    modal.hide();
    
    // Formu temizle
    document.getElementById('kullaniciEkleForm').reset();
    
    // Kullanıcılar listesini yeniden yükle
    loadKullanicilar();
}

// Kullanıcı düzenle
function editKullanici(id) {
    alert(`Kullanıcı #${id} düzenleme işlevi yapım aşamasındadır.`);
}

// Kullanıcı sil
function deleteKullanici(id) {
    if (confirm('Bu kullanıcıyı silmek istediğinizden emin misiniz?')) {
        console.log(`Kullanıcı #${id} siliniyor...`);
        alert('Kullanıcı başarıyla silindi.');
        
        // Kullanıcılar listesini yeniden yükle
        loadKullanicilar();
    }
} 