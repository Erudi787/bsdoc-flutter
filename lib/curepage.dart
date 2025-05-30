import 'package:flutter/material.dart';

class CurePage extends StatelessWidget {
  const CurePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Your Cure'),
        backgroundColor: Theme.of(
          context,
        ).colorScheme.primary, // Or any color you like
        leading: IconButton(
          // Optional: Add a back button
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigates back to the previous page
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'This is the Cure Page!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Example: Button to go back
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
