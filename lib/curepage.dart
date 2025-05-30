import 'package:flutter/material.dart';

class CurePage extends StatefulWidget {
  final List<Color> gradientColors;
  final AlignmentGeometry beginAlignment;
  final AlignmentGeometry endAlignment;
  final List<double>? stops;

  const CurePage({
    super.key,
    this.gradientColors = const [
      Color(0xFF014478),
      Color(0xFF018ABE),
      Color(0xFF93CBD8),
    ],
    this.beginAlignment = Alignment.topCenter,
    this.endAlignment = Alignment.bottomCenter,
    this.stops,
  });

  @override
  State<CurePage> createState() => _CurePageState();
}

class _CurePageState extends State<CurePage> {
  // 1. Add a state variable for your new inline switch
  bool _isInlineSwitchOn = false;

  @override
  Widget build(BuildContext context) {
    final bool isDarkGradientStart =
        widget.gradientColors.isNotEmpty &&
        widget.gradientColors.first.computeLuminance() < 0.5;
    final Color appBarContentColor = isDarkGradientStart
        ? Colors.white
        : Colors.black;

    final bool isDarkGradientEnd =
        widget.gradientColors.isNotEmpty &&
        widget.gradientColors.last.computeLuminance() < 0.5;
    final Color bottomNavBarContentColor = isDarkGradientEnd
        ? Colors.white
        : Colors.black;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Find a Cure'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: appBarContentColor),
        titleTextStyle: TextStyle(
          color: appBarContentColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.gradientColors,
            begin: widget.beginAlignment,
            end: widget.endAlignment,
            stops: widget.stops,
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: kToolbarHeight + 20),
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
                const SizedBox(height: 16),
                // 2. Modify this Row: "Advanced Search" text and the new Switch
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center the content of the row
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Align items vertically
                  children: [
                    const Text(
                      'Advanced Search',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(width: 10), // Space between text and switch
                    // 3. Add the Switch here
                    Switch.adaptive(
                      value: _isInlineSwitchOn,
                      onChanged: (bool newValue) {
                        setState(() {
                          _isInlineSwitchOn = newValue;
                        });
                      },
                      activeColor:
                          Colors.lightBlueAccent, // Or any color you prefer
                      // inactiveTrackColor: Colors.grey.withOpacity(0.5), // For Material switch
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // Your TextField or other UI elements can go here
                // Example:
                // TextField(
                //   decoration: InputDecoration(
                //     hintText: 'Enter search term...',
                //     hintStyle: TextStyle(color: Colors.white70),
                //     // ... more styling
                //   ),
                // ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: bottomNavBarContentColor),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.search, color: bottomNavBarContentColor),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.person, color: bottomNavBarContentColor),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
