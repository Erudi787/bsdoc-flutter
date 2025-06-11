// /lib/providers/AuthProvider.dart

import 'package:bsdoc_flutter/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final _storage = const FlutterSecureStorage();

  String? _token;
  bool _isLoading = true;

  bool get isLoggedIn => _token != null;
  bool get isLoading => _isLoading;
  String? get token => _token;

  AuthProvider() {
    _init();
  }

  Future<void> _init() async {
    await _tryAutoLogin();
  }

  Future<void> _tryAutoLogin() async {
    _isLoading = true;
    notifyListeners();
    
    _token = await _storage.read(key: 'accessToken');
    debugPrint('Token from storage: $_token');
    _isLoading = false;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    try {
      final String accessToken = await _authService.login(
        email: email,
        password: password,
      );
      _token = accessToken;

      await _storage.write(key: 'accessToken', value: _token);

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signup(String email, String password) async {
    try {
      await _authService.signup(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    if (_token != null) {
      try {
        await _authService.logout(_token!);
      }
      catch (e) {
        debugPrint('Error during backend logout: $e');
      }
    }

    final supabase = Supabase.instance.client;
    try {
      await supabase.auth.signOut();
    }
    catch (e) {
      debugPrint('Error signing out from Supabase client: $e');
    }

    _token = null;
    await _storage.delete(key: 'accessToken');

    notifyListeners();
  }
}
