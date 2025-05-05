import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../api/api_service.dart';

class AuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  
  bool _isAuth = false;
  String? _username;
  bool _isLoading = false;
  String? _error;

  bool get isAuth => _isAuth;
  String? get username => _username;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Uygulama başlatıldığında token varlığını kontrol et
  Future<void> tryAutoLogin() async {
    _isLoading = true;
    notifyListeners();

    try {
      String? token = await _storage.read(key: 'access_token');
      if (token != null && token.isNotEmpty) {
        // TODO: Token doğrulama
        _isAuth = true;
        _username = await _storage.read(key: 'username');
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      bool success = await _apiService.login(username, password);
      if (success) {
        await _storage.write(key: 'username', value: username);
        _isAuth = true;
        _username = username;
      } else {
        _error = "Giriş başarısız oldu. Kullanıcı adı veya şifre hatalı.";
      }
      return success;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _apiService.logout();
      _isAuth = false;
      _username = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
} 