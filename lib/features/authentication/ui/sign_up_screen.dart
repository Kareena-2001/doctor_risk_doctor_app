import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/authentication/ui/widgets/recapta_widget.dart';
import 'package:Doctors_App/features/fcm/device_service.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/dimensions.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../core/widgets/custom_dropdown_field.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../common/ui/widgets/primary_button.dart';
import '../../home/ui/widgets/social_link_widget.dart';
import 'view_model/authentication_view_model.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final DeviceService deviceService = DeviceService();

  late final TextEditingController _firstNameController;
  late final TextEditingController _middleNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _mobileNoController;
  late final TextEditingController _emailController;
  late final TextEditingController _organizationCodeController;
  late final TextEditingController _associateCodeController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  final _formKey = GlobalKey<FormState>();
  String? _recaptchaToken;

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _agreeTerms = false;

  String? _selectedPrefix;
  String? _selectedCategory;
  String? _selectedSpeciality;
  String? _selectedDegree;

  final prefixes = ['Dr.', 'Mr.', 'Mrs.', 'Ms.'];

  final categories = [
    'General Practitioner All Pathy',
    'Physician Consultant (Non Surgical)',
    'Surgeon All Speciality (All Pathy)',
    'Dental Surgeon (MDS And BDS)',
    'Plastic / Cosmetic / Anesthetic Surgeon / Oral and Maxillofacial (All Pathy)',
    'Physiotherapist All Pathy',
  ];

  final specialities = [
    'General Medicine',
    'Orthopaedics',
    'Gynaecology & Obstetrics',
    'Cardiology',
    'Dermatology',
    'ENT',
    'Ayurvedic',
    'Other',
  ];

  final degrees = ['MBBS', 'MD', 'MS', 'MDS', 'BDS', 'DM', 'BAMS', 'BHMS'];

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _middleNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _mobileNoController = TextEditingController();
    _emailController = TextEditingController();
    _organizationCodeController = TextEditingController();
    _associateCodeController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    // Attach listeners to update Live Preview in real-time
    _firstNameController.addListener(_onFieldChanged);
    _middleNameController.addListener(_onFieldChanged);
    _lastNameController.addListener(_onFieldChanged);
    _mobileNoController.addListener(_onFieldChanged);
    _emailController.addListener(_onFieldChanged);
    _passwordController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _mobileNoController.dispose();
    _emailController.dispose();
    _organizationCodeController.dispose();
    _associateCodeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSignUpPressed() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (_passwordController.text != _confirmPasswordController.text) {
      context.showWarningSnackBar('Passwords do not match');
      return;
    }

    if (!_agreeTerms) {
      context.showWarningSnackBar('Please agree to the Terms & Conditions');
      return;
    }

    if (_recaptchaToken == null) {
      context.showWarningSnackBar('Please complete the captcha');
      return;
    }
  }

  String _getPasswordStrength() {
    final pass = _passwordController.text;
    if (pass.isEmpty) return '';
    if (pass.length < 6) return 'Weak — add numbers & symbols';
    if (pass.length >= 8 &&
        RegExp(r'[0-9]').hasMatch(pass) &&
        RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(pass)) {
      return 'Strong password';
    }
    return 'Medium — add special characters';
  }

  Color _getPasswordStrengthColor() {
    final str = _getPasswordStrength();
    if (str.startsWith('Weak')) return Colors.red;
    if (str.startsWith('Medium')) return Colors.orange;
    if (str.startsWith('Strong')) return Colors.green;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authenticationViewModelProvider);

    final fullName = [
      _selectedPrefix ?? '',
      _firstNameController.text,
      _middleNameController.text,
      _lastNameController.text,
    ].where((e) => e.trim().isNotEmpty).join(' ');

    final isDoctor = _selectedPrefix == 'Dr.';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Membership Registration'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.all(Responsive.sp(16)),
                padding: EdgeInsets.all(Responsive.sp(16)),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFF16A34A),
                                shape: BoxShape.circle,
                              ),
                            ),
                            width(6),
                            Text(
                              'LIVE PREVIEW',
                              style: customTextStyle(
                                fontSize: Responsive.sp(10),
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF16A34A),
                              ).copyWith(letterSpacing: 0.8),
                            ),
                          ],
                        ),
                        Text(
                          'Takes ~ 3 mins',
                          style: customTextStyle(
                            fontSize: Responsive.sp(10),
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 20, color: Color(0xFFE2E8F0)),
                    Text(
                      fullName.isEmpty ? 'Your Full Name' : fullName,
                      style: customTextStyle(
                        fontSize: Responsive.sp(17),
                        fontWeight: FontWeight.bold,
                        color: fullName.isEmpty
                            ? const Color(0xFF94A3B8)
                            : AppColors.brandGreen,
                      ),
                    ),

                    // Show Category & Speciality in Live Preview ONLY if Dr. is selected
                    if (isDoctor) ...[
                      height(Responsive.h(4)),
                      Text(
                        '${_selectedCategory ?? 'Category'} · ${_selectedSpeciality ?? 'Speciality'}',
                        style: TextStyle(
                          fontSize: Responsive.sp(12),
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF475569),
                        ),
                      ),
                    ],
                    height(Responsive.h(12)),
                    Row(
                      children: [
                        Expanded(
                          child: _PreviewDetailTile(
                            label: 'Mobile',
                            value: _mobileNoController.text.isEmpty
                                ? '—'
                                : _mobileNoController.text,
                          ),
                        ),
                        Expanded(
                          child: _PreviewDetailTile(
                            label: 'Email',
                            value: _emailController.text.isEmpty
                                ? '—'
                                : _emailController.text,
                          ),
                        ),
                        if (isDoctor)
                          Expanded(
                            child: _PreviewDetailTile(
                              label: 'Degree',
                              value: _selectedDegree ?? '—',
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Responsive.sp(20)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   'All fields marked * are required.',
                      //   style: TextStyle(
                      //     fontSize: Responsive.sp(12),
                      //     color: const Color(0xFF64748B),
                      //   ),
                      // ),
                      // height(Responsive.h(16)),
                      const _SectionHeader(title: 'Personal details'),
                      height(Responsive.h(12)),
                      CustomDropdownField(
                        label: 'Prefix *',
                        hint: 'Select Prefix',
                        items: prefixes,
                        value: _selectedPrefix,
                        onChanged: (value) {
                          setState(() {
                            _selectedPrefix = value;
                            if (_selectedPrefix != 'Dr.') {
                              _selectedCategory = null;
                              _selectedSpeciality = null;
                              _selectedDegree = null;
                            }
                          });
                        },
                      ),
                      height(Responsive.h(12)),

                      CustomTextField(
                        label: 'First Name',
                        hint: 'Enter first name',
                        controller: _firstNameController,
                        isRequired: true,
                      ),
                      height(Responsive.h(12)),

                      CustomTextField(
                        label: 'Middle Name',
                        hint: 'Enter middle name',
                        controller: _middleNameController,
                      ),
                      height(Responsive.h(12)),

                      CustomTextField(
                        label: 'Last Name ',
                        hint: 'Enter last name',
                        controller: _lastNameController,
                        isRequired: true,
                      ),
                      height(Responsive.h(12)),

                      CustomTextField(
                        label: 'Enter your mobile number ',
                        hint: '10 digit mobile number',
                        controller: _mobileNoController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        isRequired: true,
                      ),
                      height(Responsive.h(12)),

                      CustomTextField(
                        label: 'Enter your email address',
                        hint: 'e.g. doctor@clinic.com',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        isRequired: true,
                      ),
                      height(Responsive.h(20)),
                      if (isDoctor) ...[
                        const _SectionHeader(title: 'Professional details'),
                        height(Responsive.h(12)),

                        CustomDropdownField(
                          label: 'Category ',
                          hint: 'Select Category',
                          items: categories,
                          value: _selectedCategory,
                          onChanged: (val) {
                            setState(() {
                              _selectedCategory = val;
                            });
                          },
                        ),
                        height(Responsive.h(12)),

                        CustomDropdownField(
                          label: 'Speciality ',
                          hint: 'Select Speciality',
                          items: specialities,
                          value: _selectedSpeciality,
                          onChanged: (val) {
                            setState(() {
                              _selectedSpeciality = val;
                            });
                          },
                        ),
                        height(Responsive.h(12)),

                        CustomDropdownField(
                          label: 'Degree',
                          hint: 'Select Degree',
                          items: degrees,
                          value: _selectedDegree,
                          onChanged: (val) {
                            setState(() {
                              _selectedDegree = val;
                            });
                          },
                        ),
                        height(Responsive.h(20)),
                      ],

                      const _SectionHeader(title: 'Referral details'),
                      height(Responsive.h(12)),

                      CustomTextField(
                        label: 'Organization / Source Code',
                        hint: 'Enter your organization code',
                        controller: _organizationCodeController,
                      ),
                      height(Responsive.h(12)),

                      CustomTextField(
                        label: 'Associate Code',
                        hint: 'Enter your associate code',
                        controller: _associateCodeController,
                      ),
                      height(Responsive.h(20)),
                      const _SectionHeader(title: 'Set your password'),
                      height(Responsive.h(12)),

                      CustomTextField(
                        label: 'Password ',
                        hint: 'Enter password',
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        isRequired: true,
                        suffixIcon: IconButton(
                          onPressed: () => setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          }),
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),

                      if (_passwordController.text.isNotEmpty) ...[
                        height(Responsive.h(4)),
                        Text(
                          _getPasswordStrength(),
                          style: TextStyle(
                            fontSize: Responsive.sp(11),
                            fontWeight: FontWeight.w600,
                            color: _getPasswordStrengthColor(),
                          ),
                        ),
                      ],
                      height(Responsive.h(12)),
                      CustomTextField(
                        label: 'Confirm password ',
                        hint: 'Confirm password',
                        controller: _confirmPasswordController,
                        obscureText: !_isConfirmPasswordVisible,
                        isRequired: true,
                        suffixIcon: IconButton(
                          onPressed: () => setState(() {
                            _isConfirmPasswordVisible =
                                !_isConfirmPasswordVisible;
                          }),
                          icon: Icon(
                            _isConfirmPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                      height(Responsive.h(20)),
                      RecaptchaWidget(
                        siteKey: 'YOUR_SITE_KEY',
                        onVerified: (token) =>
                            setState(() => _recaptchaToken = token),
                        onExpired: () => setState(() => _recaptchaToken = null),
                      ),
                      height(Responsive.h(16)),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Checkbox(
                              value: _agreeTerms,
                              onChanged: (val) =>
                                  setState(() => _agreeTerms = val ?? false),
                              activeColor: AppColors.brandGreen,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'I agree to the Terms & Conditions and Privacy Policy.',
                              style: customTextStyle(
                                fontSize: Responsive.sp(11),
                                color: const Color(0xFF334155),
                              ),
                            ),
                          ),
                        ],
                      ),
                      height(Responsive.h(24)),
                      PrimaryButton(
                        text: 'Submit Registration',
                        isLoading: authState.isLoading,
                        onPressed: authState.isLoading
                            ? null
                            : _onSignUpPressed,
                        gradient: LinearGradient(
                          colors: [AppColors.newPri, AppColors.primary],
                        ),
                        // backgroundColor: AppColors.brandGreen,
                      ),
                      height(Responsive.h(16)),

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     const Icon(
                      //       Icons.cloud_done_outlined,
                      //       size: 14,
                      //       color: Color(0xFF64748B),
                      //     ),
                      //     const SizedBox(width: 4),
                      //     Text(
                      //       'Your progress is saved automatically',
                      //       style: customTextStyle(
                      //         fontSize: Responsive.sp(11),
                      //         color: const Color(0xFF64748B),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // height(Responsive.h(24)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account? '),
                          GestureDetector(
                            onTap: () => context.pop(),
                            child: Text(
                              'Sign In',
                              style: customTextStyle(
                                color: AppColors.brandGreen,
                                fontWeight: FontWeight.bold,
                              ).copyWith(decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),

                      height(Responsive.h(32)),
                      SocialLinkWidget(),
                      height(Responsive.h(32)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: customTextStyle(
            fontSize: Responsive.sp(15),
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 4),
        const Divider(height: 1, color: Color(0xFFE2E8F0)),
      ],
    );
  }
}

class _PreviewDetailTile extends StatelessWidget {
  final String label;
  final String value;

  const _PreviewDetailTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: Responsive.sp(10),
            color: const Color(0xFF94A3B8),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: Responsive.sp(12),
            color: const Color(0xFF1E293B),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
