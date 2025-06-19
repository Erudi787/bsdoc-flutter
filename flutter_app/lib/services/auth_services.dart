import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:bsdoc_flutter/constants/api.dart';

const bool isProd = bool.fromEnvironment('dart.vm.product');

class AuthService {
  // Use 10.0.2.2 for the Android emulator to connect to your local machine's localhost.
  // For iOS emulator, you can use 'localhost' or '127.0.0.1'.
  // For a physical device, use your computer's network IP address.

  //final String _baseUrl = isProd ? baseUrl : "http://10.0.2.2:8000";
  final String _baseUrl = baseUrl;

  final _storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>> getProfile() async {
    String? token = await _storage.read(key: 'accessToken');
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final res = await http.get(
      Uri.parse('$_baseUrl/users/me'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint("--- Flutter AuthService | getProfile ---");
    debugPrint("Response Status Code: ${res.statusCode}");
    debugPrint("Response Body: ${res.body}");

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      final errorDetail = jsonDecode(res.body)['detail'];
      throw Exception(errorDetail ?? 'Failed to load profile.');
    }
  }

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

  Future<String> doctorSignup({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String filePath,
    required String fileName,
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$_baseUrl/doctors/registration'),
    );

    request.fields['firstName'] = firstName;
    request.fields['lastName'] = lastName;
    request.fields['email'] = email;
    request.fields['password'] = password;

    request.files.add(
      await http.MultipartFile.fromPath('file', filePath, filename: fileName),
    );

    var streamedResponse = await request.send();
    var res = await http.Response.fromStream(streamedResponse);
    final resbody = jsonDecode(res.body);

    if (res.statusCode == 200) {
      return resbody['message'];
    } else {
      throw Exception(resbody['detail'] ?? 'Failed to register as doctor.');
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
