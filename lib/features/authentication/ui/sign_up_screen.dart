import 'dart:math';

import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/widgets/app_dialog.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/authentication/ui/state/authentication_state.dart';
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

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  Future<void> _onSignUpPressed(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(authenticationViewModelProvider.notifier);
    try {
      final success = await notifier.submitRegistration();
      if (!success || !context.mounted) return;
      context.showSuccessSnackBar('Registration successful. Please sign in.');
      notifier.resetForm();
      context.pop();
    } on RegistrationValidationException catch (error) {
      if (!context.mounted) return;
      context.showWarningSnackBar(error.message);
    } catch (error) {
      if (!context.mounted) return;
      context.showWarningSnackBar('Registration failed: $error');
    }
  }

  Future<void> _openDegreePicker(
    BuildContext context,
    WidgetRef ref,
    AuthenticationState state,
  ) async {
    final notifier = ref.read(authenticationViewModelProvider.notifier);

    final tempSelected = [...state.selectedDegrees];

    await AppDialog.customBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.all(16),
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
                  if (state.degrees.isEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Center(
                        child: Text(
                          'No degrees available',
                          style: customTextStyle(
                            fontSize: Responsive.sp(12),
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                      ),
                    )
                  else
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.degrees.length,
                        itemBuilder: (context, index) {
                          final degree = state.degrees[index];

                          final isChecked = tempSelected.any(
                            (item) => item.id == degree.id,
                          );

                          return CheckboxListTile(
                            value: isChecked,
                            title: Text(
                              degree.name,
                              style: customTextStyle(
                                fontSize: Responsive.sp(13),
                              ),
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsets.zero,
                            onChanged: (checked) {
                              setSheetState(() {
                                if (checked == true) {
                                  if (!tempSelected.any(
                                    (item) => item.id == degree.id,
                                  )) {
                                    tempSelected.add(degree);
                                  }
                                } else {
                                  tempSelected.removeWhere(
                                    (item) => item.id == degree.id,
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
                    onPressed: state.degrees.isEmpty
                        ? null
                        : () {
                            notifier.setSelectedDegrees(tempSelected);

                            Navigator.of(sheetContext).pop();
                          },
                    gradient: LinearGradient(
                      colors: [AppColors.newPri, AppColors.primary],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildReferenceDropdown({
    required String label,
    required String emptyHint,
    required bool isLoading,
    required String? error,
    required List<IdNameOption> items,
    required IdNameOption? selected,
    required ValueChanged<IdNameOption> onSelected,
    required VoidCallback onRetry,
    bool disabled = false,
  }) {
    final blocked = disabled || isLoading || error != null;
    final hint = disabled
        ? emptyHint
        : isLoading
        ? 'Loading...'
        : error != null
        ? 'Failed to load — tap to retry'
        : emptyHint;

    final field = CustomDropdownField(
      label: label,
      hint: hint,
      items: blocked ? const <String>[] : items.map((e) => e.name).toList(),
      value: selected?.name,
      onChanged: blocked
          ? null
          : (val) {
              if (val == null) return;
              final match = items.firstWhere((e) => e.name == val);
              onSelected(match);
            },
    );

    return error != null
        ? GestureDetector(onTap: onRetry, child: field)
        : field;
  }

  Widget _buildDegreeField(
    BuildContext context,
    WidgetRef ref,
    AuthenticationState state,
  ) {
    final hasError = state.degreeError != null;

    return GestureDetector(
      onTap: () {
        if (hasError) {
          ref.read(authenticationViewModelProvider.notifier).degreeList();
          return;
        }
        _openDegreePicker(context, ref, state);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Degree',
          suffixIcon: hasError
              ? const Icon(Icons.refresh, size: 20)
              : const Icon(Icons.arrow_drop_down),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: state.isDegreeLoading
            ? Text(
                'Loading...',
                style: customTextStyle(
                  fontSize: Responsive.sp(13),
                  color: const Color(0xFF94A3B8),
                ),
              )
            : hasError
            ? Text(
                'Failed to load — tap to retry',
                style: customTextStyle(
                  fontSize: Responsive.sp(12),
                  color: Colors.red,
                ),
              )
            : state.selectedDegrees.isEmpty
            ? Text(
                state.degrees.isEmpty
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
                children: state.selectedDegrees
                    .map(
                      (d) => Chip(
                        label: Text(d.name),
                        onDeleted: () {
                          ref
                              .read(authenticationViewModelProvider.notifier)
                              .setSelectedDegrees(
                                state.selectedDegrees
                                    .where((e) => e.id != d.id)
                                    .toList(),
                              );
                        },
                      ),
                    )
                    .toList(),
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

  Widget _buildPasswordStrengthBar(WidgetRef ref) {
    final notifier = ref.read(authenticationViewModelProvider.notifier);
    final score = notifier.passwordStrengthScore;
    final color = notifier.passwordStrengthColor;

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
          notifier.passwordStrengthLabel,
          style: customTextStyle(
            fontSize: Responsive.sp(11),
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authAsync = ref.watch(authenticationViewModelProvider);
    final notifier = ref.read(authenticationViewModelProvider.notifier);
    final state = authAsync.valueOrNull ?? const AuthenticationState();
    final isLoading = state.isSubmitting || authAsync.isLoading;

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
                              state.registrationType ==
                              RegistrationType.professional,
                          onTap: () => notifier.selectRegistrationType(
                            RegistrationType.professional,
                          ),
                        ),
                      ),
                      Expanded(
                        child: _buildTypeToggle(
                          label: 'Establishment',
                          icon: Icons.location_city_outlined,
                          isSelected:
                              state.registrationType ==
                              RegistrationType.establishment,
                          onTap: () => notifier.selectRegistrationType(
                            RegistrationType.establishment,
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
                  key: notifier.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      height(Responsive.h(12)),
                      _SectionHeader(title: 'PERSONAL DETAILS'),
                      height(Responsive.h(12)),
                      CustomDropdownField(
                        label: 'Prefix',
                        hint: 'Select Prefix',
                        items: notifier.availablePrefixes,
                        value: state.selectedPrefix,
                        onChanged: (value) {
                          if (value != null) notifier.selectPrefix(value);
                        },
                      ),
                      height(Responsive.h(12)),
                      CustomTextField(
                        label: 'First name',
                        hint: 'Enter first name',
                        controller: notifier.firstNameController,
                        isRequired: true,
                      ),
                      height(Responsive.h(12)),
                      CustomTextField(
                        hint: 'Enter middle name',
                        controller: notifier.middleNameController,
                        isRequired: false,
                      ),
                      height(Responsive.h(12)),
                      CustomTextField(
                        label: 'Last name',
                        hint: 'Enter last name',
                        controller: notifier.lastNameController,
                        isRequired: true,
                      ),
                      height(Responsive.h(12)),
                      CustomTextField(
                        label: 'Enter your mobile number',
                        hint: '10 digit mobile number',
                        controller: notifier.mobileNoController,
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
                        controller: notifier.emailController,
                        keyboardType: TextInputType.emailAddress,
                        isRequired: true,
                      ),
                      height(Responsive.h(20)),
                      if (state.registrationType ==
                          RegistrationType.professional) ...[
                        _SectionHeader(title: 'PROFESSIONAL DETAILS'),
                        height(Responsive.h(12)),
                        _buildReferenceDropdown(
                          label: 'Category',
                          emptyHint: 'Select Category',
                          isLoading: state.isCategoryLoading,
                          error: state.categoryError,
                          items: state.categories,
                          selected: state.selectedCategory,
                          onRetry: notifier.categoryList,
                          onSelected: notifier.selectCategory,
                        ),
                        height(Responsive.h(12)),
                        _buildReferenceDropdown(
                          label: 'Speciality',
                          emptyHint: state.selectedCategory == null
                              ? 'Select a category first'
                              : 'Select Speciality',
                          disabled: state.selectedCategory == null,
                          isLoading: state.isSpecialityLoading,
                          error: state.specialityError,
                          items: state.specialities,
                          selected: state.selectedSpeciality,
                          onRetry: () {
                            if (state.selectedCategory != null) {
                              notifier.specialityList(
                                categoryId: state.selectedCategory!.id
                                    .toString(),
                              );
                            }
                          },
                          onSelected: notifier.selectSpeciality,
                        ),
                        height(Responsive.h(25)),
                        _buildDegreeField(context, ref, state),
                        height(Responsive.h(20)),
                      ] else ...[
                        _SectionHeader(title: 'ESTABLISHMENT DETAILS'),
                        height(Responsive.h(12)),
                        _buildReferenceDropdown(
                          label: 'Category',
                          emptyHint: 'Select Category',
                          isLoading: state.isCategoryLoading,
                          error: state.categoryError,
                          items: state.categories,
                          selected: state.selectedCategory,
                          onRetry: notifier.categoryList,
                          onSelected: notifier.selectCategory,
                        ),
                        height(Responsive.h(12)),
                        CustomTextField(
                          label: 'Establishment Name',
                          hint: 'e.g. Mathur Multispeciality Clinic',
                          controller: notifier.establishmentNameController,
                          isRequired: true,
                        ),
                        height(Responsive.h(20)),
                      ],
                      const _SectionHeader(title: 'REFERRAL DETAILS'),
                      height(Responsive.h(12)),
                      CustomTextField(
                        label: 'Enter Your Organization Name',
                        hint: 'e.g. ABC Medical Organization',
                        controller: notifier.organizationCodeController,
                      ),
                      height(Responsive.h(12)),
                      CustomTextField(
                        label: 'Where did you hear about us?',
                        hint: 'e.g. Webinar',
                        controller: notifier.associateCodeController,
                      ),
                      height(Responsive.h(20)),
                      const _SectionHeader(title: 'SET YOUR PASSWORD'),
                      height(Responsive.h(12)),
                      CustomTextField(
                        label: 'Password',
                        hint: 'At least 8 characters',
                        controller: notifier.passwordController,
                        obscureText: !state.isPasswordVisible,
                        isRequired: true,
                        suffixIcon: IconButton(
                          onPressed: notifier.togglePasswordVisibility,
                          icon: Icon(
                            state.isPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                      if (state.password.isNotEmpty) ...[
                        height(Responsive.h(6)),
                        _buildPasswordStrengthBar(ref),
                      ],
                      height(Responsive.h(12)),
                      CustomTextField(
                        label: 'Confirm password',
                        hint: 'Re-enter password',
                        controller: notifier.confirmPasswordController,
                        obscureText: !state.isConfirmPasswordVisible,
                        isRequired: true,
                        suffixIcon: IconButton(
                          onPressed: notifier.toggleConfirmPasswordVisibility,
                          icon: Icon(
                            state.isConfirmPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                      height(Responsive.h(20)),
                      _SimpleCaptchaField(
                        key: ValueKey(state.captchaNonce),
                        onVerified: notifier.setCaptchaToken,
                      ),
                      height(Responsive.h(16)),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Checkbox(
                              value: state.agreeTerms,
                              onChanged: (val) =>
                                  notifier.setAgreeTerms(val ?? false),
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
                        onPressed: isLoading
                            ? null
                            : () => _onSignUpPressed(context, ref),
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
    _generateChallenge();
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
    setState(_generateChallenge);
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
