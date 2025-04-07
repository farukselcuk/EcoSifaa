import 'package:flutter/foundation.dart';
import 'package:ecosifaa_mobile/api/api_service.dart';
import 'package:ecosifaa_mobile/models/bitki.dart';

class BitkiProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  List<Bitki> _bitkiler = [];
  Bitki? _seciliBitki;
  bool _isLoading = false;
  String _error = '';

  List<Bitki> get bitkiler => _bitkiler;
  Bitki? get seciliBitki => _seciliBitki;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> loadBitkiler() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _bitkiler = await _apiService.getBitkiler();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<Bitki> getBitkiDetail(int id) async {
    try {
      return await _apiService.getBitkiDetail(id);
    } catch (e) {
      throw Exception('Bitki detayı yüklenirken bir hata oluştu: $e');
    }
  }
} 