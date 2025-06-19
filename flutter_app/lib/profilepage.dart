// File: lib/profilepage.dart
import 'package:bsdoc_flutter/components/bottomnavbar.dart';
import 'package:bsdoc_flutter/components/appbar.dart';
import 'package:bsdoc_flutter/providers/AuthProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bsdoc_flutter/providers/AuthProvider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _pushNotificationsEnabled = true;
  bool _emailNotificationsEnabled = false;

  // This variable tracks the state of the expandable section
  bool _isHealthProfileExpanded = false;

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

    final authProvider = Provider.of<AuthProvider>(context);
    final userProfile = authProvider.userProfile;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
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
                bottom: 60 + 15 + MediaQuery.of(context).padding.bottom + 10,
              ),
              child: Column(
                children: [
                  _buildProfileHeader(userProfile, authProvider),
                  _buildSectionCard(
                    title: "My Profile",
                    children: [
                      ExpansionTile(
                        key: const PageStorageKey('personal_info'),
                        title: Row(
                          children: const [
                            Icon(
                              Icons.person_outline,
                              color: Colors.white,
                              size: 25,
                            ),
                            SizedBox(width: 16),
                            Text(
                              "Personal Information",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        collapsedIconColor: Colors.white,
                        iconColor: Colors.white,
                        tilePadding: const EdgeInsets.symmetric(
                          vertical: 0.0,
                          horizontal: 16.0,
                        ),
                        // This is the content that shows when expanded
                        children: <Widget>[
                          Container(
                            color: Colors.white.withOpacity(0.05),
                            child: const Column(
                              children: [
                                ListTile(
                                  leading: Icon(
                                    Icons.cake_outlined,
                                    color: Colors.white70,
                                  ),
                                  title: Text(
                                    "Date of Birth",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 15,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "January 1, 1990",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.bloodtype_outlined,
                                    color: Colors.white70,
                                  ),
                                  title: Text(
                                    "Blood Type",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  subtitle: Text(
                                    "O+",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.height,
                                    color: Colors.white70,
                                  ),
                                  title: Text(
                                    "Height",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  subtitle: Text(
                                    "165 cm",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.monitor_weight_outlined,
                                    color: Colors.white70,
                                  ),
                                  title: Text(
                                    "Weight",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  subtitle: Text(
                                    "65 kg",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        onExpansionChanged: (bool expanding) {
                          setState(() {
                            _isHealthProfileExpanded = expanding;
                          });
                        },
                        initiallyExpanded: _isHealthProfileExpanded,
                      ),
                    ],
                  ),
                  _buildSectionCard(
                    title: "Medical History",
                    children: [
                      ExpansionTile(
                        key: const PageStorageKey('personal_info'),
                        title: Row(
                          children: const [
                            Icon(
                              Icons.person_outline,
                              color: Colors.white,
                              size: 25,
                            ),
                            SizedBox(width: 16),
                            Text(
                              "Medical Record",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        collapsedIconColor: Colors.white,
                        iconColor: Colors.white,
                        tilePadding: const EdgeInsets.symmetric(
                          vertical: 0.0,
                          horizontal: 16.0,
                        ),
                        // This is the content that shows when expanded
                        children: <Widget>[
                          Container(
                            color: Colors.white.withOpacity(0.05),
                            child: const Column(
                              children: [
                                ListTile(
                                  leading: Icon(
                                    Icons.medical_information_outlined,
                                    color: Colors.white70,
                                  ),
                                  title: Text(
                                    "Health Conditions: ",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 15,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "None",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.fastfood_outlined,
                                    color: Colors.white70,
                                  ),
                                  title: Text(
                                    "Allergies",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  subtitle: Text(
                                    "Peanuts",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.height,
                                    color: Colors.white70,
                                  ),
                                  title: Text(
                                    "Medications",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  subtitle: Text(
                                    "something pang maintenance",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.monitor_weight_outlined,
                                    color: Colors.white70,
                                  ),
                                  title: Text(
                                    "Past Surgeries",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  subtitle: Text(
                                    "opera sa kuko",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        onExpansionChanged: (bool expanding) {
                          setState(() {
                            _isHealthProfileExpanded = expanding;
                          });
                        },
                        initiallyExpanded: _isHealthProfileExpanded,
                      ),
                    ],
                  ),
                  _buildSectionCard(
                    title: "Medical History",
                    children: [
                      ExpansionTile(
                        key: const PageStorageKey('personal_info'),
                        title: Row(
                          children: const [
                            Icon(
                              Icons.person_outline,
                              color: Colors.white,
                              size: 25,
                            ),
                            SizedBox(width: 16),
                            Text(
                              "BSDOC Records",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        collapsedIconColor: Colors.white,
                        iconColor: Colors.white,
                        tilePadding: const EdgeInsets.symmetric(
                          vertical: 0.0,
                          horizontal: 16.0,
                        ),
                        // This is the content that shows when expanded
                        children: <Widget>[
                          Container(
                            color: Colors.white.withOpacity(0.05),
                            child: const Column(
                              children: [
                                ListTile(
                                  leading: Icon(
                                    Icons.medical_information_outlined,
                                    color: Colors.white70,
                                  ),
                                  title: Text(
                                    "Medical Records",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 15,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "Sakit sa nawng",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.fastfood_outlined,
                                    color: Colors.white70,
                                  ),
                                  title: Text(
                                    "Prescriptions",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  subtitle: Text(
                                    "Image dapat ni",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        onExpansionChanged: (bool expanding) {
                          setState(() {
                            _isHealthProfileExpanded = expanding;
                          });
                        },
                        initiallyExpanded: _isHealthProfileExpanded,
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
            child: const GlobalBottomNav(currentIndex: 3),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(
    Map<String, dynamic>? user,
    AuthProvider authProvider,
  ) {
    final userFirstName = Provider.of<AuthProvider>(
      context,
      listen: false,
    ).userFirstName;
    final userLastName = Provider.of<AuthProvider>(
      context,
      listen: false,
    ).userLastName;
    final userFullName = '$userFirstName $userLastName';
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
            user?['User'] ?? userFullName,
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
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.separated(
              padding: const EdgeInsets.only(bottom: 8.0),
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
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
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
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
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
