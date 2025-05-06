import 'package:flutter/material.dart';
import 'bitkiler_screen.dart';
import 'diseases_screen.dart';
import 'programs_screen.dart';
import '../widgets/search_bar.dart';
import '../widgets/category_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EcoSifaa', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hoş Geldiniz!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'EcoSifaa - Doğal Tedavi Uygulaması',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hoş Geldiniz!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SearchBar(
              onSearch: (query) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Aranan: $query')),
                );
              },
            ),
            const SizedBox(height: 24),
            CategoryCard(
              icon: Icons.medical_services_outlined,
              title: 'Rahatsızlıklar',
              description: 'Doğal tedavi yöntemleri ile rahatsızlıklarınızı giderin',
              color: Colors.purple.shade50,
              iconColor: Colors.purple,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DiseasesScreen()),
                );
              },
            ),
            const SizedBox(height: 16),
            CategoryCard(
              icon: Icons.eco,
              title: 'Şifalı Bitkiler',
              description: 'Doğanın şifalı bitkilerini keşfedin',
              color: Colors.indigo.shade50,
              iconColor: Colors.indigo,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BitkilerScreen()),
                );
              },
            ),
            const SizedBox(height: 16),
            CategoryCard(
              icon: Icons.star,
              title: 'Tedavi Programları ⭐',
              description: 'Premium tedavi programları ile sağlığınıza kavuşun',
              color: Colors.blue.shade50,
              iconColor: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProgramsScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
} 