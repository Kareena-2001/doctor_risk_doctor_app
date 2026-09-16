import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/app_refresh_indicator.dart';
import 'package:Doctors_App/core/widgets/common_error_state.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/core/widgets/custom_dropdown_field.dart';
import 'package:Doctors_App/core/widgets/custom_text_field.dart';
import 'package:Doctors_App/core/widgets/section_card.dart';
import 'package:Doctors_App/features/common/ui/widgets/loading.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/profile/model/doctor_profile_response.dart';
import 'package:Doctors_App/features/profile/ui/state/profile_state.dart';
import 'package:Doctors_App/features/profile/ui/view_model/profile_view_model.dart';
import 'package:Doctors_App/routing/routes.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../product/model/purchase_model.dart';
import '../../product/ui/widgets/address_form_sheet.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _isEditing = false;
  bool _controllersPopulated = false;
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

    _prefixCtrl = TextEditingController();
    _firstNameCtrl = TextEditingController();
    _middleNameCtrl = TextEditingController();
    _lastNameCtrl = TextEditingController();
    _emailCtrl = TextEditingController();
    _mobileCtrl = TextEditingController();
    _alternateMobileCtrl = TextEditingController();
    _dobCtrl = TextEditingController();
    _genderCtrl = TextEditingController();
    _organisationCtrl = TextEditingController();
    _categoryCtrl = TextEditingController();
    _specialityCtrl = TextEditingController();
    _degreeCtrl = TextEditingController();
    _medicalRegStateCtrl = TextEditingController();
    _medicalRegNoCtrl = TextEditingController();
    _medicalRegYearCtrl = TextEditingController();
    _retroactiveDateCtrl = TextEditingController();
    _retroactiveCtrl = TextEditingController();
    _worldwideCtrl = TextEditingController();
    _unqualifiedStaffCtrl = TextEditingController();
    _unqualifiedStaffCountCtrl = TextEditingController();

    Future.microtask(
      () => ref.read(profileViewModelProvider.notifier).getProfile(),
    );
  }

  void _populateControllers(DoctorProfileData data) {
    _prefixCtrl.text = data.prifix ?? '';
    _firstNameCtrl.text = data.firstName ?? '';
    _middleNameCtrl.text = data.middleName ?? '';
    _lastNameCtrl.text = data.lastName ?? '';
    _emailCtrl.text = data.email ?? '';
    _mobileCtrl.text = data.mobileNo ?? '';
    _alternateMobileCtrl.text = data.alternateNo ?? '';
    _dobCtrl.text = _formatDob(data.dob);
    _genderCtrl.text = data.gender ?? '';
    _organisationCtrl.text = data.organizationName ?? '';

    _categoryCtrl.text = data.categoryName ?? '';
    _specialityCtrl.text = data.specialityName ?? '';
    _degreeCtrl.text = data.degree ?? '';

    final clinic = data.clinicHospitalDetails;
    _medicalRegStateCtrl.text = clinic?.medicleRegState ?? '';
    _medicalRegNoCtrl.text = clinic?.medicleRegNo ?? '';
    _medicalRegYearCtrl.text = clinic?.medicleRegYear ?? '';
    _retroactiveDateCtrl.text = clinic?.retroactiveDate ?? '';
    _retroactiveCtrl.text = clinic?.retroactive ?? '';
    _worldwideCtrl.text = clinic?.worldwide ?? '';
    _unqualifiedStaffCtrl.text = clinic?.unqualifiedStaff ?? '';
    _unqualifiedStaffCountCtrl.text = clinic?.unqualifiedStaffCount ?? '';
  }

  String _formatDob(String? dob) {
    if (dob == null || dob.isEmpty) return '';
    final parsed = DateTime.tryParse(dob);
    if (parsed == null) return dob;
    return '${parsed.day.toString().padLeft(2, '0')}/'
        '${parsed.month.toString().padLeft(2, '0')}/'
        '${parsed.year}';
  }

  String _fileNameFromUrl(String? url) {
    if (url == null || url.isEmpty) return '-';
    final uri = Uri.tryParse(url);
    if (uri == null || uri.pathSegments.isEmpty) return url;
    return Uri.decodeFull(uri.pathSegments.last);
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
    final profileAsync = ref.watch(profileViewModelProvider);

    ref.listen<AsyncValue<ProfileState>>(profileViewModelProvider, (
      previous,
      next,
    ) {
      next.whenData((state) {
        if (!_controllersPopulated && state.profileData != null) {
          _populateControllers(state.profileData!);
          _controllersPopulated = true;
          setState(() {});
        }
      });
    });

    return Scaffold(
      appBar: CustomAppBar(title: 'Profile & Account', showBack: false),
      backgroundColor: const Color(0xFFF8FAFC),
      body: profileAsync.when(
        loading: () => const Center(child: Loading()),
        error: (error, _) => _buildErrorState(error),
        data: (state) {
          final data = state.profileData;
          if (data == null) {
            return const Center(child: Loading());
          }

          return AppRefreshIndicator(
            onRefresh: () =>
                ref.read(profileViewModelProvider.notifier).refreshProfile(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
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
                              _buildReadUnit(
                                'MIDDLE NAME',
                                _middleNameCtrl.text,
                              ),
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
                                  items: ['Yes', 'No'],
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
                          if (_unqualifiedStaffCtrl.text.toLowerCase() ==
                              'yes') ...[
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
                              _buildReadUnit(
                                'SPECIALITY',
                                _specialityCtrl.text,
                              ),
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
                              _buildReadUnit(
                                'WORLDWIDE COVER',
                                _worldwideCtrl.text,
                              ),
                              _buildReadUnit(
                                'UNQUALIFIED STAFF',
                                _unqualifiedStaffCtrl.text,
                              ),
                              if (_unqualifiedStaffCtrl.text.toLowerCase() ==
                                  'yes')
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
                        if (data.addresses.isEmpty) ...[
                          height(4),
                          Text(
                            'No practice addresses added.',
                            style: customTextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),
                          height(14),
                          PrimaryButton(
                            height: 45,
                            borderRadius: 25,
                            borderColor: AppColors.borderGrey,
                            width: 150,
                            fontSize: 13,
                            backgroundColor: AppColors.white,
                            textColor: AppColors.textColor,
                            onPressed: _addAddress,
                            icon: Icons.add,
                            text: 'Add Address',
                          ),
                        ] else ...[
                          ...data.addresses.map(
                            (address) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _buildAddressCard(address),
                            ),
                          ),
                          height(4),
                          PrimaryButton(
                            height: 45,
                            borderRadius: 25,
                            borderColor: AppColors.borderGrey,
                            width: 150,
                            fontSize: 13,
                            backgroundColor: AppColors.white,
                            textColor: AppColors.textColor,
                            onPressed: _addAddress,
                            icon: Icons.add,
                            text: 'Add Address',
                          ),
                        ],
                      ],
                    ),
                    height(16),
                    _buildMembershipCard(),
                    height(16),
                    _buildRewardsSection(),
                    height(16),
                    _buildDocumentsCard(data.documents),
                    height(Responsive.h(100)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorState(Object error) {
    return Center(
      child: CommonErrorState(
        icon: Icons.error_outline,
        title: 'Failed to load profile.\n$error',
        onRetry: () {
          ref.read(profileViewModelProvider.notifier).getProfile();
        },
        message: '',
      ),
    );
  }

  Widget _buildRewardsSection() {
    return SectionCard(
      title: 'Rewards & Points',
      icon: Icons.stars_rounded,
      children: [
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
        height(10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Text(
            'Redeem your points at checkout — toward a membership renewal, a new plan purchase, or a paid event — from the Payment Gateway"s "Redeem Reward Points" toggle.',
            style: customTextStyle(
              fontSize: 11,
              color: AppColors.textColor,
            ).copyWith(height: 1.4),
          ),
        ),
      ],
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
          _buildInfoRow('MEMBERSHIP ID', 'DR-2026-084213'),
          height(14),
          _buildInfoRow('ACTIVE PLANS', '2 (1 Professional, 1 Establishment)'),
          height(14),
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
          height(14),
          PrimaryButton(
            height: 45,
            borderRadius: 25,
            borderColor: AppColors.borderGrey,
            width: 150,
            fontSize: 13,
            backgroundColor: AppColors.white,
            textColor: AppColors.textColor,
            onPressed: () {
              context.push(Routes.myPlans);
            },
            text: 'View My Plans',
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsCard(List<DoctorDocument> documents) {
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
          if (documents.isEmpty)
            Text(
              'No documents uploaded.',
              style: customTextStyle(color: Colors.grey.shade600, fontSize: 13),
            )
          else
            ...documents.map(
              (doc) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _buildDocumentItem(
                  icon: Icons.description_outlined,
                  title: doc.docName ?? 'Document',
                  fileName: _fileNameFromUrl(doc.documents),
                  onTap: () {},
                ),
              ),
            ),
          height(6),
          PrimaryButton(
            height: 45,
            borderRadius: 25,
            borderColor: AppColors.borderGrey,
            width: 200,
            fontSize: 13,
            backgroundColor: AppColors.white,
            textColor: AppColors.textColor,
            onPressed: () {
              context.push(Routes.documentVault);
            },
            text: 'Open Document Vault',
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

  Widget _buildAddressCard(DoctorAddress address) {
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
                  (address.addressType ?? '').isEmpty
                      ? 'Address'
                      : address.addressType!,
                  style: customTextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.orange,
                  ),
                ),
              ),
              const Spacer(),
              if ((address.ownVisiting ?? '').isNotEmpty)
                Text(
                  address.ownVisiting!,
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

          if ((address.address2 ?? '').isNotEmpty) ...[
            height(8),
            _buildAddressValue('ADDRESS 2', address.address2),
          ],

          if ((address.area ?? '').isNotEmpty) ...[
            height(8),
            _buildAddressValue('AREA', address.area),
          ],

          if ((address.landmark ?? '').isNotEmpty) ...[
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
            backgroundImage: const AssetImage('assets/images/user.png'),
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
                      decoration: BoxDecoration(
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
              child: Text(
                'Edit Profile',
                style: customTextStyle(color: Colors.black87),
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
              color: Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }
}
