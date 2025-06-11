// lib/components/appbar.dart
import 'package:bsdoc_flutter/providers/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';

// I moved ProfileMenuButton from main.dart to here to keep the AppBar related widgets together.
class ProfileMenuButton extends StatefulWidget {
  const ProfileMenuButton({super.key});

  @override
  State<ProfileMenuButton> createState() => _ProfileMenuButtonState();
}

class _ProfileMenuButtonState extends State<ProfileMenuButton> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final imageUrl = authProvider.userProfile?['profile_image_url'];

    ImageProvider backgroundImage;
    if (imageUrl != null && imageUrl is String && imageUrl.isNotEmpty) {
      backgroundImage = NetworkImage(imageUrl);
    }
    else {
      backgroundImage = const AssetImage('assets/images/test.png');
    }
    debugPrint('imageUrl: $imageUrl');

    return GestureDetector(
      onTap: () {
        showPopover(
          context: context,
          bodyBuilder: (context) => _buildPopoverContent(context),
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
          backgroundImage: backgroundImage,
          radius: 16,
          onBackgroundImageError: (exception, stackTrace) {
            debugPrint('Image load error: $exception');
          },
          // child: imageUrl == null || imageUrl.toString().isEmpty
          //   ? const Icon(Icons.person, size: 16, color: Colors.white)
          //   : null,
          backgroundColor: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildPopoverContent(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                debugPrint('settings bitchh');
                Navigator.pop(context); // Close popover
              },
              tooltip: 'Settings',
              icon: const Icon(Icons.settings),
            ),
            IconButton(
              onPressed: () {
                debugPrint('logout bitchh');
                //Provider.of<AuthProvider>(context, listen: false).logout();
                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      title: const Text('Confirm Logout'),
                      content: const Text('Are you sure you want to log out?'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            // Just close the dialog
                            Navigator.of(dialogContext).pop();
                          },
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red, // For emphasis
                          ),
                          child: const Text('Logout'),
                          onPressed: () {
                            // Close the dialog
                            Navigator.of(dialogContext).pop();
                            Navigator.pop(context); // Close popover
                            // 3. Trigger the logout action
                            Provider.of<AuthProvider>(
                              context,
                              listen: false,
                            ).logout();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              tooltip: 'Logout',
              icon: const Icon(Icons.power_settings_new),
            ),
          ],
        ),
      ),
    );
  }
}

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Color appBarTextColor;

  const MainAppBar({super.key, this.title, required this.appBarTextColor});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: title,
      centerTitle: true,
      // This will automatically add a back button when needed
      automaticallyImplyLeading: true,
      iconTheme: IconThemeData(color: appBarTextColor),
      titleTextStyle: TextStyle(
        color: appBarTextColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      actions: authProvider.isLoggedIn
          ? [
              IconButton(
                icon: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.notifications_none,
                    color: appBarTextColor,
                    size: 28,
                  ),
                ),
                onPressed: () {
                  debugPrint("Notifications tapped");
                },
              ),
              const Padding(
                padding: EdgeInsets.only(right: 12),
                child: ProfileMenuButton(),
              ),
            ]
          : [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
