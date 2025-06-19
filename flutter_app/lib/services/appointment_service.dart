// lib/services/appointment_service.dart

import 'dart:convert';
import 'package:bsdoc_flutter/constants/api.dart';
import 'package:bsdoc_flutter/models/appointment.dart'; // Import your new model
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // For formatting the date

const bool isProd = bool.fromEnvironment('dart.vm.product');

class AppointmentService {
  //final String _baseUrl = isProd ? baseUrl : "http://10.0.2.2:8000";
  final String _baseUrl = baseUrl;
  final _storage = const FlutterSecureStorage();

  /// Fetches appointments for the logged-in doctor for a specific date.
  Future<List<Appointment>> fetchAppointmentsForDate(DateTime date) async {
    // 1. Get the auth token
    String? token = await _storage.read(key: 'accessToken');
    if (token == null) {
      throw Exception('User not authenticated. No token found.');
    }

    // 2. Format the date into 'YYYY-MM-DD' string for the query parameter
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    // 3. Construct the full URL with the query parameter
    final uri = Uri.parse(
      '$_baseUrl/doctors/me/appointments?date=$formattedDate',
    );
    print('Fetching appointments from: $uri'); // For debugging

    // 4. Make the authenticated GET request
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    // 5. Handle the response
    if (response.statusCode == 200) {
      // Decode the response body, which is expected to be a list of JSON objects
      List<dynamic> body = jsonDecode(response.body);

      // Map the list of JSON objects to a list of Appointment objects
      List<Appointment> appointments = body
          .map(
            (dynamic item) =>
                Appointment.fromJson(item as Map<String, dynamic>),
          )
          .toList();

      return appointments;
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      final errorBody = jsonDecode(response.body);
      throw Exception(errorBody['detail'] ?? 'Failed to load appointments.');
    }
  }
}
