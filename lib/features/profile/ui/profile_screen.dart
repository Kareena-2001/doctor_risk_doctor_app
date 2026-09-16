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

import '../../product/model/purchase_model.dart';
import '../../product/ui/widgets/address_form_sheet.dart';
import '../model/address_view_model.dart';

class ProfileScreen extends StatefulWidget {
  final DoctorProfileData initialData;

  const ProfileScreen({super.key, required this.initialData});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _prefixCtrl;
  late final TextEditingController _firstNameCtrl;
  late final TextEditingController _middleNameCtrl;
  late final TextEditingController _lastNameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _mobileCtrl;

  late final TextEditingController _alternateMobileCtrl;
  late final TextEditingController _dobCtrl;
  late final TextEditingController _genderCtrl;
  late final TextEditingController _organisationCtrl;

  late final TextEditingController _categoryCtrl;
  late final TextEditingController _specialityCtrl;
  late final TextEditingController _degreeCtrl;

  late final TextEditingController _medicalRegStateCtrl;
  late final TextEditingController _medicalRegNoCtrl;
  late final TextEditingController _medicalRegYearCtrl;
  late final TextEditingController _retroactiveDateCtrl;
  late final TextEditingController _retroactiveCtrl;
  late final TextEditingController _worldwideCtrl;
  late final TextEditingController _unqualifiedStaffCtrl;
  late final TextEditingController _unqualifiedStaffCountCtrl;

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

    _alternateMobileCtrl = TextEditingController(
      text: widget.initialData.alternateMobile,
    );
    _dobCtrl = TextEditingController(
      text: widget.initialData.dob != null
          ? _formatDate(widget.initialData.dob!)
          : '',
    );

    _genderCtrl = TextEditingController(text: widget.initialData.gender);

    _organisationCtrl = TextEditingController(
      text: widget.initialData.organisation,
    );

    _categoryCtrl = TextEditingController(text: widget.initialData.category);
    _specialityCtrl = TextEditingController(
      text: widget.initialData.speciality,
    );

    _degreeCtrl = TextEditingController(text: widget.initialData.degree);

    final clinic = widget.initialData.clinicHospitalDetails;

    _medicalRegStateCtrl = TextEditingController(
      text: clinic?.medicalRegState ?? '',
    );

    _medicalRegNoCtrl = TextEditingController(text: clinic?.medicalRegNo ?? '');

    _medicalRegYearCtrl = TextEditingController(
      text: clinic?.medicalRegYear ?? '',
    );

    _retroactiveDateCtrl = TextEditingController(
      text: clinic?.retroactiveDate ?? '',
    );

    _retroactiveCtrl = TextEditingController(text: clinic?.retroactive ?? '');

    _worldwideCtrl = TextEditingController(text: clinic?.worldwide ?? '');

    _unqualifiedStaffCtrl = TextEditingController(
      text: clinic?.unqualifiedStaff ?? '',
    );

