import 'package:flutter/material.dart';


/// Account profile picture.
class ProfilePicture extends StatelessWidget {
  final String imagePath;

  const ProfilePicture({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 60,
      backgroundColor: Colors.grey[300],
      backgroundImage: AssetImage(imagePath),
    );
  }
}
