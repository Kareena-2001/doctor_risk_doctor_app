import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/core/widgets/custom_text_field.dart';
import 'package:Doctors_App/features/change_password/ui/view_model/change_password_view_model.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/dimensions.dart';
import '../../../extensions/build_context_extension.dart';
import '../../common/ui/widgets/primary_button.dart';
import '../model/change_password_model.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final formKey = GlobalKey<FormState>();

  bool isOldPasswordVisible = false;
  bool isNewPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  final TextEditingController oldPasswordController = TextEditingController();

  final TextEditingController newPasswordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> _handleUpdate() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    final success = await ref
        .read(changePasswordViewModelProvider.notifier)
        .changePassword(
          ChangePasswordRequest(
            oldPassword: oldPasswordController.text.trim(),
            newPassword: newPasswordController.text.trim(),
            confirmPassword: confirmPasswordController.text.trim(),
          ),
        );

    if (!mounted) return;

    if (success) {
      context.showSuccessSnackBar("Password Changed successfully!");
      Navigator.pop(context, true);
    } else {
      final error = ref
          .read(changePasswordViewModelProvider)
          .valueOrNull
          ?.errorMessage;

      if (error != null) {
        context.showErrorSnackBar(error);
      }
    }
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(changePasswordViewModelProvider);

    final isLoading = asyncState.valueOrNull?.isLoading ?? false;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Change Password',
        showBack: true,
        subTitle: 'Choose a new password with at least 8 characters.',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextField(
                  label: 'Old Password',
                  hint: 'Enter your old password',
                  controller: oldPasswordController,
                  obscureText: !isOldPasswordVisible,
                  keyboardType: TextInputType.visiblePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isOldPasswordVisible = !isOldPasswordVisible;
                      });
                    },
                    icon: Icon(
                      isOldPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: const Color(0xff909090),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your old password';
                    }

                    return null;
                  },
                ),
                height(20),
                CustomTextField(
                  hint: 'Enter new password (minimum 8 characters)',
                  label: 'New Password',
                  controller: newPasswordController,
                  obscureText: !isNewPasswordVisible,
                  keyboardType: TextInputType.visiblePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isNewPasswordVisible = !isNewPasswordVisible;
                      });
                    },
                    icon: Icon(
                      isNewPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: const Color(0xff909090),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your new password';
                    }

                    if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    }

                    return null;
                  },
                ),
                height(20),
                CustomTextField(
                  label: 'Confirm New Password',
                  hint: 'Re-enter your new password',
                  controller: confirmPasswordController,
                  obscureText: !isConfirmPasswordVisible,
                  keyboardType: TextInputType.visiblePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isConfirmPasswordVisible = !isConfirmPasswordVisible;
                      });
                    },
                    icon: Icon(
                      isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: const Color(0xff909090),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please confirm your password';
                    }

                    if (value != newPasswordController.text) {
                      return 'Passwords do not match';
                    }

                    return null;
                  },
                ),
                height(40),
                PrimaryButton(
                  borderRadius: 25,
                  height: 50,
                  fontSize: 14,
                  text: 'Update Password',
                  isLoading: isLoading,
                  onPressed: isLoading ? null : _handleUpdate,
                  gradient: LinearGradient(
                    colors: [AppColors.newPri, AppColors.primary],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
