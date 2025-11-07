import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'navbar_item.dart';

class AppBottomNavigationBar extends ConsumerWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onNavTap,
  });

  final int currentIndex;
  final void Function(int) onNavTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final user = ref.watch(userProvider);
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 14,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BottomAppBarItem(
            name: 'Menu',
            isActive: currentIndex == 0,
            onTap: () => onNavTap(0),
            icon: Icons.restaurant_menu,
          ),

          BottomAppBarItem(
            name: 'Réserver',
            isActive: currentIndex == 1,
            onTap: () => onNavTap(1),
            icon: Icons.book_online,
          ),
          BottomAppBarItem(
            name: 'Carte',
            isActive: currentIndex == 2,
            onTap: () => onNavTap(2),
            icon: Icons.map,
          ),
          BottomAppBarItem(
            name: 'Profile',
            isActive: currentIndex == 3,
            onTap: () => onNavTap(3),
            icon: Icons.person,
          ),
        ],
      ),
    );
  }
}
