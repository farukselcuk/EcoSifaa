import 'package:flutter/foundation.dart';
import 'package:ecosifaa_mobile/api/api_service.dart';
import 'package:ecosifaa_mobile/models/bitki.dart';

class BitkiProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  List<Bitki> _bitkiler = [];
  Bitki? _seciliBitki;
  bool _isLoading = false;
  String? _error;

  List<Bitki> get bitkiler => _bitkiler;
  Bitki? get seciliBitki => _seciliBitki;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadBitkiler() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _bitkiler = await _apiService.getBitkiler();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchBitkiDetail(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _seciliBitki = await _apiService.getBitkiDetay(id);
    } catch (e) {
      _error = e.toString();
      _seciliBitki = null;
    }

    _isLoading = false;
    notifyListeners();
  }
  
  Future<Bitki> getBitkiDetay(int id) async {
    try {
      return await _apiService.getBitkiDetay(id);
    } catch (e) {
      throw Exception('Bitki detayı yüklenirken bir hata oluştu: $e');
    }
  }
} 