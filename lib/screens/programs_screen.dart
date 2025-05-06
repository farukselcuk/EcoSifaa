import 'package:flutter/material.dart';

class ProgramsScreen extends StatelessWidget {
  const ProgramsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Program listesi (demo veriler)
    final List<Map<String, dynamic>> programs = [
      {
        'title': 'Bağışıklık Güçlendirme Programı',
        'description': '4 haftalık doğal bağışıklık güçlendirme programı',
        'duration': '4 hafta',
        'price': '199 TL',
        'isPremium': true,
      },
      {
        'title': 'Detoks Programı',
        'description': '2 haftalık detoks ve arınma programı',
        'duration': '2 hafta',
        'price': '149 TL',
        'isPremium': true,
      },
      {
        'title': 'Sindirim Sistemi Sağlığı',
        'description': '3 haftalık sindirim sistemi düzenleme programı',
        'duration': '3 hafta',
        'price': '179 TL',
        'isPremium': true,
      },
      {
        'title': 'Cilt Sağlığı ve Güzellik',
        'description': '4 haftalık cilt sağlığı ve güzellik programı',
        'duration': '4 hafta',
        'price': '199 TL',
        'isPremium': false,
      },
      {
        'title': 'Uyku Düzeni ve Stres Yönetimi',
        'description': '3 haftalık uyku düzeni ve stres yönetimi programı',
        'duration': '3 hafta',
        'price': '179 TL',
        'isPremium': false,
      },
    ];

    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: programs.length,
        itemBuilder: (context, index) {
          final program = programs[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProgramDetailPage(programTitle: program['title']),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: program['isPremium'] ? Colors.amber[100] : Colors.blue[100],
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Icon(
                            program['isPremium'] ? Icons.star : Icons.healing,
                            size: 50,
                            color: program['isPremium'] ? Colors.amber[800] : Colors.blue[800],
                          ),
                        ),
                        if (program['isPremium'])
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.amber[800],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'PREMIUM',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          program['title'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          program['description'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(Icons.timer, size: 16, color: Colors.grey[600]),
                            const SizedBox(width: 4),
                            Text(
                              program['duration'],
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Icon(Icons.monetization_on, size: 16, color: Colors.grey[600]),
                            const SizedBox(width: 4),
                            Text(
                              program['price'],
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Programı satın almak için Premium üye olmalısınız'),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: program['isPremium'] ? Colors.amber[800] : Colors.blue[800],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: const Size(double.infinity, 40),
                          ),
                          child: const Text('SATIN AL'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProgramDetailPage extends StatelessWidget {
  final String programTitle;

  const ProgramDetailPage({Key? key, required this.programTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Program detay bilgileri (demo veriler)
    final Map<String, dynamic> programInfo = {
      'description': 'Bu program, en son bilimsel araştırmalar ve geleneksel tıp bilgilerini bir araya getirerek tasarlanmıştır.',
      'duration': '4 Hafta',
      'price': '199 TL',
      'isPremium': true,
      'includes': [
        'Günlük bitki çayı tarifleri',
        'Haftalık beslenme planı',
        'Video rehberlik',
        'Uzman danışmanlığı',
        'Özel bitkisel karışımlar'
      ],
      'weeks': [
        {
          'title': '1. Hafta: Hazırlık ve Arınma',
          'description': 'İlk hafta vücudunuzu arındırmak ve programa hazırlamak için tasarlanmıştır.',
          'activities': [
            'Günlük detoks çayı',
            'Hafif beslenme planı',
            'Nefes egzersizleri'
          ]
        },
        {
          'title': '2. Hafta: Güçlendirme',
          'description': 'İkinci hafta bağışıklık sisteminizi güçlendirmeye odaklanır.',
          'activities': [
            'Bağışıklık güçlendirici bitki karışımları',
            'Protein ağırlıklı beslenme',
            'Orta yoğunlukta egzersizler'
          ]
        },
        {
          'title': '3. Hafta: Dengeleme',
          'description': 'Üçüncü hafta vücut sistemlerinizi dengelemeye yöneliktir.',
          'activities': [
            'Adaptojenik bitkiler',
            'Dengeli beslenme planı',
            'Meditasyon ve yoga'
          ]
        },
        {
          'title': '4. Hafta: Pekiştirme',
          'description': 'Son hafta kazanımlarınızı pekiştirme ve sürdürülebilir alışkanlıklar edinmeye odaklanır.',
          'activities': [
            'Bakım çayları',
            'Sürdürülebilir beslenme planı',
            'Günlük rutinler'
          ]
        }
      ]
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(programTitle),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: programInfo['isPremium'] ? Colors.amber[100] : Colors.blue[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      programInfo['isPremium'] ? Icons.star : Icons.healing,
                      size: 80,
                      color: programInfo['isPremium'] ? Colors.amber[800] : Colors.blue[800],
                    ),
                  ),
                  if (programInfo['isPremium'])
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber[800],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'PREMIUM',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              programTitle,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.timer, size: 18, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  programInfo['duration'],
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 16),
                Icon(Icons.monetization_on, size: 18, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  programInfo['price'],
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Açıklama',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              programInfo['description'],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              'Program İçeriği',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Program Şunları İçerir:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: programInfo['includes'].length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('✓ ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[800])),
                            Expanded(
                              child: Text(
                                programInfo['includes'][index],
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Haftalık Program',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: programInfo['weeks'].length,
              itemBuilder: (context, index) {
                final week = programInfo['weeks'][index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ExpansionTile(
                    title: Text(
                      week['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    childrenPadding: const EdgeInsets.all(16),
                    children: [
                      Text(
                        week['description'],
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Aktiviteler:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: week['activities'].length,
                        itemBuilder: (context, activityIndex) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('• ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                Expanded(
                                  child: Text(
                                    week['activities'][activityIndex],
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Programı satın almak için Premium üye olmalısınız'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: programInfo['isPremium'] ? Colors.amber[800] : Colors.blue[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'PROGRAMI SATIN AL',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 