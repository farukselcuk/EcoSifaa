import 'package:flutter/material.dart';
import 'bitkiler_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EcoSifaa - Şifalı Bitkiler'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.eco,
              size: 100,
              color: Colors.green,
            ),
            const SizedBox(height: 20),
            const Text(
              'EcoSifaa Şifalı Bitkiler',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Sağlıklı yaşam için doğal çözümler',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Bitkiler sayfasına yönlendirme
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const BitkilerScreen(),
                  ),
                );
              },
              child: const Text('Şifalı Bitkileri Keşfet'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                // Rahatsızlıklar sayfasına yönlendirme kodu
                // Navigator.of(context).pushNamed('/rahatsizliklar');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Rahatsızlıklar ekranı yakında eklenecek!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
              child: const Text('Rahatsızlıklar'),
            ),
            const SizedBox(height: 30),
            OutlinedButton.icon(
              onPressed: () {
                // Arama ekranına yönlendirme
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Gelişmiş arama özellikleri çok yakında!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              icon: const Icon(Icons.search),
              label: const Text('Özel Arama'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.green,
                side: const BorderSide(color: Colors.green),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Ara',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoriler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        onTap: (index) {
          // Bottom navigation bar item tıklama işlemleri
          if (index != 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Bu özellik yakında eklenecek!'),
                duration: Duration(seconds: 1),
              ),
            );
          }
        },
      ),
    );
  }
} 