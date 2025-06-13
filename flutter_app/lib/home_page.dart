// File: lib/pages/home_page.dart
import 'package:bsdoc_flutter/components/appbar.dart';
import 'package:bsdoc_flutter/components/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  final List<Color> gradientColors;
  const HomePage({super.key, required this.gradientColors});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: MainAppBar(
          title: SvgPicture.asset('assets/images/logonew.svg', height: 40),
          appBarTextColor: appBarTextColor,
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
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
                    // --- YOUR HOME PAGE CONTENT IS RESTORED HERE ---
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
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: MediaQuery.of(context).size.height * 0.3,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
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
