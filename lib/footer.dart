import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'curepage.dart';

// Approximate color mapping (replace with your exact theme colors if available)
const Color _primaryTealDark = Color(0xFF013638);
const Color _primaryTealMediumDark = Color(0xFF014C4E);
const Color _primaryTealMediumLight = Color(0xFF016668);
const Color _primaryTealLight = Color(0xFF018487);
const Color _ctaButtonColor = Color(0xFFED5050);
const Color _ctaButtonHoverColor = Color(0xFFD64646); // For ButtonStyle
const Color _yellowAccent = Color(0xFFFBC02D); // Example for yellow-300
const Color _decorativeCircleColor = Colors.teal; // Tailwind's teal-400

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      // Consider showing an error message to the user
      debugPrint('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    final int currentYear = DateTime.now().year;
    final screenWidth = MediaQuery.of(context).size.width;

    // Define responsive breakpoints
    const double mediumDeviceBreakpoint = 768;
    const double largeDeviceBreakpoint = 1024;

    bool isSmallScreen = screenWidth < mediumDeviceBreakpoint;
    bool isMediumScreen =
        screenWidth >= mediumDeviceBreakpoint &&
        screenWidth < largeDeviceBreakpoint;
    // bool isLargeScreen = screenWidth >= largeDeviceBreakpoint;

    return Stack(
      children: [
        // Decorative background elements
        Positioned(
          top: -80, // -top-20 * 4px
          right: -80, // -right-20 * 4px
          child: Container(
            width: 256, // w-64 * 4px
            height: 256, // h-64 * 4px
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _decorativeCircleColor.withAlpha(
                (0.05 * 255).round(),
              ), // Adjusted opacity from 0.10
            ),
          ),
        ),
        Positioned(
          bottom: -64, // -bottom-16 * 4px
          left: -64, // -left-16 * 4px
          child: Container(
            width: 288, // w-72 * 4px
            height: 288, // h-72 * 4px
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _decorativeCircleColor.withAlpha(
                (0.05 * 255).round(),
              ), // Adjusted opacity
            ),
          ),
        ),
        Column(
          children: [
            _CallToActionSection(
              isSmallScreen: isSmallScreen,
              launchURL: _launchURL,
            ),
            _MainFooterContent(
              currentYear: currentYear,
              isSmallScreen: isSmallScreen,
              isMediumScreen: isMediumScreen,
              launchURL: _launchURL,
            ),
          ],
        ),
      ],
    );
  }
}

// Call-to-action Section Widget
class _CallToActionSection extends StatelessWidget {
  final bool isSmallScreen;
  final Future<void> Function(String) launchURL;

