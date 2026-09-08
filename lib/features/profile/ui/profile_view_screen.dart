import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/core/widgets/custom_dropdown_field.dart';
import 'package:Doctors_App/core/widgets/custom_text_field.dart';
import 'package:Doctors_App/core/widgets/section_card.dart';
import 'package:Doctors_App/features/profile/model/doctor_profile_data.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileViewScreen extends StatefulWidget {
  final DoctorProfileData initialData;

  const ProfileViewScreen({super.key, required this.initialData});

  @override
  State<ProfileViewScreen> createState() => _ProfileViewScreenState();
}

class _ProfileViewScreenState extends State<ProfileViewScreen> {
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _prefixCtrl;
  late final TextEditingController _firstNameCtrl;
  late final TextEditingController _middleNameCtrl;
  late final TextEditingController _lastNameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _mobileCtrl;
  late final TextEditingController _organisationCtrl;

  late final TextEditingController _categoryCtrl;
  late final TextEditingController _specialityCtrl;
  late final TextEditingController _degreeCtrl;

  final List<String> categories = [
    'Professional Individual',
    'General Practitioner All Pathy',
    'Physician Consultant',
    'Dental Surgeon',
  ];

  @override
  void initState() {
    super.initState();
    _prefixCtrl = TextEditingController(text: widget.initialData.prefix);
    _firstNameCtrl = TextEditingController(text: widget.initialData.firstName);
    _middleNameCtrl = TextEditingController(
      text: widget.initialData.middleName,
    );
    _lastNameCtrl = TextEditingController(text: widget.initialData.lastName);
    _emailCtrl = TextEditingController(text: widget.initialData.email);
    _mobileCtrl = TextEditingController(text: widget.initialData.mobile);
    _organisationCtrl = TextEditingController(
      text: widget.initialData.organisation,
    );

    _categoryCtrl = TextEditingController(text: widget.initialData.category);
    _specialityCtrl = TextEditingController(
      text: widget.initialData.speciality,
    );
    _degreeCtrl = TextEditingController(text: widget.initialData.degree);
  }

