// flutter_app/lib/models/user.dart

class User {
  final int id;
  final String username;
  final String email;

  User({required this.id, required this.username, required this.email});

  // Factory constructor to create a User object from a JSON map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int, // Ensure type safety for int
      username: json['username'] as String, // Ensure type safety for String
      email: json['email'] as String, // Ensure type safety for String
    );
  }
}