import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RahatsizliklarScreen extends StatefulWidget {
  const RahatsizliklarScreen({Key? key}) : super(key: key);

  @override
  State<RahatsizliklarScreen> createState() => _RahatsizliklarScreenState();
}

class _RahatsizliklarScreenState extends State<RahatsizliklarScreen> {
  List<dynamic> _rahatsizliklar = [];
  bool _isLoading = true;
  String _errorMessage = '';
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchRahatsizliklar();
  }

  Future<void> _fetchRahatsizliklar() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
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
          _errorMessage = 'Veri alınamadı. Status: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Bağlantı hatası: $e';
        _isLoading = false;
        
        // Örnek veriler (sadece hata durumunda gösterilecek)
        _rahatsizliklar = [
          {
            "id": 1,
            "isim": "Baş Ağrısı",
            "aciklama": "Baş ağrısı, baş bölgesinde hissedilen ağrı veya rahatsızlık hissidir. Stres, yorgunluk, uykusuzluk gibi nedenlerle ortaya çıkabilir.",
            "belirtiler": "Başta zonklama, basınç hissi, mide bulantısı, ışığa ve sese karşı hassasiyet",
            "risk_faktorleri": "Stres, uykusuzluk, düzensiz beslenme, hava değişimi",
            "onlemler": "Düzenli uyku, stresten uzak durma, düzenli beslenme, bol su içme"
          },
          {
            "id": 2,
            "isim": "Uykusuzluk",
            "aciklama": "Uykuya dalmakta veya uykuyu sürdürmekte güçlük çekme durumudur.",
            "belirtiler": "Uykuya dalmakta güçlük, sık uyanma, erken uyanma, gün içi yorgunluk",
            "risk_faktorleri": "Stres, kafein tüketimi, düzensiz uyku saatleri, elektronik cihaz kullanımı",
            "onlemler": "Düzenli uyku saatleri, yatak odasının karanlık ve sessiz olması, akşam kafeinden uzak durma"
          },
          {
            "id": 3,
            "isim": "Sindirim Problemleri",
            "aciklama": "Mide ve bağırsak sisteminde yaşanan rahatsızlıklardır.",
            "belirtiler": "Mide ağrısı, şişkinlik, gaz, hazımsızlık, ishal veya kabızlık",
            "risk_faktorleri": "Düzensiz beslenme, stres, hareketsiz yaşam, yetersiz su tüketimi",
            "onlemler": "Düzenli ve dengeli beslenme, bol su içme, düzenli egzersiz"
          }
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rahatsızlıklar'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Rahatsızlık Ara...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
              onChanged: (value) {
                // Arama mantığı burada uygulanabilir
              },
            ),
          ),
          
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _errorMessage.isNotEmpty && _rahatsizliklar.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error_outline, size: 48, color: Colors.red),
                            const SizedBox(height: 16),
                            Text(
                              'Hata Oluştu',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 32),
                              child: Text(
                                _errorMessage,
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: _fetchRahatsizliklar,
                              icon: const Icon(Icons.refresh),
                              label: const Text('Tekrar Dene'),
                            ),
                          ],
                        ),
                      )
                    : _rahatsizliklar.isEmpty
                        ? const Center(child: Text('Hiç rahatsızlık bulunamadı.'))
                        : ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: _rahatsizliklar.length,
                            itemBuilder: (ctx, index) {
                              final rahatsizlik = _rahatsizliklar[index];
                              return Card(
                                margin: const EdgeInsets.only(bottom: 16),
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: ExpansionTile(
                                  leading: const CircleAvatar(
                                    backgroundColor: Colors.orangeAccent,
                                    child: Icon(Icons.healing, color: Colors.white),
                                  ),
                                  title: Text(
                                    rahatsizlik['isim'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    rahatsizlik['aciklama'].toString().length > 60
                                        ? '${rahatsizlik['aciklama'].toString().substring(0, 60)}...'
                                        : rahatsizlik['aciklama'].toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          if (rahatsizlik['belirtiler'] != null) ...[
                                            _buildSectionTitle('Belirtiler'),
                                            _buildSectionContent(rahatsizlik['belirtiler']),
                                            const SizedBox(height: 12),
                                          ],
                                          if (rahatsizlik['risk_faktorleri'] != null) ...[
                                            _buildSectionTitle('Risk Faktörleri'),
                                            _buildSectionContent(rahatsizlik['risk_faktorleri']),
                                            const SizedBox(height: 12),
                                          ],
                                          if (rahatsizlik['onlemler'] != null) ...[
                                            _buildSectionTitle('Önlemler'),
                                            _buildSectionContent(rahatsizlik['onlemler']),
                                            const SizedBox(height: 16),
                                          ],
                                          
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              // Tedavi önerileri sayfasına yönlendirme
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                  content: Text('Tedavi önerileri yakında eklenecek!'),
                                                  duration: Duration(seconds: 2),
                                                ),
                                              );
                                            },
                                            icon: const Icon(Icons.local_pharmacy),
                                            label: const Text('Tedavi Önerileri'),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.orangeAccent,
                                            ),
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
        ],
      ),
    );
  }
  
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(
            _getSectionIcon(title),
            size: 18,
            color: _getSectionColor(title),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _getSectionColor(title),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(left: 26),
      child: Text(
        content,
        style: const TextStyle(
          fontSize: 14,
          height: 1.4,
        ),
      ),
    );
  }
  
  IconData _getSectionIcon(String title) {
    switch (title) {
      case 'Belirtiler':
        return Icons.sick;
      case 'Risk Faktörleri':
        return Icons.report_problem;
      case 'Önlemler':
        return Icons.shield;
      default:
        return Icons.info;
    }
  }
  
  Color _getSectionColor(String title) {
    switch (title) {
      case 'Belirtiler':
        return Colors.red;
      case 'Risk Faktörleri':
        return Colors.orange;
      case 'Önlemler':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }
} 