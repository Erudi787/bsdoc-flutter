import 'package:flutter/material.dart';

class CurePage extends StatefulWidget {
  final List<Color> gradientColors;
  final AlignmentGeometry beginAlignment;
  final AlignmentGeometry endAlignment;
  final List<double>? stops;

  const CurePage({
    super.key,
    this.gradientColors = const [
      Color(0xFF014478), // Dark Blue
      Color(0xFF018ABE), // Medium Blue
      Color(0xFF93CBD8), // Light Blue
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                      // FIX: Replaced withOpacity with withAlpha
                      inactiveTrackColor: Colors.white.withAlpha(
                        (255 * 0.3).round(),
                      ), // Line ~147
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter symptoms, conditions, etc.',
                    // FIX: Replaced withOpacity with withAlpha
                    hintStyle: TextStyle(
                      color: Colors.white.withAlpha((255 * 0.7).round()),
                    ), // Line ~162
                    labelText: 'Search your current Symptoms',
                    // FIX: Replaced withOpacity with withAlpha
                    labelStyle: TextStyle(
                      color: Colors.white.withAlpha((255 * 0.9).round()),
                    ), // Line ~164
                    filled: true,
                    // FIX: Replaced withOpacity with withAlpha
                    fillColor: Colors.white.withAlpha(
                      (255 * 0.1).round(),
                    ), // Line ~166
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
                      // FIX: Replaced withOpacity with withAlpha
                      borderSide: BorderSide(
                        color: Colors.white.withAlpha((255 * 0.3).round()),
                        width: 1.0,
                      ), // Line ~184
                    ),
                    // FIX: Replaced withOpacity with withAlpha
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white.withAlpha((255 * 0.7).round()),
                    ), // Line ~190
                  ),
                  onChanged: (text) {},
                  onSubmitted: (text) {},
                ),
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
              onPressed: () {
                /* TODO: Implement action */
              }, // Line ~217
            ),
            IconButton(
              icon: Icon(Icons.search, color: bottomNavBarContentColor),
              onPressed: () {
                /* TODO: Implement action */
              }, // Line ~223
            ),
            IconButton(
              icon: Icon(Icons.person, color: bottomNavBarContentColor),
              onPressed: () {
                /* TODO: Implement action */
              }, // Line ~229
            ),
          ],
        ),
      ),
    );
  }
}
