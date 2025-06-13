// File: lib/components/bottomnavbar.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GlobalBottomNav extends StatelessWidget {
  final int currentIndex;

  const GlobalBottomNav({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    const barBackgroundColor = Color(0xFFABCFF3);
    const inactiveIconColor = Color(0xFF0D47A1);
    const activeIconColor = Colors.white;
    const activeIconContainerColor = Color(0xFF0D47A1);

    final iconAssetPaths = [
      'assets/images/home.svg',
      'assets/images/doctor.svg',
      'assets/images/medicine.svg',
      'assets/images/profile.svg', // 4th icon
      'assets/images/menu.svg',
    ];

    // --- THIS LIST MUST BE IN THE CORRECT ORDER ---
    // The 4th route here must be '/profile' to match the 4th icon above.
    final routes = ['/home', '/doctors', '/medicine', '/profile', '/menu'];
    // --- END VERIFICATION ---

    return Container(
      height: 60.0,
      decoration: BoxDecoration(
        color: barBackgroundColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(iconAssetPaths.length, (index) {
            bool isActive = currentIndex == index;
            return Expanded(
              child: InkWell(
                onTap: () {
                  if (!isActive) {
                    // This will navigate to the route at the specific index
                    Navigator.pushReplacementNamed(context, routes[index]);
                  }
                },
                customBorder: const CircleBorder(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isActive
                            ? activeIconContainerColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SvgPicture.asset(
                        iconAssetPaths[index],
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          isActive ? activeIconColor : inactiveIconColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
