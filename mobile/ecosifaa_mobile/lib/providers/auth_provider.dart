import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
  );
  
  bool _isAuth = false;
  String? _username;
  String? _email;
  bool _isLoading = false;
  String? _error;
  GoogleSignInAccount? _currentUser;

  bool get isAuth => _isAuth;
  String? get username => _username;
  String? get email => _email;
  bool get isLoading => _isLoading;
  String? get error => _error;
  GoogleSignInAccount? get currentUser => _currentUser;

  Future<void> tryAutoLogin() async {
    _isLoading = true;
    notifyListeners();

    try {
      String? token = await _storage.read(key: 'access_token');
      if (token != null && token.isNotEmpty) {
        _isAuth = true;
        _username = await _storage.read(key: 'username');
        _email = await _storage.read(key: 'email');
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

  Future<void> signInWithGoogle() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        _error = 'Giriş iptal edildi';
        return;
      }
      
      _currentUser = googleUser;
      _email = googleUser.email;
      _username = googleUser.displayName;
      
      // Kullanıcı bilgilerini backend'e gönder
      final response = await http.post(
        Uri.parse('http://localhost:8000/api/auth/google/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'token': (await googleUser.authentication).idToken,
          'email': googleUser.email,
          'name': googleUser.displayName,
        }),
      );
      
      if (response.statusCode != 200) {
        throw Exception('Backend authentication failed');
      }
      
      // Kullanıcı bilgilerini kaydet
      await _storage.write(key: 'username', value: _username);
      await _storage.write(key: 'email', value: _email);
      _isAuth = true;
      
    } catch (e) {
      _error = e.toString();
      await signOut();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      _currentUser = null;
      _isAuth = false;
      _username = null;
      _email = null;
      
      // Kullanıcı bilgilerini temizle
      await _storage.delete(key: 'username');
      await _storage.delete(key: 'email');
      await _storage.delete(key: 'access_token');
      
    } catch (e) {
      _error = e.toString();
    } finally {
      notifyListeners();
    }
  }
  
  Future<void> loadUser() async {
    try {
      _isLoading = true;
      notifyListeners();
      
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('user_email');
      
      if (email != null) {
        _currentUser = await _googleSignIn.signInSilently();
      }
      
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
} 