import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/bitki.dart';

class ApiService {
  // Emülatör için localhost
  final String baseUrl = 'http://10.0.2.2:8000/api/v1';
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
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/bitkiler/'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => Bitki.fromJson(json)).toList();
    } else {
      throw Exception('Bitkiler yüklenirken hata oluştu: ${response.statusCode}');
    }
  }

  Future<Bitki> getBitkiDetail(int id) async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/bitkiler/$id/'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return Bitki.fromJson(json.decode(response.body));
    } else {
      throw Exception('Bitki detayı yüklenirken hata oluştu: ${response.statusCode}');
    }
  }

  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/token/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      await storage.write(key: 'access_token', value: data['access']);
      await storage.write(key: 'refresh_token', value: data['refresh']);
      return true;
    } else {
      return false;
    }
  }

  Future<void> logout() async {
    await storage.delete(key: 'access_token');
    await storage.delete(key: 'refresh_token');
  }
} 