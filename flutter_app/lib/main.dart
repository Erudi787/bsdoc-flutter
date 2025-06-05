import 'package:flutter/material.dart';
// Assuming your custom pages are in these files
import 'curepage.dart';
import 'login.dart';
// Import your custom BottomAppBarWidget
import 'bottomAppBar.dart'; // Make sure this path is correct
import 'package:flutter_svg/flutter_svg.dart';

// Your MyApp class (defines the app and passes gradient info)
// No changes needed here from your last version
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final List<Color> gradientColors;
  final AlignmentGeometry beginAlignment;
  final AlignmentGeometry endAlignment;
  final List<double>? stops;

  const MyApp({
    super.key,
    this.gradientColors = const [
      Color(0xFF44A2E6), // Medium Blue
      Color(0xFFABCFF3), // Light Blue/Lavender
      Color(0xFFBBA8DF), // Light Purple
    ],
    this.beginAlignment = Alignment.topCenter,
    this.endAlignment = Alignment.bottomCenter,
    this.stops,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BSDOC App',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(
        gradientColors: gradientColors,
        beginAlignment: beginAlignment,
        endAlignment: endAlignment,
        stops: stops,
      ),
    );
  }
}

// Your MyHomePage StatefulWidget
// No changes needed here from your last version
class MyHomePage extends StatefulWidget {
  final List<Color> gradientColors;
  final AlignmentGeometry beginAlignment;
  final AlignmentGeometry endAlignment;
  final List<double>? stops;

  const MyHomePage({
    super.key,
    required this.gradientColors,
    required this.beginAlignment,
    required this.endAlignment,
    this.stops,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Your _MyHomePageState class
class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController
  _animationController; // Renamed from _controller for clarity
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // Renamed for clarity

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleDrawer() {
    if (_scaffoldKey.currentState != null) {
      if (_scaffoldKey.currentState!.isDrawerOpen) {
        _scaffoldKey.currentState!.closeDrawer();
        _animationController.reverse();
      } else {
        _scaffoldKey.currentState!.openDrawer();
        _animationController.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isAppBarDark = widget.gradientColors.first.computeLuminance() < 0.5;
    Color appBarTextColor = isAppBarDark ? Colors.white : Colors.black;
    // appBarTextColor = Colors.white; // Uncomment to always force white AppBar text

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor:
            Colors.transparent, // Makes AppBar background transparent
        elevation: 0, // Removes shadow
        title: SvgPicture.asset(
          'assets/images/logonew.svg', // Ensure this path is correct
          height: 50,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Icon(Icons.notifications, color: appBarTextColor),
            ),
            onPressed: _toggleDrawer, // Opens the drawer
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.gradientColors,
            begin: widget.beginAlignment,
            end: widget.endAlignment,
            stops: widget.stops,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: kToolbarHeight + MediaQuery.of(context).padding.top,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Personal Guide to Self-Care for Common Ailments',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Take control of your health, save time, and find relief at home with BSDOC.',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: FractionallySizedBox(
                        widthFactor: 0.7,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(
                              0xFF004AAD,
                            ), // Button background color
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CurePage(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('FIND A CURE'),
                              const SizedBox(width: 10.0),
                              SvgPicture.asset(
                                'assets/images/medicineicon.svg', // Ensure this path is correct
                                height: 24,
                                width: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                  child: Image.asset(
                    // Make sure this path is correct in your assets
                    'assets/images/logo.png', // Assuming a larger logo image
                    height: 250, // Adjust as needed
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              // You would add your other sections (FeatureCards, AdvantageCards etc.) here
              // For example:
              // SizedBox(height:20),
              // Text("Other content sections would go here...", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70)),
              // SizedBox(height:400), // To test scrolling with bottom bar
            ],
          ),
        ),
      ),
      // Assigning your BottomAppBarWidget
      bottomNavigationBar: const BottomAppBarWidget(), // Using default colors
      // To customize colors for this specific page:
      // bottomNavigationBar: BottomAppBarWidget(
      //   backgroundColor: Colors.deepPurple,
      //   iconColor: Colors.white,
      // ),
    );
  }
}
