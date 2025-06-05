// File: bottom_app_bar_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // For your SVG icons
import 'main.dart';

// You might want to create placeholder screen widgets for navigation
// For example, in separate files or at the end of this file for now:
// class HomeScreen extends StatelessWidget { const HomeScreen({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("Home Screen")), body: const Center(child: Text("Home Page Content"))); }
// class DoctorScreen extends StatelessWidget { const DoctorScreen({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("Doctor Screen")), body: const Center(child: Text("Doctor Page Content"))); }
// class MedicineScreen extends StatelessWidget { const MedicineScreen({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("Medicine Screen")), body: const Center(child: Text("Medicine Page Content"))); }
// class ProfileScreen extends StatelessWidget { const ProfileScreen({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("Profile Screen")), body: const Center(child: Text("Profile Page Content"))); }
// class MenuPageScreen extends StatelessWidget { const MenuPageScreen({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("Menu Screen")), body: const Center(child: Text("Menu Page Content"))); }

class BottomAppBarWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColor;

  const BottomAppBarWidget({
    Key? key,
    this.backgroundColor = const Color(0xFFABCFF3), // Default: Light blue
    this.iconColor = const Color(0xFF0D47A1), // Default: Dark blue for icons
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> actualIconAssetPaths = [
      'assets/images/home.svg',
      'assets/images/doctor.svg',
      'assets/images/medicine.svg',
      'assets/images/profile.svg',
      'assets/images/menu.svg', // This will now navigate to a page
    ];

    String getLabelForIndex(int index) {
      switch (index) {
        case 0:
          return 'Home';
        case 1:
          return 'Doctor';
        case 2:
          return 'Medicine';
        case 3:
          return 'Profile';
        case 4:
          return 'Menu'; // Changed from "More Options" to "Menu Page"
        default:
          return '';
      }
    }

    List<Widget> navIcons = List.generate(actualIconAssetPaths.length, (index) {
      String currentAssetPath = actualIconAssetPaths[index];
      return Expanded(
        child: InkWell(
          onTap: () {
            String iconLabel = getLabelForIndex(index);
            print(
              'Icon ${index + 1} ($iconLabel - ${currentAssetPath}) tapped.',
            );

            // --- MODIFIED: All icons navigate to a page ---
            switch (index) {
              case 0: // home.svg
                print('Navigate to Home Page');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyApp()),
                );
                // TODO: Replace with actual navigation
                // Example: Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                break;
              case 1: // doctor.svg
                print('Navigate to Doctor Page');
                // TODO: Replace with actual navigation
                // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => const DoctorScreen()));
                break;
              case 2: // medicine.svg
                print('Navigate to Medicine Page');
                // TODO: Replace with actual navigation
                // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => const MedicineScreen()));
                break;
              case 3: // profile.svg
                print('Navigate to Profile Page');
                // TODO: Replace with actual navigation
                // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
                break;
              case 4: // menu.svg - Now navigates to a page
                print('Navigate to Menu Page');
                // TODO: Replace with actual navigation to your dedicated menu/settings page
                // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => const MenuPageScreen()));
                break;
            }
          },
          customBorder: const CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  currentAssetPath,
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                  placeholderBuilder: (BuildContext context) => const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                // Optional: Text labels below icons
                // const SizedBox(height: 2),
                // Text(
                //   getLabelForIndex(index),
                //   style: TextStyle(color: iconColor.withOpacity(0.8), fontSize: 10),
                //   maxLines: 1,
                //   overflow: TextOverflow.ellipsis,
                // ),
              ],
            ),
          ),
        ),
      );
    });

    return BottomAppBar(
      color: backgroundColor,
      child: SizedBox(
        height: kBottomNavigationBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: navIcons,
        ),
      ),
    );
  }
}
