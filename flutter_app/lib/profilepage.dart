// File: lib/profilepage.dart
import 'package:bsdoc_flutter/components/bottomnavbar.dart';
import 'package:bsdoc_flutter/components/appbar.dart';
import 'package:bsdoc_flutter/providers/AuthProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _pushNotificationsEnabled = true;
  bool _emailNotificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    const gradientColors = [
      Color(0xFF44A2E6),
      Color(0xFFABCFF3),
      Color(0xFFBBA8DF),
    ];
    final appBarTextColor = gradientColors.first.computeLuminance() < 0.5
        ? Colors.white
        : Colors.black;

    // Listen to AuthProvider to get user details for the header
    final authProvider = Provider.of<AuthProvider>(context);
    final userProfile = authProvider.userProfile;

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      // Using your custom MainAppBar component
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: MainAppBar(
          title: Text(
            "Profile",
            style: TextStyle(
              color: appBarTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          appBarTextColor: appBarTextColor,
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: kToolbarHeight + MediaQuery.of(context).padding.top,
                bottom: 60 + 15 + MediaQuery.of(context).padding.bottom + 20,
              ),
              child: Column(
                children: [
                  _buildProfileHeader(userProfile, authProvider),
                  _buildSectionCard(
                    title: "General",
                    children: [
                      _buildInfoRow(
                        context,
                        icon: Icons.person_outline,
                        text: "My Health Profile",
                        onTap: () {},
                      ),
                      _buildInfoRow(
                        context,
                        icon: Icons.payment_outlined,
                        text: "Payment Methods",
                        onTap: () {},
                      ),
                    ],
                  ),
                  _buildSectionCard(
                    title: "Notifications",
                    children: [
                      _buildSwitchRow(
                        context,
                        icon: Icons.notifications_active_outlined,
                        text: "Push Notifications",
                        value: _pushNotificationsEnabled,
                        onChanged: (value) =>
                            setState(() => _pushNotificationsEnabled = value),
                      ),
                      _buildSwitchRow(
                        context,
                        icon: Icons.email_outlined,
                        text: "Email Notifications",
                        value: _emailNotificationsEnabled,
                        onChanged: (value) =>
                            setState(() => _emailNotificationsEnabled = value),
                      ),
                    ],
                  ),
                  _buildSectionCard(
                    title: "More",
                    children: [
                      _buildInfoRow(
                        context,
                        icon: Icons.help_outline,
                        text: "Help & Support",
                        onTap: () {},
                      ),
                      _buildInfoRow(
                        context,
                        icon: Icons.gavel_outlined,
                        text: "Terms and Conditions",
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 12,
            right: 12,
            bottom: 15 + MediaQuery.of(context).padding.bottom,
            child: const GlobalBottomNav(
              currentIndex: 3,
            ), // Pass index 3 for Profile
          ),
        ],
      ),
    );
  }

  // --- HELPER WIDGETS TO BUILD THE UI ---
  Widget _buildProfileHeader(
    Map<String, dynamic>? user,
    AuthProvider authProvider,
  ) {
    String? imageUrl = user?['profile_image_url'];
    ImageProvider profileImage = (imageUrl != null && imageUrl.isNotEmpty)
        ? NetworkImage(imageUrl)
        : const AssetImage('assets/images/test.png') as ImageProvider;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            backgroundImage: profileImage,
          ),
          const SizedBox(height: 12),
          Text(
            user?['full_name'] ?? 'User Name',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user?['email'] ?? 'user@email.com',
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: children.length,
              itemBuilder: (context, index) => children[index],
              separatorBuilder: (context, index) =>
                  Divider(color: Colors.white.withOpacity(0.2), height: 1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchRow(
    BuildContext context, {
    required IconData icon,
    required String text,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          CupertinoSwitch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.blue.shade200,
          ),
        ],
      ),
    );
  }
}
