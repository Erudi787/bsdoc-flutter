import 'package:flutter/material.dart';

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
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 100,
              color: Theme.of(context).colorScheme.primary,
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
      body: Container(
        decoration: BoxDecoration(
          color: Color(0XFF16697A),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ailments',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Take control of your health charingg',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        //print text
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blueGrey[800],
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                        'FIND A CURE YIEIEEE',
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}