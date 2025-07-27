import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/themes.dart';
import '../../../views/home_page.dart';
import '../../../views/profile_page.dart';

final currentIndexProvider = StateProvider<int>((ref) => 0);

class CustomBottomNavigationBar extends ConsumerWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (value) {
        ref.read(currentIndexProvider.notifier).state = value;
        _navigateToRoute(context, value);
      },
      selectedItemColor: kPrimaryColor,
      unselectedItemColor: kSecondaryColor,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
          activeIcon: Icon(Icons.home_filled),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Favorite',
          activeIcon: Icon(Icons.favorite),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on_outlined),
          label: 'Location',
          activeIcon: Icon(Icons.location_on),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_outlined),
          label: 'Notification',
          activeIcon: Icon(Icons.notifications),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
          activeIcon: Icon(Icons.person),
        ),
      ],
    );
  }

  void _navigateToRoute(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SettingsScreen(),
          ),
        );
        break;
      // Add cases for other indices if needed
    }
  }
}
