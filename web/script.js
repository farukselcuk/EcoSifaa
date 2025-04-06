// API URL
const API_BASE_URL = 'http://localhost:8000/api';

// DOM elementi yüklendiğinde
document.addEventListener('DOMContentLoaded', function() {
    // Popüler bitkileri yükle
    fetchPopularPlants();
});

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