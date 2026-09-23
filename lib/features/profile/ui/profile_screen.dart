import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/profile/ui/widgets/personal_details_edit_section.dart';
import 'package:Doctors_App/features/profile/ui/widgets/professional_details_edit_section.dart';
import 'package:flutter/services.dart';
import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/app_refresh_indicator.dart';
import 'package:Doctors_App/core/widgets/common_error_state.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/core/widgets/section_card.dart';
import 'package:Doctors_App/features/common/ui/widgets/loading.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/home/model/policy_model.dart';
import 'package:Doctors_App/features/profile/model/doctor_profile_response.dart';
import 'package:Doctors_App/features/profile/model/profile_address_request.dart';
import 'package:Doctors_App/features/profile/ui/state/profile_state.dart';
import 'package:Doctors_App/features/profile/ui/view_model/profile_view_model.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../routing/routes.dart';
import '../../product/ui/widgets/address_form_sheet.dart';

const PolicyStatus kCurrentDashboardStatus = PolicyStatus.active;

String? validateMobile(
  String? value, {
  required String label,
  bool required = true,
}) {
  final v = (value ?? '').trim();
  if (v.isEmpty) {
    return required ? 'Please enter $label' : null;
  }
  if (!RegExp(r'^[0-9]{10}$').hasMatch(v)) {
    return '$label must be exactly 10 digits';
  }
  return null;
}

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

  final List<String> genders = ['Male', 'Female', 'Other'];

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

  String _normalizePrefix(String? raw) {
    final v = (raw ?? '').trim();
    if (v.isEmpty) return '';
    return v.endsWith('.') ? v : '$v.';
  }

  void _populateControllers(DoctorProfileData data) {
    _prefixCtrl.text = _normalizePrefix(data.prifix);
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

    _retroactiveCtrl.text = _yesNoValue(clinic?.retroactive);
    _worldwideCtrl.text = _yesNoValue(clinic?.worldwide);
    _unqualifiedStaffCtrl.text = _yesNoValue(clinic?.unqualifiedStaff);

    _unqualifiedStaffCountCtrl.text = clinic?.unqualifiedStaffCount ?? '';
  }

  String _yesNoValue(String? value) {
    if (value == '1') return 'Yes';
    if (value == '0') return 'No';
    if (value?.toLowerCase() == 'yes') return 'Yes';
    if (value?.toLowerCase() == 'no') return 'No';
    return '';
  }

  String? _apiYesNo(String value) {
    if (value.toLowerCase() == 'yes') return '1';
    if (value.toLowerCase() == 'no') return '0';
    return null;
  }

  String _formatDob(String? dob) {
    if (dob == null || dob.isEmpty) return '';
    final parsed = DateTime.tryParse(dob);
    if (parsed == null) return dob;
    return '${parsed.day.toString().padLeft(2, '0')}/'
        '${parsed.month.toString().padLeft(2, '0')}/'
        '${parsed.year}';
  }

  DateTime? _parseDisplayDob(String display) {
    final parts = display.split('/');
    if (parts.length != 3) return null;
    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);
    if (day == null || month == null || year == null) return null;
    return DateTime(year, month, day);
  }

  String? _dobToApiFormat(String display) {
    if (display.trim().isEmpty) return null;
    final parts = display.split('/');
    if (parts.length != 3) return display;
    final day = parts[0].padLeft(2, '0');
    final month = parts[1].padLeft(2, '0');
    final year = parts[2];
    return '$year-$month-$day';
  }

  Future<void> _pickDob() async {
    final now = DateTime.now();
    final initial =
        _parseDisplayDob(_dobCtrl.text) ??
        DateTime(now.year - 25, now.month, now.day);

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1930),
      lastDate: now,
    );

    if (picked != null) {
      setState(() {
        _dobCtrl.text =
            '${picked.day.toString().padLeft(2, '0')}/'
            '${picked.month.toString().padLeft(2, '0')}/'
            '${picked.year}';
      });
    }
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

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    final data = ref.read(profileViewModelProvider).valueOrNull?.profileData;

    final addressRequests = (data?.addresses ?? [])
        .map(
          (a) => ProfileAddressRequest(
            id: a.id.toString(),
            addressType: a.addressType,
            ownVisiting: a.ownVisiting,
            address1: a.address1,
            address2: a.address2,
            landmark: a.landmark,
            area: a.area,
            state: a.state,
            city: a.city,
            pincode: a.pincode,
          ),
        )
        .toList();

    final success = await ref
        .read(profileViewModelProvider.notifier)
        .updateProfile(
          prefix: _prefixCtrl.text.trim(),
          firstName: _firstNameCtrl.text.trim(),
          middleName: _middleNameCtrl.text.trim(),
          lastName: _lastNameCtrl.text.trim(),
          email: _emailCtrl.text.trim(),
          mobileNo: _mobileCtrl.text.trim(),
          alternateNo: _alternateMobileCtrl.text.trim(),
          establishmentName: _organisationCtrl.text.trim(),
          dob: _dobToApiFormat(_dobCtrl.text),
          gender: _genderCtrl.text.trim(),
          addresses: addressRequests,
          clinicHospitalId: data?.clinicHospitalDetails?.id?.toString(),
          medicleRegState: _medicalRegStateCtrl.text.trim(),
          medicleRegNo: _medicalRegNoCtrl.text.trim(),
          medicleRegYear: _medicalRegYearCtrl.text.trim(),
          retroactive: _apiYesNo(_retroactiveCtrl.text),
          retroactiveDate: _retroactiveDateCtrl.text.trim(),
          worldwide: _apiYesNo(_worldwideCtrl.text),
          unqualifiedStaff: _apiYesNo(_unqualifiedStaffCtrl.text),
          unqualifiedStaffCount: _unqualifiedStaffCountCtrl.text.trim(),
        );

    if (!mounted) return;

    if (success) {
      _controllersPopulated = false;
      setState(() => _isEditing = false);

      context.showSuccessSnackBar('Profile updated successfully');
    } else {
      context.showErrorSnackBar('Failed to update profile. Please try again.');
    }
  }

  void _addAddress() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          AddressFormSheet(onSave: (address) {}, existing: null),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileViewModelProvider);
    final isSaving = profileAsync.valueOrNull?.isSaving ?? false;

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
      backgroundColor: context.primaryBackgroundColor,
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
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTopHeaderCard(kCurrentDashboardStatus),
                    height(16),
                    SectionCard(
                      title: 'Personal Details',
                      icon: Icons.person_outline,
                      children: [
                        if (_isEditing)
                          PersonalDetailsEditSection(
                            prefixCtrl: _prefixCtrl,
                            firstNameCtrl: _firstNameCtrl,
                            middleNameCtrl: _middleNameCtrl,
                            lastNameCtrl: _lastNameCtrl,
                            emailCtrl: _emailCtrl,
                            mobileCtrl: _mobileCtrl,
                            alternateMobileCtrl: _alternateMobileCtrl,
                            dobCtrl: _dobCtrl,
                            genderCtrl: _genderCtrl,
                            organisationCtrl: _organisationCtrl,
                            genders: genders,
                            onPickDob: _pickDob,
                          )
                        else
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
                    ),
                    height(16),
                    SectionCard(
                      title: 'Professional & Practice Details',
                      icon: Icons.medical_services_outlined,
                      children: [
                        if (_isEditing)
                          ProfessionalDetailsEditSection(
                            isSaving: isSaving,
                            medicalRegStateCtrl: _medicalRegStateCtrl,
                            medicalRegNoCtrl: _medicalRegNoCtrl,
                            medicalRegYearCtrl: _medicalRegYearCtrl,
                            retroactiveDateCtrl: _retroactiveDateCtrl,
                            retroactiveCtrl: _retroactiveCtrl,
                            worldwideCtrl: _worldwideCtrl,
                            unqualifiedStaffCtrl: _unqualifiedStaffCtrl,
                            unqualifiedStaffCountCtrl:
                                _unqualifiedStaffCountCtrl,
                            onCancel: _toggleEdit,
                            onSave: _saveChanges,
                          )
                        else
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
                                'RETROACTIVE',
                                _retroactiveCtrl.text,
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
                          ...data.addresses.asMap().entries.map(
                            (entry) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _buildAddressCard(entry.value, entry.key),
                            ),
                          ),
                          height(4),
                          PrimaryButton(
                            height: 45,
                            borderRadius: 25,
                            borderColor: context.borderColor,
                            width: 150,
                            fontSize: 13,
                            backgroundColor: context.secondaryBackgroundColor,
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

  Widget _buildTopHeaderCard(PolicyStatus status) {
    final data = ref.watch(profileViewModelProvider).valueOrNull?.profileData;

    if (data == null) {
      return const SizedBox.shrink();
    }

    final fullName = data.fullName?.trim().isNotEmpty == true
        ? data.fullName!.trim()
        : [
            data.prifix,
            data.firstName,
            data.middleName,
            data.lastName,
          ].where((e) => e != null && e.trim().isNotEmpty).join(' ');

    final category = data.categoryName?.trim() ?? '';
    final degree = data.degree?.trim() ?? '';
    final doctorNo = data.doctorNo?.trim() ?? '';

    final professionalDetails = [
      if (category.isNotEmpty) category,
      if (degree.isNotEmpty) degree,
    ].join(' · ');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: context.isDarkMode
                ? Colors.black.withValues(alpha: 0.22)
                : Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
        color: context.secondaryBackgroundColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: context.secondaryWidgetColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                child: Text(
                  data.firstName?.trim().isNotEmpty == true
                      ? data.firstName!.trim()[0].toUpperCase()
                      : 'D',
                  style: customTextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
              width(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fullName.isEmpty ? 'Doctor' : fullName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: customTextStyle(
                        color: context.primaryTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    height(4),
                    if (professionalDetails.isNotEmpty)
                      Text(
                        professionalDetails,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: customTextStyle(
                          fontSize: 11.5,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    if (doctorNo.isNotEmpty) ...[
                      height(3),
                      Text(
                        'Membership ID $doctorNo',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: customTextStyle(
                          fontSize: 10.5,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              IconButton(
                onPressed: _toggleEdit,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  _isEditing ? Icons.close : Icons.edit_outlined,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          height(14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _statusTag(status),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.w(10),
                  vertical: Responsive.h(5),
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE6C878), Color(0xFFB8912F)],
                  ),
                  borderRadius: BorderRadius.circular(Responsive.w(20)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.workspace_premium_rounded,
                      size: Responsive.sp(13),
                      color: Colors.white,
                    ),
                    width(Responsive.w(4)),
                    Text(
                      'Gold II · Premium',
                      style: customTextStyle(
                        fontSize: Responsive.sp(11),
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          height(12),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.w(10),
              vertical: Responsive.h(5),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: status.heroBorder),
              borderRadius: BorderRadius.circular(Responsive.w(20)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Profile 92% complete',
                  style: customTextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusTag(PolicyStatus status) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.w(12),
        vertical: Responsive.h(5),
      ),
      decoration: BoxDecoration(
        color: status.lightBg,
        border: Border.all(color: status.lightBorder),
        borderRadius: BorderRadius.circular(Responsive.w(20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(status.icon, size: Responsive.sp(12), color: status.color),
          width(Responsive.w(4)),
          Text(
            status.label,
            style: customTextStyle(
              fontSize: Responsive.sp(11.5),
              fontWeight: FontWeight.w700,
              color: status.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReadUnit(String label, String value) {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: customTextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: context.secondaryTextColor,
            ),
          ),
          height(4),
          Text(
            value.isEmpty ? '-' : value,
            style: customTextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: context.primaryTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard(dynamic address, int index) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.secondaryBackgroundColor,
        borderRadius: BorderRadius.circular(10),

        border: Border.all(
          color: isDark ? AppColors.darkLine : AppColors.fieldBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${address.addressType ?? 'Address'} (${address.ownVisiting ?? 'N/A'})',
                style: customTextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: const Icon(Icons.edit, size: 18, color: Colors.blue),
                  ),
                  width(8),
                  InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.delete_outline,
                      size: 18,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
          height(6),
          Text(
            '${address.address1 ?? ''}, ${address.address2 ?? ''}'.trim(),
            style: customTextStyle(fontSize: 12),
          ),
          if (address.landmark != null && address.landmark!.isNotEmpty)
            Text(
              'Landmark: ${address.landmark}',
              style: customTextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          Text(
            '${address.city ?? ''}, ${address.state ?? ''} - ${address.pincode ?? ''}',
            style: customTextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
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
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: context.borderColor),
          ),
          child: Text(
            'Redeem your points at checkout — toward a membership renewal, a new plan purchase, or a paid event — from the Payment Gateway\'s "Redeem Reward Points" toggle.',
            style: customTextStyle(
              fontSize: 11,
              color: context.primaryTextColor,
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
        color: context.secondaryBackgroundColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: context.borderColor),
      ),
      child: Row(
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
              style: customTextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsCard(List<DoctorDocument>? documents) {
    return SectionCard(
      title: 'Documents & Certificates',
      icon: Icons.folder_open_outlined,
      children: [
        if (documents == null || documents.isEmpty)
          Text(
            'No documents uploaded.',
            style: customTextStyle(fontSize: 12, color: Colors.grey.shade600),
          )
        else
          Column(
            children: documents.map((doc) {
              final fileName = _fileNameFromUrl(doc.documents ?? '');
              final isPdf = fileName.toLowerCase().endsWith('.pdf');

              return InkWell(
                onTap: () => _openDocument(doc.documents),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: context.secondaryBackgroundColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          isPdf
                              ? Icons.picture_as_pdf_outlined
                              : Icons.image_outlined,
                          size: 20,
                          color: context.secondaryTextColor,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doc.docName ?? 'Document',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: customTextStyle(
                                color: context.primaryTextColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            height(3),
                            Text(
                              fileName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: customTextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      width(8),
                      Icon(
                        Icons.open_in_new,
                        size: 18,
                        color: Colors.grey.shade600,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        height(4),
        PrimaryButton(
          height: 45,
          borderRadius: 25,
          borderColor: context.borderColor,
          width: 220,
          fontSize: 13,
          backgroundColor: context.primaryBackgroundColor,
          textColor: AppColors.textColor,
          onPressed: () {
            context.push(Routes.documentVault);
          },
          icon: Icons.add,
          text: 'Open Document Vault',
        ),
      ],
    );
  }

  Future<void> _openDocument(String? documentUrl) async {
    if (documentUrl == null || documentUrl.trim().isEmpty) return;
    final uri = Uri.tryParse(documentUrl);
    if (uri == null) return;
    final success = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!success) {
      debugPrint('Could not open document: $documentUrl');
    }
  }
}
