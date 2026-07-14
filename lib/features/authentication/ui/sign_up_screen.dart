import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/authentication/ui/widgets/recapta_widget.dart';
import 'package:Doctors_App/features/fcm/device_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../core/exceptions/exception_extension.dart';
import '../../../core/widgets/custom_dropdown_field.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../routing/routes.dart';
import '../../../theme/app_colors.dart';
import '../../common/ui/widgets/primary_button.dart';
import 'view_model/authentication_view_model.dart';
import 'widgets/header_clipper.dart';

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
  String? fcmToken;
  String? deviceId;

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final prefixes = ['Dr.', 'Mr.', 'Mrs.', 'Ms.'];
  String? _selectedPrefix;

  final categories = [
    'General Practitioner All Pathy'
        'Physician Consultant',
    'Dental Surgeon'
        'Plastic /Cosmetic',
  ];

  final specialities = [
    'Plastic Surgeon',
    'Cosmetic Surgeon',
    'Anesthetic Surgeon',
  ];

  final degrees = ['MBBS', 'MS', 'MDS', 'BDS', 'MD', 'DM'];

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

    if (_recaptchaToken == null) {
      context.showWarningSnackBar('Please complete the captcha');
      return;
    }

    // ref.read(authenticationViewModelProvider.notifier).signUp(
    //   firstName: _firstNameController.text.trim(),
    //   middleName: _middleNameController.text.trim(),
    //   lastName: _lastNameController.text.trim(),
    //   mobile: _mobileNoController.text.trim(),
    //   email: _emailController.text.trim(),
    //   organizationCode: _organizationCodeController.text.trim(),
    //   associateCode: _associateCodeController.text.trim(),
    //   password: _passwordController.text,
    // );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authenticationViewModelProvider);

    ref.listen(authenticationViewModelProvider, (prev, next) {
      next.whenOrNull(
        data: (state) {
          if (state.model != null) {
            final applicationStatus =
                state.model!.data.customer.application_status;

            if (applicationStatus == 'Accept') {
              context.go(Routes.main);
            } else {
              context.go(Routes.employeeOnboarding);
            }
          }
        },
        error: (e, _) {
          context.showWarningSnackBar(e.readableMessage);
        },
      );
    });

    return Scaffold(
      backgroundColor: context.secondaryBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 320,
                width: double.infinity,
                child: ClipPath(
                  clipper: HeaderClipper(),
                  child: Container(
                    color: AppColors.watermelon1,
                    child: Center(child: Image.asset(Assets.login, width: 200)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      height(32),
                      Center(
                        child: Text(
                          'Create Account',
                          style: customTextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      height(24),

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
                      height(16),

                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              label: 'First Name',
                              hint: 'Enter first name',
                              controller: _firstNameController,
                              isRequired: true,
                            ),
                          ),
                          width(12),
                          Expanded(
                            child: CustomTextField(
                              label: 'Middle Name',
                              hint: 'Enter middle name',
                              controller: _middleNameController,
                            ),
                          ),
                          width(12),
                          Expanded(
                            child: CustomTextField(
                              label: 'Last Name',
                              hint: 'Enter last name',
                              controller: _lastNameController,
                              isRequired: true,
                            ),
                          ),
                        ],
                      ),
                      height(16),

                      CustomTextField(
                        label: 'Mobile Number',
                        hint: 'Enter your mobile number',
                        controller: _mobileNoController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        isRequired: true,
                      ),
                      height(16),

                      CustomTextField(
                        label: 'Email Address',
                        hint: 'Enter your email address',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        isRequired: true,
                      ),
                      height(16),
                      if (_selectedPrefix == 'Dr.') ...[
                        CustomDropdownField(
                          label: 'Category',
                          hint: 'Select Category',
                          items: categories,
                        ),
                        height(16),

                        CustomDropdownField(
                          label: 'Speciality',
                          hint: 'Select Speciality',
                          items: specialities,
                        ),
                        height(16),

                        CustomDropdownField(
                          label: 'Degree',
                          hint: 'Select Degree',
                          items: degrees,
                        ),
                        height(16),
                      ],
                      CustomTextField(
                        label: 'Organization Code',
                        hint: 'Enter your organization code',
                        controller: _organizationCodeController,
                      ),
                      height(16),

                      CustomTextField(
                        label: 'Associate Code',
                        hint: 'Enter your associate code',
                        controller: _associateCodeController,
                      ),
                      height(16),

                      CustomTextField(
                        label: 'Password',
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
                      height(16),
                      CustomTextField(
                        label: 'Confirm Password',
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
                      height(24),
                      RecaptchaWidget(
                        siteKey: 'YOUR_SITE_KEY',
                        onVerified: (token) =>
                            setState(() => _recaptchaToken = token),
                        onExpired: () => setState(() => _recaptchaToken = null),
                      ),
                      height(24),

                      PrimaryButton(
                        text: 'Sign Up',
                        isLoading: authState.isLoading,
                        onPressed: authState.isLoading
                            ? null
                            : _onSignUpPressed,
                      ),
                      height(24),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account? '),
                          GestureDetector(
                            onTap: () => context.pop(),
                            child: Text(
                              'Sign In',
                              style: customTextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ).copyWith(decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
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
