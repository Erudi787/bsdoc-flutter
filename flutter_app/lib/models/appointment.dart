// lib/models/appointment.dart

// Represents the nested 'patient' profile object
class PatientProfile {
  final String id;
  final String? firstName;
  final String? lastName;
  final String? profileImageUrl;

  PatientProfile({
    required this.id,
    this.firstName,
    this.lastName,
    this.profileImageUrl,
  });

  // A factory constructor to create a PatientProfile from a JSON map
  factory PatientProfile.fromJson(Map<String, dynamic> json) {
    return PatientProfile(
      id: json['id'] ?? '',
      firstName: json['first_name'],
      lastName: json['last_name'],
      profileImageUrl: json['profile_image_url'],
    );
  }

  // Helper to get a display name
  String get fullName => ('${firstName ?? ''} ${lastName ?? ''}').trim();
}

// Represents a single appointment object
class Appointment {
  final String id;
  final String appointmentDate;
  final String appointmentTime;
  final String status;
  final PatientProfile patient;

  Appointment({
    required this.id,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.status,
    required this.patient,
  });

  // A factory constructor to create an Appointment from a JSON map
  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] ?? '',
      appointmentDate: json['appointment_date'] ?? '',
      appointmentTime: json['appointment_time'] ?? '',
      status: json['status'] ?? 'Unknown',
      // The 'patient' field in the JSON is a map, so we use PatientProfile.fromJson
      patient: PatientProfile.fromJson(json['patient'] ?? {}),
    );
  }
}