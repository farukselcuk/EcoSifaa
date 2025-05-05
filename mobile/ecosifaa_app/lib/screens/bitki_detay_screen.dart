import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bitki_provider.dart';

class BitkiDetayScreen extends StatefulWidget {
  final int id;
  
  const BitkiDetayScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<BitkiDetayScreen> createState() => _BitkiDetayScreenState();
}

class _BitkiDetayScreenState extends State<BitkiDetayScreen> {
  @override
  void initState() {
    super.initState();
    // Sayfa yüklendiğinde bitki detaylarını getir
    Future.microtask(() => 
      Provider.of<BitkiProvider>(context, listen: false).fetchBitkiDetail(widget.id)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BitkiProvider>(
        builder: (ctx, bitkiProvider, child) {
          if (bitkiProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (bitkiProvider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bir hata oluştu:',
                    style: TextStyle(color: Colors.red.shade700, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    bitkiProvider.error!,
                    style: TextStyle(color: Colors.red.shade500),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      bitkiProvider.fetchBitkiDetail(widget.id);
                    },
                    child: const Text('Tekrar Dene'),
                  ),
                ],
              ),
            );
          }

          final bitki = bitkiProvider.seciliBitki;
          if (bitki == null) {
            return const Center(child: Text('Bitki bulunamadı.'));
          }

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 250,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(bitki.ad),
                  background: bitki.resimUrl.isNotEmpty
                      ? Image.network(
                          bitki.resimUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.green.shade100,
                              child: const Icon(
                                Icons.eco,
                                size: 80,
                                color: Colors.green,
                              ),
                            );
                          },
                        )
                      : Container(
                          color: Colors.green.shade100,
                          child: const Icon(
                            Icons.eco,
                            size: 80,
                            color: Colors.green,
                          ),
                        ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bilimsel ad
                      Text(
                        bitki.bilimselAd,
                        style: const TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                        
                      const SizedBox(height: 16),
                      
                      // Bitki tipi
                      Row(
                        children: [
                          Chip(
                            label: Text(bitki.tip),
                            backgroundColor: Colors.green.shade100,
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Açıklama
                      Text(
                        'Açıklama',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(bitki.aciklama),
                      const SizedBox(height: 24),
                      
                      // Faydalar
                      if (bitki.faydalar.isNotEmpty)
                        _buildSection('Faydaları', bitki.faydalar),
                      
                      // Kullanım alanları
                      if (bitki.kullanimAlanlari.isNotEmpty)
                        _buildSection('Kullanım Alanları', bitki.kullanimAlanlari),
                      
                      // Uyarılar
                      if (bitki.uyarilar.isNotEmpty)
                        _buildSection('Uyarılar', bitki.uyarilar, isWarning: true),
                      
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Favorilere ekle
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Favorilere eklendi!'),
              backgroundColor: Colors.green,
            ),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.favorite),
      ),
    );
  }

  Widget _buildSection(String title, List<String> items, {bool isWarning = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                isWarning ? Icons.warning_amber_rounded : Icons.check_circle,
                color: isWarning ? Colors.orange : Colors.green,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(child: Text(item)),
            ],
          ),
        )).toList(),
      ],
    );
  }
} 