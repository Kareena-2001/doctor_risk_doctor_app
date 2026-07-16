import 'package:Doctors_App/features/community/ui/community_screen.dart';
import 'package:Doctors_App/features/home/ui/home_screen.dart';
import 'package:Doctors_App/features/profile/ui/profile_view_screen.dart';
import 'package:Doctors_App/features/testimonial/ui/testimonial_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';

import '../../../extensions/build_context_extension.dart';
import '../../../core/widgets/custom_bottom_navbar.dart';
import '../../profile/model/address_view_model.dart';
import '../../profile/model/certificate_model.dart';
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
      data: DoctorProfileData(
        prefix: 'Dr.',
        firstName: 'Arun',
        lastName: 'Mishra',
        degree: 'MBBS',
        email: 'arun@gmail.com',
        mobile: '9326481596',
        organisation: 'ABC Hospital',
        speciality: 'Cardiologist',
        category: 'General Practitioner',
        gender: 'Male',
        religion: 'Hindu',
        addresses: [
          AddressViewData(
            address1: 'ABC Multispeciality Hospital',
            address2: '2nd Floor, OPD Block',
            landmark: 'Near City Mall',
            pinCode: '400001',
            city: 'Mumbai',
            state: 'Maharashtra',
          ),
          AddressViewData(
            address1: 'Sunrise Clinic',
            address2: 'Main Road',
            landmark: 'Opposite Bus Stand',
            pinCode: '400020',
            city: 'Mumbai',
            state: 'Maharashtra',
          ),
        ],
        doctorCertificates: [
          CertificateModel(
            id: '1',
            name: 'MBBS Certificate.pdf',
            url: 'https://example.com/mbbs.pdf',
          ),
          CertificateModel(
            id: '2',
            name: 'Medical Registration.pdf',
            url: 'https://example.com/registration.pdf',
          ),
        ],
        organisationCertificates: [
          CertificateModel(
            id: '3',
            name: 'Hospital Registration.pdf',
            url: 'https://example.com/hospital.pdf',
          ),
        ],
      ),
      // policies: [
      //   PolicyModel(
      //     planName: 'Professional Indemnity Insurance',
      //     insurerName: 'ICICI Lombard',
      //     policyNumber: 'PI-2026-001245',
      //     purchaseDate: DateTime(2026, 1, 10),
      //     retroactiveDate: DateTime(2025, 1, 10),
      //     expiryDate: DateTime(2027, 1, 9),
      //     premiumAmount: 8500.00,
      //     status: 'Active',
      //   ),
      // ],
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
