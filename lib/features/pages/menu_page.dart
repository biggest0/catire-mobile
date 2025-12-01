import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:catire_mobile/features/pages/about_page.dart';
import 'package:catire_mobile/features/pages/contact_page.dart';
import 'package:catire_mobile/features/pages/disclaimer_page.dart';

/// Menu page, route to about, disclaimer, and contact pages.
class MenuPage extends StatelessWidget {
  final Function(String, Widget)? onNavigate;

  const MenuPage({super.key, this.onNavigate});

  /// url_launcher package to open up social medial links in app browser.
  Future<void> _launchUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      // launch social media url to browser because actual app not installed on emulator
      if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
        throw Exception("Could not launch $url");
      }
    } catch (error) {
      print("Error launching URL: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // About
          ListTile(
            title: const Text(
              'About',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            onTap: () => onNavigate?.call("About", const AboutPage()),
          ),

          const SizedBox(height: 8),

          // Disclaimer
          ListTile(
            title: const Text(
              'Disclaimer',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            onTap: () => onNavigate?.call("Disclaimer", const DisclaimerPage()),
          ),

          const SizedBox(height: 8),

          // Contact
          ListTile(
            title: const Text(
              'Contact',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            onTap: () => onNavigate?.call("Contact", const ContactPage()),
          ),

          const SizedBox(height: 32),

          // Social media icons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.instagram, size: 32),
                onPressed: () =>
                    _launchUrl('https://www.instagram.com/catiretime'),
                tooltip: 'Instagram',
              ),
              const SizedBox(width: 24),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.youtube, size: 32),
                onPressed: () =>
                    _launchUrl('https://www.youtube.com/@catiretime'),
                tooltip: 'YouTube',
              ),
              const SizedBox(width: 24),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.xTwitter, size: 32),
                onPressed: () => _launchUrl('https://x.com/catiretime'),
                tooltip: 'X',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
