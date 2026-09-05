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

enum RegistrationType { professional, establishment }

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final DeviceService deviceService = DeviceService();

  RegistrationType _selectedType = RegistrationType.professional;

  late final TextEditingController _firstNameController;
  late final TextEditingController _middleNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _mobileNoController;
  late final TextEditingController _emailController;
  late final TextEditingController _establishmentNameController;
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
    _establishmentNameController = TextEditingController();
    _organizationCodeController = TextEditingController();
    _associateCodeController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _firstNameController.addListener(_onFieldChanged);
    _middleNameController.addListener(_onFieldChanged);
    _lastNameController.addListener(_onFieldChanged);
    _mobileNoController.addListener(_onFieldChanged);
    _emailController.addListener(_onFieldChanged);
    _establishmentNameController.addListener(_onFieldChanged);
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
    _establishmentNameController.dispose();
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Membership Registration'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              height(Responsive.h(16)),
              Center(
                child: Container(
                  width: Responsive.w(320),
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedType = RegistrationType.professional;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color:
                                  _selectedType == RegistrationType.professional
                                  ? const Color(0xFF15803D)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person_outline,
                                  size: 16,
                                  color:
                                      _selectedType ==
                                          RegistrationType.professional
                                      ? Colors.white
                                      : const Color(0xFF64748B),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Professional',
                                  style: customTextStyle(
                                    fontSize: Responsive.sp(13),
                                    fontWeight: FontWeight.w600,
                                    color:
                                        _selectedType ==
                                            RegistrationType.professional
                                        ? Colors.white
                                        : const Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedType = RegistrationType.establishment;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color:
                                  _selectedType ==
                                      RegistrationType.establishment
                                  ? const Color(0xFF15803D)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_city_outlined,
                                  size: 16,
                                  color:
                                      _selectedType ==
                                          RegistrationType.establishment
                                      ? Colors.white
                                      : Color(0xFF64748B),
                                ),
                                width(6),
                                Text(
                                  'Establishment',
                                  style: customTextStyle(
                                    fontSize: Responsive.sp(13),
                                    fontWeight: FontWeight.w600,
                                    color:
                                        _selectedType ==
                                            RegistrationType.establishment
                                        ? Colors.white
                                        : Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: Responsive.sp(20)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      height(Responsive.h(12)),
                      _SectionHeader(title: 'PERSONAL DETAILS'),
                      height(Responsive.h(12)),
                      CustomDropdownField(
                        label: 'Prefix',
                        hint: 'Select Prefix',
                        items: prefixes,
                        value: _selectedPrefix,
                        onChanged: (value) {
                          setState(() {
                            _selectedPrefix = value;
                          });
                        },
                      ),
                      height(Responsive.h(12)),

                      CustomTextField(
                        label: 'First name',
                        hint: 'Enter first name',
                        controller: _firstNameController,
                        isRequired: true,
                      ),
                      height(Responsive.h(12)),

                      CustomTextField(
                        label: 'Middle name',
                        hint: 'Enter middle name',
                        controller: _middleNameController,
                      ),
                      height(Responsive.h(12)),

                      CustomTextField(
                        label: 'Last name',
                        hint: 'Enter last name',
                        controller: _lastNameController,
                        isRequired: true,
                      ),
                      height(Responsive.h(12)),

                      CustomTextField(
                        label: 'Enter your mobile number',
                        hint: '10 digit mobile number',
                        controller: _mobileNoController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        isRequired: true,
                      ),

                      // Helper text from mockup
                      Text(
                        'One mobile number = one login. This number can cover one Individual policy and multiple Establishment policies under the same login — it can\'t be used to create a second account, or added to a different login while securing membership.',
                        style: customTextStyle(
                          fontSize: Responsive.sp(10),
                          color: const Color(0xFF64748B),
                        ).copyWith(height: 1.4),
                      ),
                      height(Responsive.h(12)),

                      CustomTextField(
                        label: 'Enter your email address',
                        hint: 'you@clinic.com',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        isRequired: true,
                      ),
                      height(Responsive.h(20)),

                      // Conditional Professional vs Establishment Details Section
                      if (_selectedType == RegistrationType.professional) ...[
                        const _SectionHeader(title: 'PROFESSIONAL DETAILS'),
                        height(Responsive.h(12)),
                        CustomDropdownField(
                          label: 'Category *',
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
                          label: 'Speciality',
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
                      ] else ...[
                        const _SectionHeader(title: 'ESTABLISHMENT DETAILS'),
                        height(Responsive.h(12)),

                        CustomDropdownField(
                          label: 'Category *',
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

                        CustomTextField(
                          label: 'Establishment Name',
                          hint: 'e.g. Mathur Multispeciality Clinic',
                          controller: _establishmentNameController,
                          isRequired: true,
                        ),
                        height(Responsive.h(20)),
                      ],

                      const _SectionHeader(title: 'REFERRAL DETAILS'),
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

                      const _SectionHeader(title: 'SET YOUR PASSWORD'),
                      height(Responsive.h(12)),

                      CustomTextField(
                        label: 'Password *',
                        hint: 'At least 8 characters',
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
                        label: 'Confirm password *',
                        hint: 'Re-enter password',
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
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'I agree to the Terms & Conditions and Privacy Policy.',
                              style: customTextStyle(
                                fontSize: Responsive.sp(11),
                                color: Color(0xFF334155),
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
                      ),
                      height(Responsive.h(16)),

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
            fontSize: Responsive.sp(12),
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F172A),
          ),
        ),
        height(4),
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
          style: customTextStyle(
            fontSize: Responsive.sp(10),
            color: const Color(0xFF94A3B8),
            fontWeight: FontWeight.w500,
          ),
        ),
        height(2),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: customTextStyle(
            fontSize: Responsive.sp(12),
            color: const Color(0xFF1E293B),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
