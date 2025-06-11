import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bsdoc_flutter/constants/api.dart';

const bool isProd = bool.fromEnvironment('dart.vm.product');

class AuthService {
  // Use 10.0.2.2 for the Android emulator to connect to your local machine's localhost.
  // For iOS emulator, you can use 'localhost' or '127.0.0.1'.
  // For a physical device, use your computer's network IP address.
  final String _baseUrl = isProd ? baseUrl : "http://10.0.2.2:8000";

  Future<String> signup({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      // And return the success message.
      return jsonDecode(response.body)['message'];
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception with the error detail from the server.
      final errorDetail = jsonDecode(response.body)['detail'];
      throw Exception(errorDetail ?? 'Failed to sign up.');
    }
  }

  Future<String> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      // If login is successful, parse the session and return the access token.
      final session = jsonDecode(response.body);
      final accessToken = session['access_token'];
      if (accessToken == null) {
        throw Exception('Access token not found in login response.');
      }
      return accessToken;
    } else {
      // Handle errors, e.g., "Invalid login credentials"
      final errorDetail = jsonDecode(response.body)['detail'];
      throw Exception(errorDetail ?? 'Failed to log in.');
    }
  }

  Future<void> logout(String token) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/logout'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token', // Send the user's token
        },
      );

      if (response.statusCode == 200) {
        debugPrint('Successfully notified backend of logout.');
      } else {
        // Log an error if the backend call fails, but don't stop the process
        final errorBody = jsonDecode(response.body);
        throw Exception(errorBody['detail'] ?? 'Failed to log out on backend.');
      }
    } catch (e) {
      // Re-throw the exception to be handled in the AuthProvider
      rethrow;
    }
  }
}
