import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const BottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTabSelected,
      backgroundColor: Theme.of(context).primaryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Explore'),
        BottomNavigationBarItem(icon: Icon(Icons.hide_source), label: 'Hidden'),
        BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'AI'),
        BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Map'),
      ],
    );
  }
}
