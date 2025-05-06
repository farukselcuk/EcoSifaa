import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/bitki.dart';
import '../models/rahatsizlik.dart';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:8000/api/v1';

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

  Future<List<Rahatsizlik>> getRahatsizliklar() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/rahatsizliklar/'));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Rahatsizlik.fromJson(json)).toList();
      } else {
        throw Exception('Rahatsızlıklar yüklenirken bir hata oluştu: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Rahatsızlıklar yüklenirken bir hata oluştu: $e');
    }
  }
} 