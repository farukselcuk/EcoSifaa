import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bitki_provider.dart';

class BitkilerScreen extends StatefulWidget {
  const BitkilerScreen({Key? key}) : super(key: key);

  @override
  State<BitkilerScreen> createState() => _BitkilerScreenState();
}

class _BitkilerScreenState extends State<BitkilerScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedTip = '';
  final List<String> _tipler = [
    'Tümü',
    'Ot',
    'Ağaç',
    'Çiçek',
    'Meyve',
    'Kök',
    'Tohum',
    'Yaprak',
    'Diğer'
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() => 
      Provider.of<BitkiProvider>(context, listen: false).fetchBitkiler()
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Şifalı Bitkiler'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Bitki Ara...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {});
                  },
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          
          if (_selectedTip.isNotEmpty && _selectedTip != 'Tümü')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 8,
                children: [
                  Chip(
                    label: Text(_selectedTip),
                    onDeleted: () {
                      setState(() {
                        _selectedTip = '';
                      });
                    },
                    backgroundColor: Colors.green.shade100,
                  ),
                ],
              ),
            ),
            
          Expanded(
            child: Consumer<BitkiProvider>(
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
                            bitkiProvider.fetchBitkiler();
                          },
                          child: const Text('Tekrar Dene'),
                        ),
                      ],
                    ),
                  );
                }
                
                final bitkiler = bitkiProvider.bitkiler.where((bitki) {
                  final searchMatch = _searchController.text.isEmpty ||
                      bitki.isim.toLowerCase().contains(_searchController.text.toLowerCase());
                  
                  final tipMatch = _selectedTip.isEmpty || 
                      _selectedTip == 'Tümü' ||
                      bitki.tip.toLowerCase() == _selectedTip.toLowerCase();
                  
                  return searchMatch && tipMatch;
                }).toList();
                
                if (bitkiler.isEmpty) {
                  return const Center(
                    child: Text('Hiç bitki bulunamadı.'),
                  );
                }
                
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: bitkiler.length,
                  itemBuilder: (ctx, i) => GestureDetector(
                    onTap: () {
                      // TODO: Bitki detay sayfasına yönlendir
                    },
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 3,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: bitkiler[i].resimUrl != null
                                  ? Image.network(
                                      bitkiler[i].resimUrl!,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.green.shade100,
                                          child: const Icon(
                                            Icons.eco,
                                            size: 50,
                                            color: Colors.green,
                                          ),
                                        );
                                      },
                                    )
                                  : Container(
                                      color: Colors.green.shade100,
                                      child: const Icon(
                                        Icons.eco,
                                        size: 50,
                                        color: Colors.green,
                                      ),
                                    ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    bitkiler[i].isim,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    bitkiler[i].bilimselAd ?? '',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Chip(
                                    label: Text(
                                      bitkiler[i].tip,
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                    backgroundColor: Colors.green.shade100,
                                    padding: EdgeInsets.zero,
                                    labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Bitkileri Filtrele'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Bitki Tipi',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _tipler.map((tip) {
                  final isSelected = _selectedTip == tip;
                  return ChoiceChip(
                    label: Text(tip),
                    selected: isSelected,
                    selectedColor: Colors.green.shade200,
                    onSelected: (selected) {
                      setState(() {
                        _selectedTip = selected ? tip : '';
                        Navigator.of(context).pop();
                      });
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedTip = '';
              });
              Navigator.of(context).pop();
            },
            child: const Text('Filtreleri Temizle'),
          ),
        ],
      ),
    );
  }
} 