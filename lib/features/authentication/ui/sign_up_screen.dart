import 'dart:math';

import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/authentication/model/register/category_response.dart';
import 'package:Doctors_App/features/authentication/model/register/register_request.dart';
import 'package:Doctors_App/features/authentication/model/register/speciality_response.dart';
import 'package:Doctors_App/features/fcm/device_service.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  String? _captchaToken;
  Key _captchaKey = UniqueKey();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _agreeTerms = false;
  bool _isSubmitting = false;

  String? _selectedPrefix;

  String? _selectedCategoryId;
  String? _selectedCategoryName;

  String? _selectedSpecialityId;
  String? _selectedSpecialityName;

  final List<_IdName> _selectedDegrees = [];

  final prefixes = ['Dr.', 'Mr.', 'Mrs.', 'Ms.'];

  List<String> get _availablePrefixes {
    if (_selectedType == RegistrationType.professional) {
      return ['Dr.'];
    }
    return prefixes;
  }

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

    _passwordController.addListener(_onFieldChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authenticationViewModelProvider.notifier).categoryList();
      ref.read(authenticationViewModelProvider.notifier).degreeList();
    });
  }

  void _onFieldChanged() => setState(() {});

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

  void _resetCaptcha() {
    setState(() {
      _captchaToken = null;
      _captchaKey = UniqueKey();
    });
  }

  Future<void> _onSignUpPressed() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (_passwordController.text != _confirmPasswordController.text) {
      context.showWarningSnackBar('Passwords do not match');
      return;
    }

    if (_selectedCategoryId == null) {
      context.showWarningSnackBar('Please select a category');
      return;
    }

    if (_selectedType == RegistrationType.professional &&
        _selectedSpecialityId == null) {
      context.showWarningSnackBar('Please select a speciality');
      return;
    }

    if (_selectedType == RegistrationType.professional &&
        _selectedDegrees.isEmpty) {
      context.showWarningSnackBar('Please select at least one degree');
      return;
    }

    if (_selectedType == RegistrationType.establishment &&
        _establishmentNameController.text.trim().isEmpty) {
      context.showWarningSnackBar('Please enter the establishment name');
      return;
    }

    if (!_agreeTerms) {
      context.showWarningSnackBar('Please agree to the Terms & Conditions');
      return;
    }

    if (_captchaToken == null || _captchaToken!.isEmpty) {
      context.showWarningSnackBar('Please complete the verification check');
      return;
    }

    final request = RegisterRequest(
      productTypeId: _selectedType == RegistrationType.professional ? 1 : 2,
      prefix: _selectedPrefix ?? 'Dr.',
      firstName: _firstNameController.text.trim(),
      middleName: _middleNameController.text.trim().isEmpty
          ? null
          : _middleNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      mobileNo: _mobileNoController.text.trim(),
      email: _emailController.text.trim().isEmpty
          ? null
          : _emailController.text.trim(),
      categoryId: int.parse(_selectedCategoryId!),
      specialityId: _selectedType == RegistrationType.professional
          ? int.parse(_selectedSpecialityId!)
          : 0,
      degree: _selectedType == RegistrationType.professional
          ? _selectedDegrees.map((d) => d.name).join(', ')
          : '',
      organizationName: _selectedType == RegistrationType.establishment
          ? _establishmentNameController.text.trim()
          : (_organizationCodeController.text.trim().isEmpty
                ? null
                : _organizationCodeController.text.trim()),
      source: _associateCodeController.text.trim(),
      password: _passwordController.text,
      termsPrivacyAccepted: _agreeTerms,
    );

    setState(() => _isSubmitting = true);

    try {
      await ref
          .read(authenticationViewModelProvider.notifier)
          .register(request);

      if (!mounted) return;
      context.showSuccessSnackBar('Registration successful. Please sign in.');
      context.pop();
    } catch (error) {
      if (!mounted) return;
      context.showWarningSnackBar('Registration failed: $error');
      _resetCaptcha();
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  int _getPasswordStrengthScore() {
    final pass = _passwordController.text;
    if (pass.isEmpty) return 0;
    if (pass.length < 8) return 1;

    int score = 1;
    if (RegExp(r'[0-9]').hasMatch(pass)) score++;
    if (RegExp(r'[a-z]').hasMatch(pass) && RegExp(r'[A-Z]').hasMatch(pass)) {
      score++;
    }
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(pass)) score++;
    return score;
  }

  String _getPasswordStrengthLabel() {
    final pass = _passwordController.text;
    if (pass.isEmpty) return '';
    if (pass.length < 8) return 'Weak — enter at least 8 characters';

    switch (_getPasswordStrengthScore()) {
      case 1:
        return 'Weak — add numbers or uppercase letters';
      case 2:
        return 'Fair — add symbols for better security';
      case 3:
        return 'Good — add special characters';
      case 4:
        return 'Strong password';
      default:
        return 'Weak';
    }
  }

  Color _getPasswordStrengthColor() {
    final pass = _passwordController.text;
    if (pass.isEmpty || pass.length < 8) return Colors.red;

    switch (_getPasswordStrengthScore()) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.amber.shade700;
      case 4:
        return Colors.green;
      default:
        return Colors.red;
    }
  }

  Widget _buildPasswordStrengthBar() {
    final score = _getPasswordStrengthScore();
    final color = _getPasswordStrengthColor();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(4, (index) {
            final isFilled = index < score;
            return Expanded(
              child: Container(
                height: 4,
                margin: EdgeInsets.only(right: index == 3 ? 0 : 4),
                decoration: BoxDecoration(
                  color: isFilled ? color : const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        ),
        height(Responsive.h(6)),
        Text(
          _getPasswordStrengthLabel(),
          style: customTextStyle(
            fontSize: Responsive.sp(11),
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  List<_IdName> _mapIdName(List<dynamic> items) {
    return items
        .map((e) => _IdName(id: e.id as int, name: e.name as String))
        .toList();
  }

  Widget _buildAsyncDropdown<T>({
    required String label,
    required AsyncValue<T?> asyncValue,
    required List<_IdName> Function(T data) itemsBuilder,
    required String? selectedName,
    required ValueChanged<_IdName> onSelected,
    required VoidCallback onRetry,
    String emptyHint = 'Select an option',
    bool disabled = false,
  }) {
    if (disabled) {
      return CustomDropdownField(
        label: label,
        hint: emptyHint,
        items: const [],
        value: null,
        onChanged: null,
      );
    }

    return asyncValue.when(
      data: (data) {
        final items = data == null ? <_IdName>[] : itemsBuilder(data);

        if (items.isEmpty) {
          return CustomDropdownField(
            label: label,
            hint: emptyHint,
            items: const [],
            value: null,
            onChanged: null,
          );
        }

        return CustomDropdownField(
          label: label,
          hint: emptyHint,
          items: items.map((e) => e.name).toList(),
          value: selectedName,
          onChanged: (val) {
            if (val == null) return;
            final match = items.firstWhere((e) => e.name == val);
            onSelected(match);
          },
        );
      },
      loading: () => CustomDropdownField(
        label: label,
        hint: 'Loading...',
        items: const [],
        value: null,
        onChanged: null,
      ),
      error: (err, st) => InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Failed to load',
                style: customTextStyle(
                  fontSize: Responsive.sp(12),
                  color: Colors.red,
                ),
              ),
            ),
            TextButton(
              onPressed: onRetry,
              child: Text(
                'Retry',
                style: customTextStyle(
                  fontSize: Responsive.sp(12),
                  fontWeight: FontWeight.w700,
                  color: AppColors.brandGreen,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openDegreePicker(List<_IdName> allDegrees) async {
    final tempSelected = [..._selectedDegrees];

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Degree(s)',
                      style: customTextStyle(
                        fontSize: Responsive.sp(15),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    height(Responsive.h(12)),
                    if (allDegrees.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Text(
                          'No degrees available',
                          style: customTextStyle(
                            fontSize: Responsive.sp(12),
                            color: const Color(0xFF94A3B8),
                          ),
                        ),
                      )
                    else
                      Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: allDegrees.length,
                          itemBuilder: (context, index) {
                            final degree = allDegrees[index];
                            final isChecked = tempSelected.any(
                              (d) => d.id == degree.id,
                            );
                            return CheckboxListTile(
                              value: isChecked,
                              title: Text(degree.name),
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (checked) {
                                setSheetState(() {
                                  if (checked ?? false) {
                                    tempSelected.add(degree);
                                  } else {
                                    tempSelected.removeWhere(
                                      (d) => d.id == degree.id,
                                    );
                                  }
                                });
                              },
                            );
                          },
                        ),
                      ),
                    height(Responsive.h(12)),
                    PrimaryButton(
                      height: 46,
                      fontSize: 14,
                      text: 'Done',
                      onPressed: allDegrees.isEmpty
                          ? null
                          : () {
                              setState(() {
                                _selectedDegrees
                                  ..clear()
                                  ..addAll(tempSelected);
                              });
                              Navigator.of(sheetContext).pop();
                            },
                      gradient: LinearGradient(
                        colors: [AppColors.newPri, AppColors.primary],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDegreeField(AsyncValue<dynamic> degreeAsync) {
    return degreeAsync.when(
      data: (response) {
        final allDegrees = _mapIdName(response.data as List<dynamic>);

        return GestureDetector(
          onTap: () => _openDegreePicker(allDegrees),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: 'Degree *',
              hintText: allDegrees.isEmpty
                  ? 'No degrees available'
                  : 'Select Degree(s)',
              suffixIcon: const Icon(Icons.arrow_drop_down),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: _selectedDegrees.isEmpty
                ? Text(
                    allDegrees.isEmpty
                        ? 'No degrees available'
                        : 'Select Degree(s)',
                    style: customTextStyle(
                      fontSize: Responsive.sp(13),
                      color: const Color(0xFF94A3B8),
                    ),
                  )
                : Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: _selectedDegrees
                        .map(
                          (d) => Chip(
                            label: Text(d.name),
                            onDeleted: () {
                              setState(() => _selectedDegrees.remove(d));
                            },
                          ),
                        )
                        .toList(),
                  ),
          ),
        );
      },
      loading: () => InputDecorator(
        decoration: InputDecoration(
          labelText: 'Degree *',
          hintText: 'Loading...',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          'Loading...',
          style: customTextStyle(
            fontSize: Responsive.sp(13),
            color: const Color(0xFF94A3B8),
          ),
        ),
      ),
      error: (err, st) => InputDecorator(
        decoration: InputDecoration(
          labelText: 'Degree *',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Failed to load',
                style: customTextStyle(
                  fontSize: Responsive.sp(12),
                  color: Colors.red,
                ),
              ),
            ),
            TextButton(
              onPressed: () => ref
                  .read(authenticationViewModelProvider.notifier)
                  .degreeList(),
              child: Text(
                'Retry',
                style: customTextStyle(
                  fontSize: Responsive.sp(12),
                  fontWeight: FontWeight.w700,
                  color: AppColors.brandGreen,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authenticationViewModelProvider);
    final authenticationState = authState.valueOrNull;

    final categoryAsync =
        authenticationState?.categoryAsync ?? const AsyncLoading();
    final specialityAsync =
        authenticationState?.specialityAsync ?? const AsyncData(null);
    final degreeAsync =
        authenticationState?.degreeAsync ?? const AsyncLoading();

    final isLoading = _isSubmitting || authState.isLoading;

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
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildTypeToggle(
                          label: 'Professional',
                          icon: Icons.person_outline,
                          isSelected:
                              _selectedType == RegistrationType.professional,
                          onTap: () {
                            setState(() {
                              _selectedType = RegistrationType.professional;
                              _selectedPrefix = 'Dr.';
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: _buildTypeToggle(
                          label: 'Establishment',
                          icon: Icons.location_city_outlined,
                          isSelected:
                              _selectedType == RegistrationType.establishment,
                          onTap: () {
                            setState(() {
                              _selectedType = RegistrationType.establishment;
                              _selectedPrefix ??= 'Dr.';
                            });
                          },
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
                        items: _availablePrefixes,
                        value: _selectedPrefix,
                        onChanged: (value) {
                          setState(() => _selectedPrefix = value);
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
                        isRequired: false,
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      Text(
                        'One mobile number = one login. This number can cover '
                        'one Individual policy and multiple Establishment '
                        'policies under the same login — it can\'t be used to '
                        'create a second account, or added to a different '
                        'login while securing membership.',
                        style: customTextStyle(
                          fontSize: Responsive.sp(10),
                          color: Color(0xFF64748B),
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
                      if (_selectedType == RegistrationType.professional) ...[
                        const _SectionHeader(title: 'PROFESSIONAL DETAILS'),
                        height(Responsive.h(12)),
                        _buildAsyncDropdown<CategoryResponse>(
                          label: 'Category',
                          emptyHint: 'Select Category',
                          asyncValue: categoryAsync.whenData((r) => r),
                          itemsBuilder: (r) => _mapIdName(r.data),
                          selectedName: _selectedCategoryName,
                          onRetry: () => ref
                              .read(authenticationViewModelProvider.notifier)
                              .categoryList(),
                          onSelected: (match) {
                            setState(() {
                              _selectedCategoryName = match.name;
                              _selectedCategoryId = match.id.toString();
                              _selectedSpecialityId = null;
                              _selectedSpecialityName = null;
                            });
                            ref
                                .read(authenticationViewModelProvider.notifier)
                                .specialityList(
                                  categoryId: match.id.toString(),
                                );
                          },
                        ),
                        height(Responsive.h(12)),
                        _buildAsyncDropdown<SpecialityResponse>(
                          label: 'Speciality *',
                          emptyHint: _selectedCategoryId == null
                              ? 'Select a category first'
                              : 'Select Speciality',
                          disabled: _selectedCategoryId == null,
                          asyncValue: specialityAsync.whenData((r) => r),
                          itemsBuilder: (r) => _mapIdName(r.data),
                          selectedName: _selectedSpecialityName,
                          onRetry: () {
                            if (_selectedCategoryId != null) {
                              ref
                                  .read(
                                    authenticationViewModelProvider.notifier,
                                  )
                                  .specialityList(
                                    categoryId: _selectedCategoryId!,
                                  );
                            }
                          },
                          onSelected: (match) {
                            setState(() {
                              _selectedSpecialityName = match.name;
                              _selectedSpecialityId = match.id.toString();
                            });
                          },
                        ),
                        height(Responsive.h(12)),
                        _buildDegreeField(degreeAsync),
                        height(Responsive.h(20)),
                      ] else ...[
                        _SectionHeader(title: 'ESTABLISHMENT DETAILS'),
                        height(Responsive.h(12)),
                        _buildAsyncDropdown<CategoryResponse>(
                          label: 'Category',
                          emptyHint: 'Select Category',
                          asyncValue: categoryAsync.whenData((r) => r),
                          itemsBuilder: (r) => _mapIdName(r.data),
                          selectedName: _selectedCategoryName,
                          onRetry: () => ref
                              .read(authenticationViewModelProvider.notifier)
                              .categoryList(),
                          onSelected: (match) {
                            setState(() {
                              _selectedCategoryName = match.name;
                              _selectedCategoryId = match.id.toString();
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
                        label: 'Enter Your Organization Name',
                        hint: 'e.g. ABC Medical Organization',
                        controller: _organizationCodeController,
                      ),
                      height(Responsive.h(12)),
                      CustomTextField(
                        label: 'Where did you hear about us?',
                        hint: 'e.g. Webinar',
                        controller: _associateCodeController,
                      ),
                      height(Responsive.h(20)),
                      const _SectionHeader(title: 'SET YOUR PASSWORD'),
                      height(Responsive.h(12)),
                      CustomTextField(
                        label: 'Password',
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
                        height(Responsive.h(6)),
                        _buildPasswordStrengthBar(),
                      ],
                      height(Responsive.h(12)),
                      CustomTextField(
                        label: 'Confirm password',
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
                      // Placeholder verification check — swap for real
                      // reCAPTCHA once a site key is configured. Keeps the
                      // "must verify before submit" contract identical.
                      _SimpleCaptchaField(
                        key: _captchaKey,
                        onVerified: (token) =>
                            setState(() => _captchaToken = token),
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
                          width(8),
                          Expanded(
                            child: Text(
                              'I agree to the Terms & Conditions and Privacy '
                              'Policy.',
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
                        height: 50,
                        fontSize: 14,
                        text: 'Submit',
                        isLoading: isLoading,
                        onPressed: isLoading ? null : _onSignUpPressed,
                        gradient: LinearGradient(
                          colors: [AppColors.newPri, AppColors.primary],
                        ),
                      ),
                      height(Responsive.h(16)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account? '),
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
                      const SocialLinkWidget(),
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

  Widget _buildTypeToggle({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.buttonColor2 : AppColors.lightGreen,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : const Color(0xFF64748B),
            ),
            width(6),
            Text(
              label,
              style: customTextStyle(
                fontSize: Responsive.sp(13),
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IdName {
  final int id;
  final String name;

  const _IdName({required this.id, required this.name});
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
            fontWeight: FontWeight.w700,
            color: AppColors.buttonColor2,
          ),
        ),
        height(4),
        const Divider(height: 1, color: Color(0xFFE2E8F0)),
      ],
    );
  }
}

/// Lightweight "prove you're not a bot" check to use until real reCAPTCHA
/// credentials are wired up. Generates a small addition challenge, verifies
/// the answer locally, and reports a token back through [onVerified] — the
/// same contract the real reCAPTCHA widget will use (a non-null/non-empty
/// string on success, null otherwise), so swapping it back in later is a
/// one-widget change in [_SignUpScreenState].
class _SimpleCaptchaField extends StatefulWidget {
  final ValueChanged<String?> onVerified;

  const _SimpleCaptchaField({super.key, required this.onVerified});

  @override
  State<_SimpleCaptchaField> createState() => _SimpleCaptchaFieldState();
}

class _SimpleCaptchaFieldState extends State<_SimpleCaptchaField> {
  final _answerController = TextEditingController();
  late int _a;
  late int _b;
  bool _verified = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _generateChallenge(); // no callback here
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  void _generateChallenge() {
    final rnd = Random();
    _a = rnd.nextInt(8) + 1;
    _b = rnd.nextInt(8) + 1;
    _answerController.clear();
    _verified = false;
    _error = null;
  }

  void _newChallenge() {
    setState(() {
      _generateChallenge();
    });
    // Safe to notify parent – this is only called from a user gesture
    // (the refresh button) or after verification fails.
    widget.onVerified(null);
  }

  void _check() {
    final entered = int.tryParse(_answerController.text.trim());
    setState(() {
      if (entered != null && entered == _a + _b) {
        _verified = true;
        _error = null;
        widget.onVerified('captcha-${_a}-${_b}-verified');
      } else {
        _verified = false;
        _error = 'That\'s not quite right, try again';
        widget.onVerified(null);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: _verified ? Colors.green : const Color(0xFFE2E8F0),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Verify you\'re human',
            style: customTextStyle(
              fontSize: Responsive.sp(12),
              fontWeight: FontWeight.w700,
            ),
          ),
          height(Responsive.h(8)),
          Row(
            children: [
              Text(
                '$_a + $_b =',
                style: customTextStyle(
                  fontSize: Responsive.sp(14),
                  fontWeight: FontWeight.w600,
                ),
              ),
              width(8),
              SizedBox(
                width: 56,
                child: TextField(
                  controller: _answerController,
                  enabled: !_verified,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              width(8),
              if (_verified)
                const Icon(Icons.check_circle, color: Colors.green, size: 22)
              else
                TextButton(onPressed: _check, child: const Text('Verify')),
              const Spacer(),
              IconButton(
                tooltip: 'New challenge',
                icon: const Icon(Icons.refresh, size: 20),
                onPressed: _newChallenge,
              ),
            ],
          ),
          if (_error != null) ...[
            height(Responsive.h(4)),
            Text(
              _error!,
              style: customTextStyle(
                fontSize: Responsive.sp(11),
                color: Colors.red,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
