import 'package:flutter/foundation.dart';
import 'package:ecosifaa_mobile/api/api_service.dart';
import 'package:ecosifaa_mobile/models/rahatsizlik.dart';

class RahatsizlikProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Rahatsizlik> _rahatsizliklar = [];
  bool _isLoading = false;
  String _error = '';

  List<Rahatsizlik> get rahatsizliklar => _rahatsizliklar;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> loadRahatsizliklar() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _rahatsizliklar = await _apiService.getRahatsizliklar();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<Rahatsizlik> getRahatsizlikDetail(int id) async {
    try {
      return await _apiService.getRahatsizlikDetail(id);
    } catch (e) {
      throw Exception('Rahatsızlık detayı yüklenirken bir hata oluştu: $e');
    }
  }
} 