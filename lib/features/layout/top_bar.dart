import 'package:flutter/material.dart';

/// Main app bar of the app.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(int) onTap;

  const CustomAppBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: const Text("CATIRE TIME"),
      centerTitle: true,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => onTap(5), // 5 is index of the search page
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
