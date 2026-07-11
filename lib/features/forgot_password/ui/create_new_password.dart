import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/custom_text_field.dart';
import 'package:Doctors_App/features/common/ui/widgets/common_background.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/forgot_password/ui/view_model/forgot_password_view_model.dart';
import 'package:Doctors_App/routing/routes.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../extensions/build_context_extension.dart';
import '../../common/ui/widgets/common_back_button.dart';

class CreateNewPassword extends ConsumerStatefulWidget {
  final String id;

  const CreateNewPassword({super.key, required this.id});

  @override
  ConsumerState<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends ConsumerState<CreateNewPassword> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green,
                  size: 50,
                ),
              ),
              height(20),
              Text(
                'Password Reset\nSuccessful!',
                textAlign: TextAlign.center,
                style: customTextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              height(10),
              Text(
                'Your password has been updated successfully.\nPlease log in with your new password.',
                textAlign: TextAlign.center,
                style: customTextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primary,
                ),
              ),
              height(28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    context.go(Routes.login);
                  },
                  child: Text(
                    'Go to Login',
                    style: customTextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(forgotPasswordViewModelProvider);

    ref.listen(forgotPasswordViewModelProvider, (prev, next) {
      next.whenOrNull(
        data: (state) {
          // if (state.newPassResp != null) {
          //   _showSuccessDialog();
          // }
        },
        error: (e, _) {
          context.showErrorSnackBar(e.toString());
        },
      );
    });

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            CommonBackground(),
            _buildForm(asyncState),
            CommonBackButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(AsyncValue asyncState) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 50,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(48)),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                height(100),
                Text(
                  'Create New Password',
                  style: customTextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  'Please enter your new password',
                  style: customTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),
                height(50),
                CustomTextField(
                  label: 'New Password',
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () => setState(
                      () => _isPasswordVisible = !_isPasswordVisible,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password required";
                    }
                    if (value.length < 6) return "Minimum 6 characters";
                    return null;
                  },
                ),
                height(15),
                CustomTextField(
                  label: 'Confirm Password',
                  controller: _confirmPasswordController,
                  obscureText: !_isConfirmPasswordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () => setState(
                      () => _isConfirmPasswordVisible =
                          !_isConfirmPasswordVisible,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Confirm password required";
                    }
                    if (value != _passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
                height(40),
                PrimaryButton(
                  text: "Continue",
                  backgroundColor: AppColors.red,
                  onPressed: asyncState.isLoading ? null : _resetPassword,
                  borderRadius: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _resetPassword() {
    context.push(Routes.login);
    // if (formKey.currentState?.validate() ?? false) {
    //   ref
    //       .read(forgotPasswordViewModelProvider.notifier)
    //       .createNewPassword(widget.id, _passwordController.text.trim());
    // }
  }
}
