// flutter_app/lib/services/user_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bsdoc_flutter/models/user.dart';

class UserService {
  // Use the appropriate IP/hostname for your development environment
  // For Android Emulator:
  final String _baseUrl = 'http://10.0.2.2:5000';
  // For iOS Simulator:
  // final String _baseUrl = 'http://localhost:5000';
  // For physical device (replace with your computer's actual IP):
  // final String _baseUrl = 'http://192.168.1.5:5000';

  Future<List<User>> getUsers() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/users'));

      if (response.statusCode == 200) {
        // Parse the JSON response
        List<dynamic> usersJson = json.decode(response.body);
        return usersJson.map((json) => User.fromJson(json)).toList();
      } else {
        // Handle server errors
        print('Failed to load users: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load users');
      }
    } catch (e) {
      // Handle network or parsing errors
      print('Error fetching users: $e');
      throw Exception('Failed to connect to the server or parse data');
    }
  }
}