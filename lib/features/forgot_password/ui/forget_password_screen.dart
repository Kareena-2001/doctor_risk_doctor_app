import 'package:Doctors_App/features/forgot_password/ui/view_model/forgot_password_view_model.dart';
import 'package:Doctors_App/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constants/dimensions.dart';
import '../../../../../core/constants/values/app_text_style.dart';
import '../../../../../extensions/build_context_extension.dart';
import '../../../../../utils/validator.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../theme/app_colors.dart';
import '../../common/ui/widgets/common_back_button.dart';
import '../../common/ui/widgets/common_background.dart';
import '../../common/ui/widgets/primary_button.dart';

class ForgetPasswordScreen extends ConsumerStatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  ConsumerState<ForgetPasswordScreen> createState() =>
      _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends ConsumerState<ForgetPasswordScreen> {
  late final TextEditingController _emailController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(forgotPasswordViewModelProvider, (prev, next) {
      next.whenOrNull(
        data: (state) {
          // if (state.forgotPassResp != null) {
          //   context.push(Routes.otpDetail, extra: _emailController.text.trim());
          // }
        },
        error: (e, _) {
          context.showErrorSnackBar(e.toString());
        },
      );
    });

    return Scaffold(
      backgroundColor: context.secondaryBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [CommonBackground(), _buildForm(), CommonBackButton()],
        ),
      ),
    );
  }

  Widget _buildForm() {
    final asyncState = ref.watch(forgotPasswordViewModelProvider);
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              height(100),
              Text(
                'Forgot Password?',
                style: customTextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              Text(
                'Please enter your email address',
                style: customTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
              height(50),
              CustomTextField(
                label: 'Email Id',
                hint: 'enter email id',
                controller: _emailController,
                validator: notEmptyEmailValidator,
                isRequired: true,
              ),
              height(40),
              PrimaryButton(
                text: 'Continue',
                backgroundColor: AppColors.red,
                onPressed: asyncState.isLoading ? null : _forgotPassword,
                borderRadius: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _forgotPassword() {
    // if (_formKey.currentState?.validate() ?? false) {
    //   ref
    //       .read(forgotPasswordViewModelProvider.notifier)
    //       .forgotPassword(_emailController.text.trim());
    // }
    context.push(Routes.otpVerification, extra: _emailController.text);
  }
}