    _unqualifiedStaffCountCtrl = TextEditingController(
      text: clinic?.unqualifiedStaffCount ?? '',
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  @override
  void dispose() {
    _prefixCtrl.dispose();
    _firstNameCtrl.dispose();
    _middleNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _mobileCtrl.dispose();
    _alternateMobileCtrl.dispose();
    _dobCtrl.dispose();
    _genderCtrl.dispose();
    _organisationCtrl.dispose();
    _categoryCtrl.dispose();
    _specialityCtrl.dispose();
    _degreeCtrl.dispose();

    _medicalRegStateCtrl.dispose();
    _medicalRegNoCtrl.dispose();
    _medicalRegYearCtrl.dispose();
    _retroactiveDateCtrl.dispose();
    _retroactiveCtrl.dispose();
    _worldwideCtrl.dispose();
    _unqualifiedStaffCtrl.dispose();
    _unqualifiedStaffCountCtrl.dispose();

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
                          'Alternate Number',
                          _alternateMobileCtrl.text,
                        ),
                        _buildReadUnit('Date of Birth', _dobCtrl.text),
                        _buildReadUnit('Gender', _genderCtrl.text),

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

                    height(12),

                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            label: 'MEDICAL REG. STATE',
                            controller: _medicalRegStateCtrl,
                          ),
                        ),
                        width(10),
                        Expanded(
                          child: CustomTextField(
                            label: 'MEDICAL REG. NO.',
                            controller: _medicalRegNoCtrl,
                          ),
                        ),
                      ],
                    ),

                    height(12),

                    CustomTextField(
                      label: 'MEDICAL REG. YEAR',
                      controller: _medicalRegYearCtrl,
                    ),

                    height(12),

                    CustomTextField(
                      label: 'RETROACTIVE DATE',
                      controller: _retroactiveDateCtrl,
                    ),

                    height(12),

                    Row(
                      children: [
                        Expanded(
                          child: CustomDropdownField(
                            label: 'RETROACTIVE',
                            controller: _retroactiveCtrl,
                            items: const ['Yes', 'No'],
                          ),
                        ),
                        width(10),
                        Expanded(
                          child: CustomDropdownField(
                            label: 'WORLDWIDE COVER',
                            controller: _worldwideCtrl,
                            items: const ['Yes', 'No'],
                          ),
                        ),
                      ],
                    ),

                    height(12),

                    CustomDropdownField(
                      label: 'UNQUALIFIED STAFF',
                      controller: _unqualifiedStaffCtrl,
                      items: const ['Yes', 'No'],
                    ),

                    if (_unqualifiedStaffCtrl.text.toLowerCase() == 'yes') ...[
                      height(12),
                      CustomTextField(
                        label: 'UNQUALIFIED STAFF COUNT',
                        controller: _unqualifiedStaffCountCtrl,
                      ),
                    ],

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
                        _buildReadUnit(
                          'MEDICAL REG. STATE',
                          _medicalRegStateCtrl.text,
                        ),
                        _buildReadUnit(
                          'MEDICAL REG. NO.',
                          _medicalRegNoCtrl.text,
                        ),
                        _buildReadUnit(
                          'MEDICAL REG. YEAR',
                          _medicalRegYearCtrl.text,
                        ),
                        _buildReadUnit(
                          'RETROACTIVE DATE',
                          _retroactiveDateCtrl.text,
                        ),
                        _buildReadUnit('WORLDWIDE COVER', _worldwideCtrl.text),
                        _buildReadUnit(
                          'UNQUALIFIED STAFF',
                          _unqualifiedStaffCtrl.text,
                        ),
                        if (_unqualifiedStaffCtrl.text.toLowerCase() == 'yes')
                          _buildReadUnit(
                            'UNQUALIFIED STAFF COUNT',
                            _unqualifiedStaffCountCtrl.text,
                          ),
                      ],
                    ),
                  ],
                ],
              ),
              height(16),
              SectionCard(
                title: 'Practice Addresses',
                icon: Icons.location_on_sharp,
                children: [
                  if (widget.initialData.addresses.isEmpty) ...[
                    const SizedBox(height: 4),

                    Text(
                      'No practice addresses added.',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 14),

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _addAddress,
                        icon: const Icon(Icons.add_location_alt_outlined),
                        label: const Text('Add Address'),
                      ),
                    ),
                  ] else ...[
                    ...widget.initialData.addresses.map(
                      (address) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildAddressCard(address),
                      ),
                    ),
                    height(4),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _addAddress,
                        icon: Icon(Icons.add_location_alt_outlined),
                        label: Text(
                          'Add Address',
                          style: customTextStyle(color: AppColors.newPri),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              height(16),

              _buildMembershipCard(),

              height(16),

              _buildRewardsCard(),

              height(16),
              _buildDocumentsCard(),

              height(Responsive.h(100)),
              // _buildCardTile(
              //   title: 'Membership & Plans',
              //   subtitle:
              //       'You haven\'t secured a membership yet - plan details, your Membership ID and tier will appear here once you do.',
              //   buttonText: 'Browse Plans',
              //   icon: Icons.card_membership_outlined,
              //   onPressed: () {},
              // ),
              // height(16),
              // _buildCardTile(
              //   title: 'Documents & Certificates',
              //   subtitle:
              //       'Policy certificate, invoices and your agreement will appear here once you secure a membership.',
              //   buttonText: 'Open Document Vault',
              //   icon: Icons.folder_open_outlined,
              //   onPressed: () {},
              // ),
              height(Responsive.h(100)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMembershipCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.card_membership_outlined,
                  color: AppColors.primary,
                  size: 21,
                ),
              ),
              width(10),
              Expanded(
                child: Text(
                  'Membership & Plans',
                  style: customTextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          height(18),

          // Membership ID
          _buildInfoRow('MEMBERSHIP ID', 'DR-2026-084213'),

          height(14),

          // Active Plans
          _buildInfoRow('ACTIVE PLANS', '2 (1 Professional, 1 Establishment)'),

          height(14),

          // Current Tier
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildInfoRow('CURRENT TIER', 'Gold II · Premium'),
              ),
              width(12),
              Expanded(child: _buildInfoRow('MEMBER SINCE', '01 Sep 2025')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRewardsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          height(18),

          // Rewards
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E7),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFF5D98A)),
            ),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE8A8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.stars_rounded,
                    size: 20,
                    color: Color(0xFFD99A00),
                  ),
                ),
                width(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rewards & Points',
                        style: customTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      height(2),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '320',
                              style: customTextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFFD99A00),
                              ),
                            ),
                            TextSpan(
                              text: ' points available',
                              style: customTextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          height(8),

          Text(
            'Redeem your points at checkout toward a membership renewal, '
            'new plan purchase, or paid event.',
            style: customTextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
            ).copyWith(height: 1.4),
          ),

          height(16),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                side: BorderSide(color: AppColors.primary),
              ),
              child: Text(
                'View My Plans',
                style: customTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.folder_open_outlined,
                  color: AppColors.primary,
                  size: 21,
                ),
              ),
              width(10),
              Expanded(
                child: Text(
                  'Documents & Certificates',
                  style: customTextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          height(18),

          _buildDocumentItem(
            icon: Icons.verified_outlined,
            title: 'Medical Reg. Certificate',
            fileName: 'medicalregisterationcert.jpg',
            onTap: () {},
          ),

          height(10),

          _buildDocumentItem(
            icon: Icons.local_hospital_outlined,
            title: 'Clinic Registration Certificate',
            fileName: 'clinicregisterationcert.pdf',
            onTap: () {},
          ),

          height(10),

          _buildDocumentItem(
            icon: Icons.description_outlined,
            title: 'Previous Policy',
            fileName: 'NIAPareshMathur.pdf',
            onTap: () {},
          ),

          height(16),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.folder_open_outlined, size: 18),
              label: const Text('Open Document Vault'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                side: BorderSide(color: AppColors.primary),
                foregroundColor: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: customTextStyle(
            fontSize: 9.5,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade500,
          ),
        ),
        height(4),
        Text(
          value,
          style: customTextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1E293B),
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentItem({
    required IconData icon,
    required String title,
    required String fileName,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 18, color: AppColors.primary),
            ),
            width(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: customTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  height(3),
                  Text(
                    fileName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: customTextStyle(
                      fontSize: 10.5,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            width(8),
            Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: Colors.grey.shade500,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addAddress() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return AddressFormSheet(
          existing: null,
          onSave: (WizardAddress address) {
            Navigator.of(context).pop(address);
          },
        );
      },
    );
  }

  Widget _buildAddressCard(AddressViewData address) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  address.addressType.isEmpty ? 'Address' : address.addressType,
                  style: customTextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.orange,
                  ),
                ),
              ),
              const Spacer(),
              if (address.ownVisiting.isNotEmpty)
                Text(
                  address.ownVisiting,
                  style: customTextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
                ),
            ],
          ),

          height(12),

          _buildAddressValue('ADDRESS 1', address.address1),

          if (address.address2.isNotEmpty) ...[
            height(8),
            _buildAddressValue('ADDRESS 2', address.address2),
          ],

          if (address.area.isNotEmpty) ...[
            height(8),
            _buildAddressValue('AREA', address.area),
          ],

          if (address.landmark.isNotEmpty) ...[
            height(8),
            _buildAddressValue('LANDMARK', address.landmark),
          ],

          height(8),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildAddressValue('CITY', address.city)),
              width(12),
              Expanded(child: _buildAddressValue('STATE', address.state)),
            ],
          ),

          height(8),

          _buildAddressValue('PIN CODE', address.pincode),
        ],
      ),
    );
  }

  Widget _buildAddressValue(String label, String? value) {
    final displayValue = value?.trim() ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: customTextStyle(
            fontSize: 9.5,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade500,
          ),
        ),
        height(3),
        Text(
          displayValue.isEmpty ? '-' : displayValue,
          style: customTextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1E293B),
          ),
        ),
      ],
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
