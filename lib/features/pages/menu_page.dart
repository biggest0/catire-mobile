import 'package:catire_mobile/features/pages/about_page.dart';
import 'package:catire_mobile/features/pages/contact_page.dart';
import 'package:catire_mobile/features/pages/disclaimer_page.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  final Function(String, Widget)? onNavigate;

  const MenuPage({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      children: [
        ListTile(
          title: const Text(
            'About',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          onTap: () => onNavigate?.call("About", const AboutPage()),
        ),
        ListTile(
          title: const Text(
            'Disclaimer',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          onTap: () => onNavigate?.call("Disclaimer", const DisclaimerPage()),
        ),
        ListTile(
          title: const Text(
            'Contact',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          onTap: () => onNavigate?.call("Contact", const ContactPage()),
        ),
      ],
    );
  }
}
