import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthProvider extends ChangeNotifier {
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';
  
  bool _isAuthenticated = false;
  String? _token;
  Map<String, dynamic>? _userData;

  bool get isAuthenticated => _isAuthenticated;
  String? get token => _token;
  Map<String, dynamic>? get userData => _userData;

  Future<void> signIn(String email, String password) async {
    // TODO: Implement actual sign in logic with API
    _isAuthenticated = true;
    _token = 'dummy_token';
    _userData = {
      'email': email,
      'name': 'Test User',
      'role': 'admin',
    };
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, _token!);
    await prefs.setString(_userKey, _userData.toString());
    
    notifyListeners();
  }

  Future<void> signOut() async {
    _isAuthenticated = false;
    _token = null;
    _userData = null;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
    
    notifyListeners();
  }

  Future<void> checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(_tokenKey);
    final userDataString = prefs.getString(_userKey);
    
    if (_token != null && userDataString != null) {
      _isAuthenticated = true;
      // TODO: Parse user data properly
      _userData = {'email': 'test@example.com'};
    } else {
      _isAuthenticated = false;
      _token = null;
      _userData = null;
    }
    
    notifyListeners();
  }
} 