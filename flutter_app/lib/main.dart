// File: lib/main.dart
import 'package:bsdoc_flutter/components/appbar.dart';
import 'package:bsdoc_flutter/profilepage.dart'; // Import your new profilepage.dart
import 'package:bsdoc_flutter/providers/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bsdoc_flutter/components/bottomnavbar.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'curepage.dart';
import 'login.dart';
import '/home_page.dart'; // Import the separated home page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ipqwsnhygmzeljnwcysl.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlwcXdzbmh5Z216ZWxqbndjeXNsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc4NzUxMDQsImV4cCI6MjA1MzQ1MTEwNH0.gZ-UM7qThZOacopwMtsYMRF34_gz1BdQaM42dD8jthI',
  );
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const List<Color> gradientColors = [
      Color(0xFF44A2E6),
      Color(0xFFABCFF3),
      Color(0xFFBBA8DF),
    ];

    return MaterialApp(
      title: 'BSDOC App',
      debugShowCheckedModeBanner: false,
      home: const AuthWrapper(),
      routes: {
        '/home': (context) => const HomePage(gradientColors: gradientColors),
        '/medicine': (context) =>
            const CurePage(gradientColors: gradientColors),
        '/profile': (context) {
          final authProvider = Provider.of<AuthProvider>(
            context,
            listen: false,
          );
          // When '/profile' is called, check login status:
          // If true, show ProfilePage from profilepage.dart
          // If false, show Login page from login.dart
          return authProvider.isLoggedIn ? const ProfilePage() : const Login();
        },
        '/login': (context) => const Login(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        if (auth.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (auth.isLoggedIn) {
          return const HomePage(
            gradientColors: [
              Color(0xFF44A2E6),
              Color(0xFFABCFF3),
              Color(0xFFBBA8DF),
            ],
          );
        } else {
          return const Login();
        }
      },
    );
  }
}
