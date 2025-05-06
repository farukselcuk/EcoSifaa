import 'package:flutter/material.dart';

class Bitki {
  final String isim;
  final String? bilimselAd;
  final String tip;
  final String? resimUrl;
  final List<String> faydalar;
  final String? aciklama;

  Bitki({
    required this.isim,
    this.bilimselAd,
    required this.tip,
    this.resimUrl,
    required this.faydalar,
    this.aciklama,
  });
}

class BitkiProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  List<Bitki> _bitkiler = [];

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Bitki> get bitkiler => [..._bitkiler];

  Future<void> fetchBitkiler() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // TODO: API'den veri çekilecek
      // Şimdilik demo veriler
      await Future.delayed(const Duration(seconds: 1));
      
      _bitkiler = [
        Bitki(
          isim: 'Adaçayı',
          bilimselAd: 'Salvia officinalis',
          tip: 'Ot',
          faydalar: ['Boğaz ağrısı', 'Sindirim', 'Antiseptik'],
          aciklama: 'Adaçayı, geleneksel tıpta yaygın kullanılan şifalı bir bitkidir.',
        ),
        Bitki(
          isim: 'Zencefil',
          bilimselAd: 'Zingiber officinale',
          tip: 'Kök',
          faydalar: ['Mide bulantısı', 'Sindirim', 'İltihap önleyici'],
          aciklama: 'Zencefil, sindirim sistemi rahatsızlıklarında etkili bir bitkidir.',
        ),
        // Daha fazla bitki eklenebilir
      ];
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Bitkiler yüklenirken bir hata oluştu: $e';
      _isLoading = false;
      notifyListeners();
    }
  }
} 