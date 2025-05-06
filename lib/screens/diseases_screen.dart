import 'package:flutter/material.dart';

class DiseasesScreen extends StatelessWidget {
  const DiseasesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Rahatsızlık kategorileri listesi
    final List<Map<String, dynamic>> categories = [
      {
        'title': 'Sindirim Sistemi',
        'icon': Icons.restaurant,
        'diseases': ['Mide Ağrısı', 'Kabızlık', 'İshal', 'Reflü', 'Hazımsızlık']
      },
      {
        'title': 'Solunum Yolları',
        'icon': Icons.air,
        'diseases': ['Öksürük', 'Grip', 'Bronşit', 'Astım', 'Soğuk Algınlığı']
      },
      {
        'title': 'Cilt Problemleri',
        'icon': Icons.face,
        'diseases': ['Egzama', 'Sivilce', 'Sedef', 'Kaşıntı', 'Kuruluk']
      },
      {
        'title': 'Ağrı ve İltihap',
        'icon': Icons.healing,
        'diseases': ['Baş Ağrısı', 'Eklem Ağrısı', 'Bel Ağrısı', 'Kas Ağrısı']
      },
      {
        'title': 'Bağışıklık Sistemi',
        'icon': Icons.security,
        'diseases': ['Yorgunluk', 'Düşük Bağışıklık', 'Halsizlik']
      },
    ];

    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Icon(categories[index]['icon'], color: Colors.indigo),
                    const SizedBox(width: 8),
                    Text(
                      categories[index]['title'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories[index]['diseases'].length,
                itemBuilder: (context, diseaseIndex) {
                  return ListTile(
                    title: Text(categories[index]['diseases'][diseaseIndex]),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DiseaseDetailPage(
                            diseaseName: categories[index]['diseases'][diseaseIndex],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const Divider(),
            ],
          );
        },
      ),
    );
  }
}

class DiseaseDetailPage extends StatelessWidget {
  final String diseaseName;

  const DiseaseDetailPage({Key? key, required this.diseaseName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Demo veriler
    final Map<String, dynamic> diseaseInfo = {
      'description': '$diseaseName, genel olarak birçok insanın yaşadığı yaygın bir rahatsızlıktır.',
      'symptoms': [
        'Ağrı ve rahatsızlık hissi',
        'Halsizlik ve yorgunluk',
        'İştah değişiklikleri',
        'Uyku problemleri'
      ],
      'treatments': [
        {
          'name': 'Zencefil Çayı',
          'description': 'Günde 2-3 fincan taze zencefil çayı içmek şikayetleri azaltabilir.',
          'herbs': ['Zencefil', 'Bal']
        },
        {
          'name': 'Papatya Kompresi',
          'description': 'Papatya çayı ile hazırlanan kompres ağrıları hafifletebilir.',
          'herbs': ['Papatya', 'Lavanta']
        },
        {
          'name': 'Nane-Limon Karışımı',
          'description': 'Günde bir bardak nane ve limon suyu karışımı semptomları azaltır.',
          'herbs': ['Nane', 'Limon']
        }
      ]
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(diseaseName),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Açıklama',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              diseaseInfo['description'],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              'Belirtiler',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: diseaseInfo['symptoms'].length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Expanded(
                        child: Text(
                          diseaseInfo['symptoms'][index],
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Önerilen Doğal Tedaviler',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: diseaseInfo['treatments'].length,
              itemBuilder: (context, index) {
                final treatment = diseaseInfo['treatments'][index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          treatment['name'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          treatment['description'],
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Kullanılan Bitkiler:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Wrap(
                          spacing: 8,
                          children: List.generate(
                            treatment['herbs'].length,
                            (i) => Chip(
                              label: Text(treatment['herbs'][i]),
                              backgroundColor: Colors.green[50],
                              labelStyle: const TextStyle(color: Colors.green),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
} 