  const _CallToActionSection({
    required this.isSmallScreen,
    required this.launchURL,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 64,
        horizontal: 24,
      ), // py-16, px-6
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [_primaryTealLight, _primaryTealMediumLight],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1300),
          child: Flex(
            direction: isSmallScreen ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: isSmallScreen
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              Expanded(
                // flex-1
                flex: isSmallScreen
                    ? 0
                    : 1, // On small screens, don't expand if it causes overflow with button
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: isSmallScreen
                              ? 30
                              : (MediaQuery.of(context).size.width > 900
                                    ? 48
                                    : 36), // Responsive font size
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.2, // leading-tight
                        ),
                        children: const [
                          TextSpan(text: "Not a common "),
                          TextSpan(
                            text: "ailment",
                            style: TextStyle(color: _yellowAccent),
                          ),
                          TextSpan(text: "?\nBook a doctor's appointment!"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      // max-w-lg
                      constraints: const BoxConstraints(maxWidth: 512),
                      child: Text(
                        "Connect with qualified healthcare professionals for personalized care and expert medical advice.",
                        style: TextStyle(
                          color: Colors.white.withAlpha((0.8 * 255).round()),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (isSmallScreen) const SizedBox(height: 32), // gap-8
              Column(
                crossAxisAlignment: isSmallScreen
                    ? CrossAxisAlignment.stretch
                    : CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.calendar_today_outlined, size: 24),
                    label: const Text("BOOK APPOINTMENT"),
                    onPressed: () {
                      // TODO: Replace with actual navigation or URL
                      // launchURL('/appointment-page');
                      debugPrint("Book Appointment Tapped");
                    },
                    style:
                        ElevatedButton.styleFrom(
                          backgroundColor: _ctaButtonColor,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: isSmallScreen
                                ? 24
                                : 48, // px-8 md:px-16
                            vertical: 16, // py-4
                          ),
                          textStyle: TextStyle(
                            fontSize: isSmallScreen
                                ? 16
                                : 18, // text-base md:text-lg
                            fontWeight: FontWeight.w600, // font-semibold
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              12,
                            ), // rounded-xl
                          ),
                          elevation: 5, // shadow-lg
                        ).copyWith(
                          overlayColor: WidgetStateProperty.resolveWith<Color?>(
                            (Set<WidgetState> states) {
                              if (states.contains(WidgetState.hovered)) {
                                return _ctaButtonHoverColor.withAlpha(
                                  (0.8 * 255).round(),
                                );
                              }
                              if (states.contains(WidgetState.pressed)) {
                                return _ctaButtonHoverColor;
                              }
                              return null; // Use the component's default.
                            },
                          ),
                        ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "No waiting lines. Quick response.",
                    style: TextStyle(
                      color: Colors.white.withAlpha((0.7 * 255).round()),
                      fontSize: 14,
                    ),
                    textAlign: isSmallScreen ? TextAlign.center : TextAlign.end,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Main Footer Content Widget
class _MainFooterContent extends StatelessWidget {
  final int currentYear;
  final bool isSmallScreen;
  final bool isMediumScreen;
  final Future<void> Function(String) launchURL;

  const _MainFooterContent({
    required this.currentYear,
    required this.isSmallScreen,
    required this.isMediumScreen,
    required this.launchURL,
  });

  @override
  Widget build(BuildContext context) {
    // Determine number of columns for the grid
    int crossAxisCount;
    if (isSmallScreen) {
      crossAxisCount = 1;
    } else if (isMediumScreen) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 4;
    }

    final List<Widget> footerColumns = [
      _FooterColumnLogo(launchURL: launchURL),
      _FooterColumnLinks(
        title: "Quick Links",
        pageBuilders: {
          "Symptom Checker": (context) => const CurePage(),
          "OTC Medications": (context) => const CurePage(), //change later once implemented
          "Find Doctors": (context) => const CurePage(), //change later once implemented
          "Register as Doctor": (context) => const CurePage(), //change later once implemented
        },
      ),
      _FooterColumnLinks(
        title: "Support",
        pageBuilders: {
          "FAQs": (context) => const CurePage(), //change later once implemented
          "Privacy Policy": (context) => const CurePage(), //change later once implemented
          "Terms & Conditions": (context) => const CurePage(), //change later once implemented
          "About Us": (context) => const CurePage(), //change later once implemented
          "Contact Us": (context) => const CurePage(), //change later once implemented
        },
      ),
      _FooterColumnContact(launchURL: launchURL),
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isSmallScreen ? 48 : 64,
        horizontal: 24,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [_primaryTealMediumDark, _primaryTealDark],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1300),
          child: Column(
            children: [
              if (isSmallScreen)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: footerColumns
                      .map(
                        (col) => Padding(
                          padding: const EdgeInsets.only(bottom: 40.0),
                          child: col,
                        ),
                      )
                      .toList(),
                )
              else
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: footerColumns.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: isMediumScreen
                        ? 1.8
                        : (isSmallScreen ? 3 : 1.5), // Adjust aspect ratio
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    return footerColumns[index];
                  },
                ),
              const SizedBox(height: 48), // mb-12 before disclaimer
              _FooterDisclaimer(
                currentYear: currentYear,
                isSmallScreen: isSmallScreen,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterColumnLogo extends StatelessWidget {
  final Future<void> Function(String) launchURL;
  const _FooterColumnLogo({required this.launchURL});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: SvgPicture.asset(
            'assets/images/logo-white.svg', // Ensure this path is correct
            height:
                80, // Adjusted height (original h-24 is too large for typical footer)
            width: 240, // Provide a width for better layout control
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ), // Assuming white version of SVG
          ),
        ),
        Text(
          "Your trusted resource for self-care guidance, symptom checking, and connecting with healthcare professionals.",
          style: TextStyle(
            color: Colors.white.withAlpha((0.8 * 255).round()),
            fontSize: 14,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            _SocialIcon(
              icon: FontAwesomeIcons.facebookF,
              url: "#",
              hoverColor: Colors.blue[300]!,
              launchURL: launchURL,
            ),
            _SocialIcon(
              icon: FontAwesomeIcons.twitter,
              url: "#",
              hoverColor: Colors.lightBlue[300]!,
              launchURL: launchURL,
            ),
            _SocialIcon(
              icon: FontAwesomeIcons.instagram,
              url: "#",
              hoverColor: Colors.pink[300]!,
              launchURL: launchURL,
            ),
            _SocialIcon(
              icon: FontAwesomeIcons.github,
              url: "",
              hoverColor: Colors.purple[300]!,
              launchURL: launchURL,
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;
  final Color hoverColor;
  final Future<void> Function(String) launchURL;

  const _SocialIcon({
    required this.icon,
    required this.url,
    required this.hoverColor,
    required this.launchURL,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: InkWell(
        onTap: () => launchURL(url),
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha((0.1 * 255).round()),
            shape: BoxShape.circle,
          ),
          child: Center(child: FaIcon(icon, color: Colors.white, size: 16)),
        ),
        // TODO: Add hover effects if needed via MouseRegion for color change
      ),
    );
  }
}

class _FooterColumnLinks extends StatelessWidget {
  final String title;
  final Map<String, WidgetBuilder> pageBuilders;

  const _FooterColumnLinks({
    required this.title,
    required this.pageBuilders,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        ...pageBuilders.entries.map((entry) {
          final String linkText = entry.key;
          final WidgetBuilder builder = entry.value;
          return _FooterLinkItem(
            text: linkText,
            onTap: () {
              Navigator.push(
                context, MaterialPageRoute(builder: builder)
              );
            },
          );
        }),
      ],
    );
  }
}

class _FooterLinkItem extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _FooterLinkItem({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: onTap,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white.withAlpha((0.8 * 255).round()),
            fontSize: 15,
          ),
          // TODO: Add hover effect for text color and padding (MouseRegion)
        ),
      ),
    );
  }
}

