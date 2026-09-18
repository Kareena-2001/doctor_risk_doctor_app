import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/features/change_password/ui/view_model/change_password_view_model.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/dimensions.dart';
import '../../../extensions/build_context_extension.dart';
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
  Widget build(BuildContext context) {
    final asyncState = ref.watch(changePasswordViewModelProvider);
    final isLoading = asyncState.valueOrNull?.isLoading ?? false;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Change Password', showBack: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                height(50),
                _buildPasswordField(
                  label: "Old Password",
                  controller: oldPasswordController,
                  isVisible: isOldPasswordVisible,
                ),
                height(20),
                _buildPasswordField(
                  label: "New Password",
                  controller: newPasswordController,
                  isVisible: isNewPasswordVisible,
                  isNewPassword: true,
                ),
                height(20),
                _buildPasswordField(
                  label: "Confirm New Password",
                  controller: confirmPasswordController,
                  isVisible: isConfirmPasswordVisible,
                  isConfirmPassword: true,
                ),
                height(40),
                Material(
                  child: Container(
                    width: double.infinity * 0.911,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.5),
                      ),
                    ),
                    child: TextButton(
                      onPressed: isLoading ? null : () => _handleUpdate(),
                      child: Text(
                        "Update Password",
                        style: customTextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool isVisible,
    bool isNewPassword = false,
    bool isConfirmPassword = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: !isVisible,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 30),
        labelText: label,
        labelStyle: customTextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        errorStyle: customTextStyle(color: Colors.redAccent),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xff8C8C8C), width: 2),
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              if (label == "Old Password") {
                isOldPasswordVisible = !isOldPasswordVisible;
              } else if (label == "New Password") {
                isNewPasswordVisible = !isNewPasswordVisible;
              } else {
                isConfirmPasswordVisible = !isConfirmPasswordVisible;
              }
            });
          },
          child: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: const Color(0xff909090),
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return isConfirmPassword
              ? "Please confirm your password"
              : "Please enter your password";
        }
        if (isNewPassword && value.length < 6) {
          return "Password must be at least 6 characters long";
        }
        // if (isNewPassword && !RegExp(r'\d').hasMatch(value)) {
        //   return "Password must contain at least one digit";
        // }
        if (isConfirmPassword && value != newPasswordController.text) {
          return "Passwords do not match";
        }
        return null;
      },
    );
  }
}
