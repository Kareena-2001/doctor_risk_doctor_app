import 'package:Doctors_App/features/home/ui/home_screen.dart';
import 'package:Doctors_App/features/product/ui/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';

import '../../../extensions/build_context_extension.dart';
import '../../../features/profile/ui/profile_screen.dart';
import '../../home/ui/custom_bottom_navbar.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = [
    HomeScreen(),
    ProfileScreen(),
    ProfileScreen(),
    ProfileScreen(),
  ];

  static const List<NavBarItemData> _navItems = [
    NavBarItemData(
      icon: MingCuteIcons.mgc_home_4_line,
      activeIcon: MingCuteIcons.mgc_home_4_fill,
      label: 'Home',
    ),
    NavBarItemData(
      icon: Icons.auto_stories_outlined,
      activeIcon: Icons.auto_stories,
      label: 'Your Story',
    ),
    NavBarItemData(
      icon: Icons.headset_mic_outlined,
      activeIcon: Icons.headset_mic,
      label: 'Support Hub',
    ),

    NavBarItemData(
      icon: MingCuteIcons.mgc_user_3_line,
      activeIcon: MingCuteIcons.mgc_user_3_fill,
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: context.secondaryWidgetColor,
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        items: _navItems,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}
