import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TedaviOneriScreen extends StatefulWidget {
  const TedaviOneriScreen({Key? key}) : super(key: key);

  @override
  State<TedaviOneriScreen> createState() => _TedaviOneriScreenState();
}

class _TedaviOneriScreenState extends State<TedaviOneriScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _selectedRahatsizlik;
  bool _tekliBitki = true;
  bool _karisim = false;
  List<dynamic> _rahatsizliklar = [];
  List<dynamic> _tedaviOnerileri = [];
  bool _sonucGoster = false;

  @override
  void initState() {
    super.initState();
    _fetchRahatsizliklar();
  }

  Future<void> _fetchRahatsizliklar() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('http://localhost:8000/api/rahatsizliklar/'),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _rahatsizliklar = data;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          // Örnek veriler
          _rahatsizliklar = [
            {"id": 1, "isim": "Baş Ağrısı"},
            {"id": 2, "isim": "Uykusuzluk"},
            {"id": 3, "isim": "Sindirim Problemleri"},
            {"id": 4, "isim": "Stres ve Anksiyete"},
            {"id": 5, "isim": "Soğuk Algınlığı"},
          ];
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        // Örnek veriler
        _rahatsizliklar = [
          {"id": 1, "isim": "Baş Ağrısı"},
          {"id": 2, "isim": "Uykusuzluk"},
          {"id": 3, "isim": "Sindirim Problemleri"},
          {"id": 4, "isim": "Stres ve Anksiyete"},
          {"id": 5, "isim": "Soğuk Algınlığı"},
        ];
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && (_tekliBitki || _karisim)) {
      setState(() {
        _isLoading = true;
      });

      try {
        // API isteği burada yapılabilir
        // Şimdilik örnek veri gösteriyoruz
        await Future.delayed(const Duration(seconds: 1));
        
        setState(() {
          _isLoading = false;
          _sonucGoster = true;
          
          // Demo tedavi önerileri
          final rahatsizlikIsim = _rahatsizliklar.firstWhere(
            (r) => r['id'].toString() == _selectedRahatsizlik,
            orElse: () => {"isim": "Bilinmeyen"},
          )['isim'];
          
          if (rahatsizlikIsim == "Baş Ağrısı") {
            _tedaviOnerileri = [
              {
                "id": 1,
                "bitki_isim": "Nane",
                "faydalar": "Baş ağrısını hafifletir, mide bulantısını azaltır.",
                "hazirlama": "2 çorba kaşığı taze nane yaprağını 1 bardak sıcak suda 10 dakika demleyin. Günde 2-3 bardak için.",
                "resim_url": "https://images.unsplash.com/photo-1562594945-31ba68289fcd?q=80&w=500"
              },
              {
                "id": 2,
                "bitki_isim": "Lavanta",
                "faydalar": "Baş ağrısını ve gerginliği azaltır, rahatlatır.",
                "hazirlama": "2-3 damla lavanta yağını bir fincan suya ekleyip kokusunu soluyun veya şakaklarınıza hafifçe sürün.",
                "resim_url": "https://images.unsplash.com/photo-1595755969003-1b7da88b2d85?q=80&w=500"
              }
            ];
          } else if (rahatsizlikIsim == "Uykusuzluk") {
            _tedaviOnerileri = [
              {
                "id": 3,
                "bitki_isim": "Papatya",
                "faydalar": "Sakinleştirici etkisiyle uykuya dalmayı kolaylaştırır.",
                "hazirlama": "1 çorba kaşığı kurutulmuş papatya çiçeğini 1 bardak sıcak suda 5-10 dakika demleyin. Yatmadan 30 dakika önce için.",
                "resim_url": "https://images.unsplash.com/photo-1589881940912-f91c0e963d57?q=80&w=500"
              },
              {
                "id": 4,
                "bitki_isim": "Melisa (Oğulotu)",
                "faydalar": "Sinir sistemini yatıştırır, uykuya geçişi kolaylaştırır.",
                "hazirlama": "1-2 çorba kaşığı melisa yaprağını 1 bardak sıcak suda 10 dakika demleyin. Bal ile tatlandırabilirsiniz.",
                "resim_url": "https://images.unsplash.com/photo-1628557875082-e09bc0578bce?q=80&w=500"
              }
            ];
          } else {
            _tedaviOnerileri = [
              {
                "id": 5,
                "bitki_isim": "Zencefil",
                "faydalar": "Sindirim sistemini düzenler, bulantıyı giderir.",
                "hazirlama": "Taze zencefil kökünden ince dilimler kesin ve 1 bardak sıcak suda 5-10 dakika demleyin. Bal ile tatlandırabilirsiniz.",
                "resim_url": "https://images.unsplash.com/photo-1615485290382-441e4d049cb5?q=80&w=500"
              },
              {
                "id": 6,
                "bitki_isim": "Ekinezya",
                "faydalar": "Bağışıklık sistemini güçlendirir, soğuk algınlığı belirtilerini hafifletir.",
                "hazirlama": "1 çorba kaşığı ekinezya bitkisini 1 bardak sıcak suda 10-15 dakika demleyin. Günde 2-3 bardak için.",
                "resim_url": "https://images.unsplash.com/photo-1597659840241-37e899d2e08a?q=80&w=500"
              }
            ];
          }
        });
      } catch (e) {
        setState(() {
          _isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Hata oluştu: $e'),
              backgroundColor: Colors.red,
            ),
          );
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen bir rahatsızlık seçin ve en az bir tedavi tipi işaretleyin.'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tedavi Önerisi Al'),
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _sonucGoster
              ? _buildSonuclar()
              : _buildForm(),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bilgi Kartı
              Card(
                margin: const EdgeInsets.only(bottom: 32),
                elevation: 0,
                color: Colors.green.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.green.shade700),
                          const SizedBox(width: 12),
                          const Text(
                            'Tedavi Önerisi Nasıl Çalışır?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Rahatsızlığınızı ve tercih ettiğiniz tedavi türünü seçin. Size uygun doğal çözüm önerilerini sunacağız. Bu öneriler sadece bilgilendirme amaçlıdır ve tıbbi tedavi yerine geçmez.',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Rahatsızlık Seçimi
              const Text(
                'Rahatsızlık',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    border: InputBorder.none,
                  ),
                  hint: const Text('Rahatsızlık Seçin'),
                  value: _selectedRahatsizlik,
                  items: _rahatsizliklar.map((rahatsizlik) {
                    return DropdownMenuItem<String>(
                      value: rahatsizlik['id'].toString(),
                      child: Text(rahatsizlik['isim']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedRahatsizlik = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen bir rahatsızlık seçin';
                    }
                    return null;
                  },
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Şikayetinizi belirtiniz.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Tedavi Tipi
              const Text(
                'Tedavi Tipi',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              // Tekli Bitki
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: CheckboxListTile(
                  title: const Text('Tekli Bitki'),
                  subtitle: const Text('Tek bir bitkinin kullanımı'),
                  value: _tekliBitki,
                  onChanged: (value) {
                    setState(() {
                      _tekliBitki = value!;
                    });
                  },
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.green,
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Karışım
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: CheckboxListTile(
                  title: const Text('Karışım'),
                  subtitle: const Text('Birden fazla bitkinin karışımı'),
                  value: _karisim,
                  onChanged: (value) {
                    setState(() {
                      _karisim = value!;
                    });
                  },
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.green,
                ),
              ),
              
              const SizedBox(height: 8),
              const Text(
                'En az bir tedavi tipi seçiniz.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Öneri Al Butonu
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: const Icon(Icons.search),
                  label: const Text('Öneri Al', style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSonuclar() {
    final rahatsizlikIsim = _rahatsizliklar.firstWhere(
      (r) => r['id'].toString() == _selectedRahatsizlik,
      orElse: () => {"isim": "Bilinmeyen"},
    )['isim'];
    
    return Column(
      children: [
        // Başlık bölümü
        Container(
          width: double.infinity,
          color: Theme.of(context).colorScheme.primary,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$rahatsizlikIsim için Tedavi Önerileri',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _tekliBitki && _karisim
                    ? 'Tekli Bitki ve Karışım'
                    : _tekliBitki
                        ? 'Tekli Bitki'
                        : 'Karışım',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        
        // Öneriler listesi
        Expanded(
          child: _tedaviOnerileri.isEmpty
              ? const Center(
                  child: Text('Bu rahatsızlık için öneri bulunamadı.'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _tedaviOnerileri.length,
                  itemBuilder: (ctx, index) {
                    final oneri = _tedaviOnerileri[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Bitki resmi
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                            child: Image.network(
                              oneri['resim_url'],
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 180,
                                  color: Colors.grey.shade200,
                                  child: const Center(
                                    child: Icon(Icons.image_not_supported, size: 48, color: Colors.grey),
                                  ),
                                );
                              },
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  height: 180,
                                  color: Colors.grey.shade200,
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                            ),
                          ),
                          
                          // Bitki bilgileri
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.eco, color: Colors.green, size: 20),
                                    const SizedBox(width: 8),
                                    Text(
                                      oneri['bitki_isim'],
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                
                                // Faydaları
                                _buildOneriSection(
                                  icon: Icons.favorite,
                                  iconColor: Colors.red,
                                  title: 'Faydaları',
                                  content: oneri['faydalar'],
                                ),
                                const SizedBox(height: 12),
                                
                                // Hazırlama
                                _buildOneriSection(
                                  icon: Icons.coffee,
                                  iconColor: Colors.brown,
                                  title: 'Hazırlama',
                                  content: oneri['hazirlama'],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
        
        // Yeni öneri butonu
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _sonucGoster = false;
                });
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Yeni Öneri Al'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.green,
                elevation: 1,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: const BorderSide(color: Colors.green),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildOneriSection({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String content,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
} 