class _FooterColumnContact extends StatelessWidget {
  final Future<void> Function(String) launchURL;
  const _FooterColumnContact({required this.launchURL});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Contact Us",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        _ContactInfoItem(
          icon: Icons.email_outlined,
          text: "support@bsdoc.com",
          launchURL: launchURL,
          url: "mailto:support@bsdoc.com",
        ),
        const SizedBox(height: 16),
        _ContactInfoItem(
          icon: Icons.phone_outlined,
          text: "+1 (800) 123-4567",
          launchURL: launchURL,
          url: "tel:+18001234567",
        ),
        const SizedBox(height: 24),
        TextButton.icon(
          icon: const Icon(Icons.support_agent, size: 18),
          label: const Text("Get Support"),
          onPressed: () {
            // TODO: Replace with actual navigation or URL
            // launchURL("/contact-us");
            debugPrint("Get Support Tapped");
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: _decorativeCircleColor.withAlpha(
              (0.3 * 255).round(),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}

class _ContactInfoItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final String url;
  final Future<void> Function(String) launchURL;

  const _ContactInfoItem({
    required this.icon,
    required this.text,
    required this.url,
    required this.launchURL,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launchURL(url),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: _decorativeCircleColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white.withAlpha((0.8 * 255).round()),
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterDisclaimer extends StatelessWidget {
  final int currentYear;
  final bool isSmallScreen;
  const _FooterDisclaimer({
    required this.currentYear,
    required this.isSmallScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 32),
      margin: const EdgeInsets.only(top: 32),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.white.withAlpha((0.1 * 255).round()),
            width: 1,
          ),
        ),
      ),
      child: Flex(
        direction: isSmallScreen ? Axis.vertical : Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Disclaimer: This service is for informational purposes only. Always consult a qualified healthcare professional for medical advice.",
            style: TextStyle(
              color: Colors.white.withAlpha((0.7 * 255).round()),
              fontSize: 12,
            ),
            textAlign: isSmallScreen ? TextAlign.center : TextAlign.left,
          ),
          if (isSmallScreen) const SizedBox(height: 16),
          Text(
            "© $currentYear BSDOC. All rights reserved.",
            style: TextStyle(
              color: Colors.white.withAlpha((0.7 * 255).round()),
              fontSize: 12,
            ),
            textAlign: isSmallScreen ? TextAlign.center : TextAlign.right,
          ),
        ],
      ),
    );
  }
}