  @override
  void dispose() {
    _prefixCtrl.dispose();
    _firstNameCtrl.dispose();
    _middleNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _mobileCtrl.dispose();
    _organisationCtrl.dispose();
    _categoryCtrl.dispose();
    _specialityCtrl.dispose();
    _degreeCtrl.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isEditing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Profile & Account', showBack: false),
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopHeaderCard(),
              height(16),
              SectionCard(
                title: 'Personal Details',
                icon: Icons.person_outline,
                children: [
                  if (_isEditing) ...[
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: CustomDropdownField(
                            label: 'PREFIX',
                            controller: _prefixCtrl,
                            items: ['Dr.', 'Mr.', 'Ms.', 'Mrs.'],
                          ),
                        ),
                        width(10),
                        Expanded(
                          flex: 3,
                          child: CustomTextField(
                            label: 'FIRST NAME',
                            controller: _firstNameCtrl,
                            isRequired: true,
                          ),
                        ),
                      ],
                    ),
                    height(12),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            label: 'MIDDLE NAME',
                            controller: _middleNameCtrl,
                          ),
                        ),
                        width(10),
                        Expanded(
                          child: CustomTextField(
                            label: 'LAST NAME',
                            controller: _lastNameCtrl,
                            isRequired: true,
                          ),
                        ),
                      ],
                    ),
                    height(12),
                    CustomTextField(
                      label: 'EMAIL ADDRESS',
                      controller: _emailCtrl,
                      isRequired: true,
                    ),
                    height(12),
                    CustomTextField(
                      label: 'MOBILE NUMBER',
                      controller: _mobileCtrl,
                      isRequired: true,
                    ),
                    height(12),
                    CustomTextField(
                      label: 'ORGANISATION / ASSOCIATION',
                      controller: _organisationCtrl,
                    ),
                  ] else ...[
                    Wrap(
                      runSpacing: 16,
                      spacing: 16,
                      children: [
                        _buildReadUnit('PREFIX', _prefixCtrl.text),
                        _buildReadUnit('FIRST NAME', _firstNameCtrl.text),
                        _buildReadUnit('MIDDLE NAME', _middleNameCtrl.text),
                        _buildReadUnit('LAST NAME', _lastNameCtrl.text),
                        _buildReadUnit('EMAIL ADDRESS', _emailCtrl.text),
                        _buildReadUnit('MOBILE NUMBER', _mobileCtrl.text),
                        _buildReadUnit(
                          'ORGANISATION / ASSOCIATION',
                          _organisationCtrl.text,
                        ),
                      ],
                    ),
                  ],
                ],
              ),
              height(16),
              SectionCard(
                title: 'Professional & Practice Details',
                icon: Icons.medical_services_outlined,
                children: [
                  if (_isEditing) ...[
                    CustomDropdownField(
                      label: 'CATEGORY',
                      controller: _categoryCtrl,
                      items: categories,
                    ),
                    height(12),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            label: 'SPECIALITY',
                            controller: _specialityCtrl,
                          ),
                        ),
                        width(10),
                        Expanded(
                          child: CustomTextField(
                            label: 'DEGREE',
                            controller: _degreeCtrl,
                          ),
                        ),
                      ],
                    ),
                    height(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        OutlinedButton(
                          onPressed: _toggleEdit,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: const Text('Cancel'),
                        ),
                        width(12),
                        ElevatedButton(
                          onPressed: _saveChanges,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF16A34A),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Text(
                            'Save Changes',
                            style: customTextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    Wrap(
                      runSpacing: 16,
                      spacing: 16,
                      children: [
                        _buildReadUnit('CATEGORY', _categoryCtrl.text),
                        _buildReadUnit('SPECIALITY', _specialityCtrl.text),
                        _buildReadUnit('DEGREE', _degreeCtrl.text),
                      ],
                    ),
                  ],
                ],
              ),
              height(16),
              _buildCardTile(
                title: 'Membership & Plans',
                subtitle:
                    'You haven\'t secured a membership yet - plan details, your Membership ID and tier will appear here once you do.',
                buttonText: 'Browse Plans',
                icon: Icons.card_membership_outlined,
                onPressed: () {},
              ),
              height(16),
              _buildCardTile(
                title: 'Documents & Certificates',
                subtitle:
                    'Policy certificate, invoices and your agreement will appear here once you secure a membership.',
                buttonText: 'Open Document Vault',
                icon: Icons.folder_open_outlined,
                onPressed: () {},
              ),
              height(Responsive.h(100)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey.shade200,
            child: const Icon(Icons.person, size: 32, color: Colors.grey),
          ),
          width(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_prefixCtrl.text} ${_firstNameCtrl.text} ${_lastNameCtrl.text}'
                      .trim(),
                  style: customTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                height(2),
                Text(
                  '${_categoryCtrl.text} • ${_degreeCtrl.text}',
                  style: customTextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                height(4),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                    width(6),
                    Text(
                      'No Active Membership',
                      style: customTextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (!_isEditing)
            OutlinedButton(
              onPressed: _toggleEdit,
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                side: BorderSide(color: Colors.grey.shade300),
              ),
              child: const Text(
                'Edit Profile',
                style: TextStyle(color: Colors.black87),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Editing...',
                style: customTextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildReadUnit(String label, String value) {
    return SizedBox(
      width: Responsive.w(150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: customTextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade500,
            ),
          ),
          height(4),
          Text(
            value.isEmpty ? '-' : value,
            style: customTextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardTile({
    required String title,
    required String subtitle,
    required String buttonText,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: Colors.grey.shade700),
              width(8),
              Text(
                title,
                style: customTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          height(8),
          Text(
            subtitle,
            style: customTextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          height(12),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              buttonText,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
