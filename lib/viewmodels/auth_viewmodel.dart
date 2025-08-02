import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthViewmodel with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _token;
  String? get token => _token;

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('https://fakestoreapi.com/auth/login');

    try {
      final response = await http.post(
        url,
        body: {'username': username, 'password': password},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _token = data['token'];
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print("Login failed: $e");
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
