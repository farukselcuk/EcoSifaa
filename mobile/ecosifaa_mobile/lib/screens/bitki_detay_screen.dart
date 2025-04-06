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
                  title: Text(bitki.isim),
                  background: bitki.resimUrl != null
                      ? Image.network(
                          bitki.resimUrl!,
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
                      if (bitki.bilimselAd != null && bitki.bilimselAd!.isNotEmpty)
                        Text(
                          bitki.bilimselAd!,
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
                          const SizedBox(width: 8),
                          if (bitki.rahatsizliklar.isNotEmpty)
                            Expanded(
                              child: Wrap(
                                spacing: 4,
                                runSpacing: 4,
                                children: bitki.rahatsizliklar
                                    .take(3) // İlk 3 rahatsızlığı göster
                                    .map((rahatsizlik) => Chip(
                                          label: Text(
                                            rahatsizlik,
                                            style: const TextStyle(fontSize: 10),
                                          ),
                                          backgroundColor: Colors.orange.shade100,
                                          padding: EdgeInsets.zero,
                                          labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                                        ))
                                    .toList(),
                              ),
                            ),
                        ],
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Faydalar
                      if (bitki.faydalar != null && bitki.faydalar!.isNotEmpty)
                        _buildSection('Faydaları', bitki.faydalar!),
                      
                      // Kullanım
                      if (bitki.kullanim != null && bitki.kullanim!.isNotEmpty)
                        _buildSection('Kullanımı', bitki.kullanim!),
                      
                      // Hazırlama
                      if (bitki.hazirlama != null && bitki.hazirlama!.isNotEmpty)
                        _buildSection('Hazırlanışı', bitki.hazirlama!),
                      
                      // Uyarılar
                      if (bitki.uyarilar != null && bitki.uyarilar!.isNotEmpty)
                        _buildSection('Uyarılar', bitki.uyarilar!, isWarning: true),
                      
                      // Tüm Rahatsızlıklar
                      if (bitki.rahatsizliklar.isNotEmpty) ...[
                        const SizedBox(height: 24),
                        const Text(
                          'İyi Geldiği Rahatsızlıklar',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: bitki.rahatsizliklar
                              .map((rahatsizlik) => Chip(
                                    label: Text(rahatsizlik),
                                    backgroundColor: Colors.orange.shade100,
                                  ))
                              .toList(),
                        ),
                      ],
                      
                      // Etiketler
                      if (bitki.etiketler != null && bitki.etiketler!.isNotEmpty) ...[
                        const SizedBox(height: 24),
                        const Text(
                          'Etiketler',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: bitki.etiketler!
                              .map((etiket) => Chip(
                                    label: Text(etiket),
                                    backgroundColor: Colors.blue.shade100,
                                  ))
                              .toList(),
                        ),
                      ],
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

  Widget _buildSection(String title, String content, {bool isWarning = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (isWarning) ...[
              const SizedBox(width: 8),
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.orange.shade800,
                size: 20,
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            fontSize: 16,
            color: isWarning ? Colors.red.shade800 : Colors.black87,
          ),
        ),
      ],
    );
  }
} 