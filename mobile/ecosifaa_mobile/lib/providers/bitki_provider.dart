import 'package:flutter/foundation.dart';
import '../api/api_service.dart';
import '../models/bitki.dart';

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

  Future<void> fetchBitkiler() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _bitkiler = await _apiService.getBitkiler();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchBitkiDetail(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _seciliBitki = await _apiService.getBitkiDetail(id);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
} 