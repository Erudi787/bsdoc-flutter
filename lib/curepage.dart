import 'package:flutter/material.dart';

class CurePage extends StatelessWidget {
  // You can pass a color to this page or define it here
  final Color pageBackgroundColor;

  const CurePage({
    super.key,
    this.pageBackgroundColor =
        Colors.white, // Default background color is white
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000000), // Use the passed background color
      appBar: AppBar(
        // 2. Display "Find a Cure" on top
        title: const Text('Find a Cure'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
        titleTextStyle: TextStyle(
          color: Color(0xFFFFFFFF),
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
      body: Container(), // An empty Container makes the body blank
      // If you want to center something on the "blank" page, you could use:
      // body: const Center(
      //   child: Text(
      //     'Content will go here',
      //     style: TextStyle(color: Colors.grey),
      //   ),
      // ),
    );
  }
}
