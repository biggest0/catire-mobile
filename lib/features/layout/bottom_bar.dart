import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget
    implements PreferredSizeWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const navItems = [
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        activeIcon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.chrome_reader_mode_outlined),
        activeIcon: Icon(Icons.chrome_reader_mode),
        label: 'News',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.image_outlined),
        activeIcon: Icon(Icons.image),
        label: 'Cats',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person_outline),
        activeIcon: Icon(Icons.person),
        label: 'Account',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.menu),
        activeIcon: Icon(Icons.menu),
        label: 'More',
      ),
    ];

    final int index = currentIndex >= 0 && currentIndex < navItems.length
        ? currentIndex
        : 4; // All other pages default to the last item.

    return BottomNavigationBar(
      currentIndex: index,
      onTap: (index) => onTap(index),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.grey[800],
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      items: navItems,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
