import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'api_helper.dart'; // helper file

class AuthService extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  String? _token;
  String? _userName;

  bool get isAuthenticated => _token != null;
  String? get token => _token;
  String? get userName => _userName; // ✅ added getter

  // Load saved JWT and username
  Future<void> loadToken() async {
    _token = await _storage.read(key: 'jwt');
    _userName = await _storage.read(key: 'userName');
    notifyListeners();
  }

  // 🔐 Login user
  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiHelper.baseUrl}/auth/login'),
        headers: ApiHelper.headers(null),
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        _token = data['token'];
        // ✅ store name if returned by backend, or fallback
        _userName = data['user']?['name'] ?? email.split('@').first;

        await _storage.write(key: 'jwt', value: _token);
        await _storage.write(key: 'userName', value: _userName ?? '');
        notifyListeners();
        return true;
      }
    } catch (e) {
      debugPrint('Login error: $e');
    }
    return false;
  }

  // 📝 Register user
  Future<bool> register(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiHelper.baseUrl}/auth/register'),
        headers: ApiHelper.headers(null),
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );
      return response.statusCode == 201;
    } catch (e) {
      debugPrint('Register error: $e');
      return false;
    }
  }

  // 🚪 Logout user
  Future<void> logout() async {
    _token = null;
    _userName = null;
    await _storage.deleteAll();
    notifyListeners();
  }
}
