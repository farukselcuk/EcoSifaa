import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../models/bitki.dart';
import '../models/rahatsizlik.dart';

class ApiService {
  // Web ve mobil platformlar için base URL belirleme
  final String baseUrl = kIsWeb 
      ? 'http://127.0.0.1:8000/api/v1'  // Web için
      : 'http://10.0.2.2:8000/api/v1';   // Android emulator için
  
  final storage = const FlutterSecureStorage();

  Future<String?> _getToken() async {
    return await storage.read(key: 'access_token');
  }

  Future<Map<String, String>> _getHeaders() async {
    String? token = await _getToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<List<Bitki>> getBitkiler() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/bitkiler/'));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Bitki.fromJson(json)).toList();
      } else {
        throw Exception('Bitkiler yüklenirken bir hata oluştu: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Bitkiler yüklenirken bir hata oluştu: $e');
    }
  }

  Future<Bitki> getBitkiDetay(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/bitkiler/$id/'));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Bitki.fromJson(data);
      } else {
        throw Exception('Bitki detayı yüklenirken bir hata oluştu: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Bitki detayı yüklenirken bir hata oluştu: $e');
    }
  }

  Future<List<Rahatsizlik>> getRahatsizliklar() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/rahatsizliklar/'),
        headers: headers,
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Rahatsizlik.fromJson(json)).toList();
      } else {
        throw Exception('Rahatsızlıklar yüklenirken hata oluştu: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Bağlantı hatası: $e');
    }
  }

  Future<Rahatsizlik> getRahatsizlikDetail(int id) async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/rahatsizliklar/$id/'),
        headers: headers,
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return Rahatsizlik.fromJson(json.decode(response.body));
      } else {
        throw Exception('Rahatsızlık detayı yüklenirken hata oluştu: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Bağlantı hatası: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getTedaviOnerileri(int rahatsizlikId, {bool tekliBitki = true, bool karisim = false}) async {
    try {
      final headers = await _getHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl/tedavi-onerileri/'),
        headers: headers,
        body: json.encode({
          'rahatsizlik': rahatsizlikId,
          'tekli_bitki': tekliBitki,
          'karisim': karisim,
        }),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data);
      } else {
        throw Exception('Tedavi önerileri yüklenirken hata oluştu: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Bağlantı hatası: $e');
    }
  }

  Future<bool> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/token/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'username': username,
          'password': password,
        }),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Bağlantı zaman aşımına uğradı. Lütfen internet bağlantınızı kontrol edin.');
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        await storage.write(key: 'access_token', value: data['access']);
        await storage.write(key: 'refresh_token', value: data['refresh']);
        return true;
      } else if (response.statusCode == 401) {
        throw Exception('Kullanıcı adı veya şifre hatalı.');
      } else {
        throw Exception('Giriş yapılırken bir hata oluştu: ${response.statusCode}');
      }
    } on TimeoutException catch (e) {
      throw Exception('Bağlantı zaman aşımına uğradı: $e');
    } catch (e) {
      throw Exception('Bağlantı hatası: $e');
    }
  }

  Future<void> logout() async {
    await storage.delete(key: 'access_token');
    await storage.delete(key: 'refresh_token');
  }
} 