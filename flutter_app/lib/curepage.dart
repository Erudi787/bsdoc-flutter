// File: lib/curepage.dart
import 'package:flutter/material.dart';
import 'package:bsdoc_flutter/components/bottomnavbar.dart'; // Import the global nav bar

class CurePage extends StatefulWidget {
  final List<Color> gradientColors;
  final AlignmentGeometry beginAlignment;
  final AlignmentGeometry endAlignment;
  final List<double>? stops;

  const CurePage({
    super.key,
    this.gradientColors = const [
      Color(0xFF44A2E6), // Matching MyApp's default gradient
      Color(0xFFABCFF3),
      Color(0xFFBBA8DF),
    ],
    this.beginAlignment = Alignment.topCenter,
    this.endAlignment = Alignment.bottomCenter,
    this.stops,
  });

  @override
  State<CurePage> createState() => _CurePageState();
}

class _CurePageState extends State<CurePage> {
  bool _isInlineSwitchOn = false;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine color for AppBar content based on the gradient
    final Color appBarContentColor =
        widget.gradientColors.first.computeLuminance() < 0.5
        ? Colors.white
        : Colors.black;

    // Define layout constants
    final double bottomNavBarHeight = 60.0;
    final double bottomNavBarOffset = 15.0;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // Dismiss keyboard on tap
      child: Scaffold(
        backgroundColor: Colors.transparent, // Important for gradient to show
        extendBodyBehindAppBar: true,
        extendBody: true, // Allows content to flow behind the floating bar
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Find a Cure'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          // Use the calculated color for the back arrow and title
          iconTheme: IconThemeData(color: appBarContentColor),
          titleTextStyle: TextStyle(
            color: appBarContentColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          // The back button is automatically added by Navigator, no need to define it manually
        ),
        // --- START OF MODIFICATION ---
        // We replace the Scaffold's body and bottomNavigationBar with a Stack
        body: Stack(
          children: [
            // Layer 1: Your existing page content with gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: widget.gradientColors,
                  begin: widget.beginAlignment,
                  end: widget.endAlignment,
                  stops: widget.stops,
                ),
              ),
              constraints: const BoxConstraints.expand(),
              child: SingleChildScrollView(
                // Make content scrollable
                padding: EdgeInsets.only(
                  // Add padding to prevent content being hidden by AppBar and floating nav bar
                  top: kToolbarHeight + MediaQuery.of(context).padding.top,
                  bottom:
                      bottomNavBarHeight +
                      bottomNavBarOffset +
                      MediaQuery.of(context).padding.bottom +
                      20,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Your existing content widgets are preserved
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Welcome to',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'BSDOC',
                            style: TextStyle(
                              color: Color(0xFFABCFF3),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Advanced Search',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(width: 10),
                          Switch.adaptive(
                            value: _isInlineSwitchOn,
                            onChanged: (bool newValue) {
                              setState(() {
                                _isInlineSwitchOn = newValue;
                              });
                            },
                            activeColor: Colors.lightBlueAccent,
                            inactiveThumbColor: Colors.white70,
                            inactiveTrackColor: Colors.white.withAlpha(
                              (255 * 0.3).round(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _searchController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Enter symptoms, conditions, etc.',
                          hintStyle: TextStyle(
                            color: Colors.white.withAlpha((255 * 0.7).round()),
                          ),
                          labelText: 'Search your current Symptoms',
                          labelStyle: TextStyle(
                            color: Colors.white.withAlpha((255 * 0.9).round()),
                          ),
                          filled: true,
                          fillColor: Colors.white.withAlpha(
                            (255 * 0.1).round(),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                              color: Colors.lightBlueAccent,
                              width: 1.5,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                              color: Colors.white.withAlpha(
                                (255 * 0.3).round(),
                              ),
                              width: 1.0,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white.withAlpha((255 * 0.7).round()),
                          ),
                        ),
                        onChanged: (text) {},
                        onSubmitted: (text) {},
                      ),
                      // Using a SizedBox instead of Spacer for predictable scroll height
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),

            // Layer 2: The Floating Global Bottom Navigation Bar
            Positioned(
              left: 12,
              right: 12,
              bottom: 15 + MediaQuery.of(context).padding.bottom,
              child: const GlobalBottomNav(
                currentIndex: 2,
              ), // Pass index 2 for the "Medicine" tab
            ),
          ],
        ),
        // REMOVED: The old bottomNavigationBar property
      ),
    );
  }
}
