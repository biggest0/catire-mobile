import 'package:flutter/material.dart';

/// Contact page, social media and email.
class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Email
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Email",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      SizedBox(height: 4),
                      Text("catirecontact@gmail.com"),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Social media
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Socials",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      SizedBox(height: 4),
                      Text("Instagram: catiretime"),
                      Text("YouTube: @catiretime"),
                      Text("X: catiretime"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
