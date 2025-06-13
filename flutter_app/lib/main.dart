// File: main.dart
import 'package:bsdoc_flutter/components/appbar.dart';
import 'package:bsdoc_flutter/doctors/registration.dart';
import 'package:bsdoc_flutter/profile.dart';
import 'package:bsdoc_flutter/providers/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bsdoc_flutter/components/bottomnavbar.dart'; // Using your previous correct structure
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

class ProfileMenuButton extends StatefulWidget {
  const ProfileMenuButton({super.key});

  @override
  State<ProfileMenuButton> createState() => _ProfileMenuButtonState();
}

class _ProfileMenuButtonState extends State<ProfileMenuButton> {
  final GlobalKey _buttonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _buttonKey,
      onTap: () {
        showPopover(
          context: context,
          bodyBuilder: (context) => _buildPopoverContent(context),
          onPop: () => debugPrint("Popover closed"),
          direction: PopoverDirection.bottom,
          arrowDxOffset: -3,
          arrowDyOffset: 10,
          arrowHeight: 10,
          arrowWidth: 20,
          backgroundColor: Colors.white,
          barrierColor: Colors.transparent,
        );
      },
      child: Padding(
        padding: EdgeInsets.only(right: 5),
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/images/test.png'),
          radius: 16,
        ),
      ),
    );
  }

  Widget _buildPopoverContent(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: IntrinsicWidth(
        //stepWidth: 50, // Optional: fine-tune minimum width
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                debugPrint('settings bitchh');
              },
              tooltip: 'Settings',
              icon: Icon(Icons.settings),
            ),
            IconButton(
              onPressed: () {
                debugPrint('logout bitchh');
                Provider.of<AuthProvider>(context, listen: false).logout();
              },
              tooltip: 'Logout',
              icon: Icon(Icons.power_settings_new),
            ),
            // ListTile(
            //   leading: Icon(Icons.settings),
            //   title: Text("Settings"),
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            // ),
            // ListTile(
            //   leading: Icon(Icons.power_settings_new),
            //   title: Text("Logout"),
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

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
    // ChangeNotifierProvider(
    //   create: (context) => AuthProvider(),
    //   child: const MyApp(),
    // ),
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

    //final loginStatus = isLoggedIn(context);

    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MaterialApp(
        title: 'BSDOC App',
        home: const MyHomePage(gradientColors: gradientColors),
        // home: Consumer<AuthProvider>(
        //   builder: (ctx, auth, _) {
        //     if (auth.isLoading) {
        //       return const Scaffold(
        //         body: Center(child: CircularProgressIndicator()),
        //       );
        //     }

        //     if (auth.isLoggedIn) {
        //       return const MyHomePage(gradientColors: gradientColors);
        //     } else {
        //       return const Login();
        //     }
        //   },
        // ),
        debugShowCheckedModeBanner: false,
        //initialRoute: '/home',
        routes: {
          '/home': (context) =>
              const MyHomePage(gradientColors: gradientColors),
          '/medicine': (context) =>
              const CurePage(gradientColors: gradientColors),
          '/profile': (context) {
            final loginStatus = Provider.of<AuthProvider>(
              context,
              listen: false,
            ).isLoggedIn;
            return loginStatus ? const ProfilePage() : Login();
          },
          '/login': (context) =>
            const Login(),
          '/doctors/registration': (context) =>
            const DoctorRegister(),
          // Define other routes here
        },
      ),
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
      appBar: MainAppBar(
        title: SvgPicture.asset('assets/images/logonew.svg', height: 40),
        appBarTextColor: appBarTextColor,
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
