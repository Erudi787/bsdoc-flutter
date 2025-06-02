import 'package:flutter/material.dart';
import 'curepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BSDOC App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF82c0cc)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleDrawer() {
    if (_scaffoldkey.currentState!.isDrawerOpen) {
      _scaffoldkey.currentState!.closeDrawer();
      _controller.reverse();
    } else {
      _scaffoldkey.currentState!.openDrawer();
      _controller.forward();
    }
  }

  Widget _buildAdvantageCard({
    required IconData icon,
    required Color iconBackgroundColor,
    required Color iconColor,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ), // Added more vertical margin
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Color(0xcd043caa),
            spreadRadius: .25,
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: Colors.grey.shade200,
        ), // Optional: if you want a very subtle border
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 35),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff043CAA), // Dark blue color for title
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black54, // Slightly lighter for description
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _helpsAdvantageCard({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: BoxDecoration(color: Colors.transparent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 35),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: const Color.fromARGB(255, 85, 85, 85),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: Color(0xDD000000),
        elevation: 0,
        leading: IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _controller,
            color: Colors.white,
          ),
          onPressed: _toggleDrawer,
        ),
        title: const Text(''),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       // function here
        //     },
        //     icon: Icon(Icons.notifications_none, color: Colors.white),
        //   ),
        //   Padding(
        //     padding: const EdgeInsets.only(right: 16.0),
        //     child: Icon(Icons.person, color: Colors.grey[700]),
        //   ),
        // ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 100,
              color: Theme.of(context).colorScheme.primary,
              margin: EdgeInsets.symmetric(horizontal: 16),
            ),
            ListTile(
              title: const Text(
                'Home',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
              onTap: () {
                _toggleDrawer();
                //print shi
              },
            ),
            ListTile(
              title: const Text(
                'Doctors',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
              onTap: () {
                _toggleDrawer();
                //print('Navigating to blabla');
              },
            ),
            ListTile(
              title: const Text(
                'Schedule Appointment',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
              onTap: () {
                _toggleDrawer();
              },
            ),
            ListTile(
              title: const Text(
                'Sign In',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
              onTap: () {
                _toggleDrawer();
              },
            ),
          ],
        ),
      ),
      onDrawerChanged: (isOpened) {
        if (!isOpened) {
          _controller.reverse();
        } else {
          _controller.forward();
        }
      },
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(color: Color(0xff16697a)),
              child: Padding(
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
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Take control of your health, save time, and find relief at home with BSDOC.',
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CurePage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blueGrey[800],
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'FIND A CURE YIEEEEE',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            Container(
              color: Color(0xffeef2f7),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "WHAT WE OFFER",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Our Services",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    height: 2,
                    width: 60,
                    color: Colors.blueAccent,
                  ),
                  Text(
                    "Comprehensive health tools designed to support your well-being journey with confidence and clarity.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black87),
                  ),

                  //symptom checker
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/images/logo.png',
                                width: 30,
                                height: 30,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Title
                        const Text(
                          'Symptom Checker',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff043CAA),
                          ),
                        ),
                        const SizedBox(height: 8),

                        //description
                        const Text(
                          'Input your symptoms to find the right cure, view search results filtered according to your symptoms, and access visual aids with explanations to better understand your condition.',
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                        const SizedBox(height: 12),

                        //learn more link
                        Row(
                          children: const [
                            Text(
                              'Learn more',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff3366ff),
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.arrow_right_alt,
                              color: Color(0xff3366ff),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  //personalized health tips
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/images/logo.png',
                                width: 30,
                                height: 30,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Title
                        const Text(
                          'Personalized Health Tips',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff043CAA),
                          ),
                        ),
                        const SizedBox(height: 8),

                        //description
                        const Text(
                          'Receive personalized health and wellness tips based on your profile and symptom history, save and track your health data over time, and get email or SMS notifications for self-care reminders.',
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                        const SizedBox(height: 12),

                        //learn more link
                        Row(
                          children: const [
                            Text(
                              'Learn more',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff3366ff),
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.arrow_right_alt,
                              color: Color(0xff3366ff),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  //otc medication guide
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/images/logo.png',
                                width: 30,
                                height: 30,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Title
                        const Text(
                          'OTC Medication Guidance',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff043CAA),
                          ),
                        ),
                        const SizedBox(height: 8),

                        //description
                        const Text(
                          'Find the right over-the-counter medications based on your symptoms, access detailed information on their uses, dosages, and precautions, and stay informed about potential drug interactions and contraindications.',
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                        const SizedBox(height: 12),

                        //learn more link
                        Row(
                          children: const [
                            Text(
                              'Learn more',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff3366ff),
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.arrow_right_alt,
                              color: Color(0xff3366ff),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // advantages section
            Container(
              color: Color(0xffffffff),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'ADVANTAGES',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent[700],
                      fontSize: 16,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Why Choose BSDOC?',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff043caa),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 12),
                    height: 3,
                    width: 70,
                    color: Colors.blueAccent[700],
                  ),
                  Text(
                    'Experience a new approach to managing your health with our comprehensive self-care platform.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 30),

                  _buildAdvantageCard(
                    icon: Icons.access_time,
                    iconBackgroundColor: Color(0xffe3f2fd),
                    iconColor: Color(0xff1e88e5),
                    title: 'Save Time & Effort',
                    description:
                        'Get immediate self-care guidance without waiting for appointments for common issues.',
                  ),

                  _buildAdvantageCard(
                    icon: Icons.lightbulb,
                    iconBackgroundColor: Color(0xffe3f2fd),
                    iconColor: Color(0xff1e88e5),
                    title: 'Informed Decisions',
                    description:
                        'Understand your symptoms and learn about appropriate OTC options.',
                  ),

                  _buildAdvantageCard(
                    icon: Icons.person,
                    iconBackgroundColor: Color(0xffe3f2fd),
                    iconColor: Color(0xff1e88e5),
                    title: 'Personalized Care',
                    description:
                        'Receive tips and reminders tailored to your health profile.',
                  ),

                  _buildAdvantageCard(
                    icon: Icons.menu_book_sharp,
                    iconBackgroundColor: Color(0xffe3f2fd),
                    iconColor: Color(0xff1e88e5),
                    title: 'Accessible Knowledge',
                    description:
                        'Empower yourself with reliable health information anytime, anywhere.',
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 40,
                    ),
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6F0FF), // Light blue background
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Ready to take control of your health?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xFF0033AA),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Join thousands who are already using BSDOC to make better health decisions.',
                          style: TextStyle(color: Colors.black87, fontSize: 14),
                        ),
                        const SizedBox(height: 50),
                        Center(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF0033aa),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 14,
                              ),
                            ),
                            onPressed: () {
                              // Handle navigation or action
                            },
                            icon: const Icon(
                              Icons.arrow_forward,
                              size: 18,
                              color: Colors.white,
                            ),
                            label: const Text(
                              'Get Started Now',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            Container(
              color: Color(0xffeef2f7),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "STEP BY STEP",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "How BSDOC Helps You",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0033aa),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    height: 2,
                    width: 60,
                    color: Colors.blueAccent,
                  ),
                  _helpsAdvantageCard(
                    icon: Icons.edit_square, // Pencil/edit icon
                    iconBgColor: Color(0xFFc0d9ff), // Light blue
                    iconColor: Color(0xFF215aF3), // Blue
                    title: "Describe Your Symptoms",
                    description:
                        "Use our intuitive interface to input the symptoms you are experiencing.",
                  ),
                  _helpsAdvantageCard(
                    icon: Icons.sticky_note_2,
                    iconBgColor: Color(0xFFd3ffdf),
                    iconColor: Color(0xFF00d43a),
                    title: "Get Guided Information",
                    description:
                        "Receive potential causes, detailed self-care advices, and OTC medication guidance.",
                  ),
                  _helpsAdvantageCard(
                    icon: Icons.security,
                    iconBgColor: Color(0xFFf8dfff),
                    iconColor: Color(0xFFb300e7),
                    title: "Find Relief Safely",
                    description:
                        "Follow personalized tips and instructions to manage your condition effectively at home.",
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0033aa),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                      ),
                      onPressed: () {
                        // Handle navigation or action
                      },
                      icon: const Icon(
                        Icons.arrow_forward,
                        size: 18,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Get Started Now',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
