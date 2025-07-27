import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/themes.dart';
import '../controllers/itembag_controller.dart';
import '../core/common/widget/Bottom_navigation.dart';

final currentIndexProvider = StateProvider<int>((ref) {
  return 0;
});

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);
    final itemBag = ref.watch(itemBagProvider);
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Profile',
          style: AppTheme.kBigTitle.copyWith(color: kWhiteColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.local_mall_outlined),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('Avatar'),
                  trailing: Stack(
                    alignment: Alignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            'Your image URL here'), // Replace with your avatar image URL
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                const ListTile(
                  title: Text('Email'),
                  subtitle: Text('anuj@gmail.com'),
                  trailing: Icon(Icons.edit),
                ),
                const Divider(),
                const ListTile(
                  title: Text('Change Password'),
                  trailing: Icon(Icons.edit),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
