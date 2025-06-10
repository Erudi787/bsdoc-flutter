// File: main.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bsdoc_flutter/components/bottomnavbar.dart'; // Using your previous correct structure

import 'curepage.dart';
import 'login.dart';

// Your TabPage and _buildTabContent classes remain the same...
class TabPage extends StatelessWidget {
  final String titleForAppBar;
  final Widget pageContent;
  final List<Color> gradientColors;
  final AlignmentGeometry beginAlignment;
  final AlignmentGeometry endAlignment;
  final List<double>? stops;
  final Color mainAppBarTextColor;

  const TabPage({
    super.key,
    required this.titleForAppBar,
    required this.pageContent,
    required this.gradientColors,
    required this.beginAlignment,
    required this.endAlignment,
    this.stops,
    required this.mainAppBarTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return pageContent;
  }
}

Widget _buildTabContent(String title, {Color textColor = Colors.white70}) =>
    Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          "$title Area",
          style: TextStyle(
            color: textColor,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );

void main() {
  runApp(const MyApp());
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
      initialRoute: '/home',
      routes: {
        '/home': (context) => const MyHomePage(gradientColors: gradientColors),
        '/medicine': (context) =>
            const CurePage(gradientColors: gradientColors),
        '/profile': (context) => Login(),
        // Define other routes here
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final List<Color> gradientColors;
  const MyHomePage({super.key, required this.gradientColors});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Color appBarTextColor = widget.gradientColors.first.computeLuminance() < 0.5
        ? Colors.white
        : Colors.black;

    final double bottomNavBarHeight = 60.0;
    final double bottomNavBarOffset = 15.0;

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SvgPicture.asset('assets/images/logonew.svg', height: 40),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.notifications_none,
                color: appBarTextColor,
                size: 28,
              ),
            ),
            onPressed: () {
              // TODO: Handle notifications
              print("Notifications tapped");
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: widget.gradientColors,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: kToolbarHeight + MediaQuery.of(context).padding.top,
                bottom:
                    bottomNavBarHeight +
                    bottomNavBarOffset +
                    MediaQuery.of(context).padding.bottom +
                    20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 20.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Your Personal Guide to Self-Care for Common Ailments',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Take control of your health, save time, and find relief at home with BSDOC.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 30),
                        FractionallySizedBox(
                          widthFactor: 0.8,
                          child: ElevatedButton.icon(
                            icon: const Icon(
                              Icons.medication_liquid_outlined,
                              color: Color(0xFF014478),
                            ),
                            label: const Text('FIND A CURE'),
                            onPressed: () {
                              Navigator.pushNamed(context, '/medicine');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF014478),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 20.0,
                    ),
                    child: Center(
                      // --- START OF FIX ---
                      child: Image.asset(
                        'assets/images/logo.png',
                        // Set height as a fraction of the screen's height.
                        height: MediaQuery.of(context).size.height * 0.4,
                        fit: BoxFit.contain,
                      ),
                      // --- END OF FIX ---
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 12,
            right: 12,
            bottom: 15 + MediaQuery.of(context).padding.bottom,
            child: const GlobalBottomNav(currentIndex: 0),
          ),
        ],
      ),
    );
  }
}
