import 'package:Doctors_App/features/community/ui/community_screen.dart';
import 'package:Doctors_App/features/home/ui/home_screen.dart';
import 'package:Doctors_App/features/profile/ui/profile_view_screen.dart';
import 'package:Doctors_App/features/your_story/ui/testimonial_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';

import '../../../core/widgets/custom_bottom_navbar.dart';
import '../../../extensions/build_context_extension.dart';
import '../../profile/model/doctor_profile_data.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = [
    const HomeScreen(),
    const TestimonialScreen(),
    const CommunityScreen(),
    ProfileViewScreen(
      initialData: DoctorProfileData(
        prefix: 'Dr.',
        firstName: 'Paresh',
        middleName: 'Jeth',
        lastName: 'Mathur',
        email: 'pareshmathur@gmail.com',
        mobile: '8900900090',
        organisation: 'Doctors Risk Medico Legal Services',
        category: 'Professional Individual',
        speciality: 'General Medicine',
        degree: 'B.A.M.S.',
        addresses: [],
        doctorCertificates: [],
        organisationCertificates: [],
      ),
    ),
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
      icon: Icons.people,
      activeIcon: Icons.people,
      label: 'Community',
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