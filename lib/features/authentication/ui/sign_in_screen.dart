import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/features/authentication/ui/view_model/authentication_view_model.dart';
import 'package:Doctors_App/features/authentication/ui/widgets/header_clipper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/assets.dart';
import '../../../core/exceptions/exception_extension.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../extensions/build_context_extension.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../routing/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/validator.dart';
import '../../common/ui/widgets/primary_button.dart';
import '../../fcm/device_service.dart';
import '../../fcm/notification_service.dart';
import '../repository/authentication_repository.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final DeviceService deviceService = DeviceService();

  late final TextEditingController _mobileNoController;
  late final TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  String? fcmToken;
  String? deviceId;

  @override
  void initState() {
    super.initState();
    _getDeviceToken();
    _mobileNoController = TextEditingController();
    _passwordController = TextEditingController();
    _loadSavedCredentials();
  }

  Future<void> _getDeviceToken() async {
    final notificationService = ref.read(notificationServiceProvider);
    fcmToken = await notificationService.getDeviceToken();
    deviceId = await DeviceService.getDeviceId();

    debugPrint('FCM token is: $fcmToken');
    debugPrint('device Id is  : $deviceId ');
  }

  Future<void> _loadSavedCredentials() async {
    final repo = ref.read(authenticationRepositoryProvider);
    final savedCredentials = await repo.getSavedCredentials();

    if (savedCredentials != null && mounted) {
      setState(() {
        _mobileNoController.text = savedCredentials.mobile;
        _passwordController.text = savedCredentials.password;
        _rememberMe = true;
      });
    }
  }

  @override
  void dispose() {
    _mobileNoController.dispose();
    _passwordController.dispose();
    super.dispose();
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

            if (applicationStatus == 'Pending' || applicationStatus == null) {
              context.go(Routes.employeeOnboarding);
            } else if (applicationStatus == 'Accept') {
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
              Container(
                // color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Sign In',
                            style: customTextStyle(
                              fontSize: Responsive.sp(25),
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        height(32),
                        CustomTextField(
                          label: 'Email Address',
                          hint: 'Enter email address',
                          controller: _mobileNoController,
                          validator: notEmptyPhoneValidator,
                          isRequired: true,
                          maxLength: 10,
                        ),
                        height(12),
                        CustomTextField(
                          label: 'Password',
                          hint: 'Enter password',
                          controller: _passwordController,
                          isRequired: true,
                          obscureText: !_isPasswordVisible,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: AppColors.primary,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return LocaleKeys.validator_required_field.tr();
                            }
                            return null;
                          },
                        ),
                        height(8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: _rememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      _rememberMe = value ?? false;
                                    });
                                  },
                                  activeColor: AppColors.primary,
                                ),
                                Text(
                                  'Remember Me',
                                  style: AppTheme.label12.copyWith(
                                    color: AppColors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                context.push(Routes.forgotPassword);
                              },
                              child: Text(
                                'Forgot Password?',
                                style: AppTheme.label12.copyWith(
                                  color: AppColors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                        height(24),
                        PrimaryButton(
                          text: 'Login',
                          isLoading: authState.isLoading,
                          onPressed: authState.isLoading ? null : _login,
                        ),
                        height(32),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      context.push(Routes.register);
                    },
                    child: Text(
                      "Sign Up",
                      style: customTextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ).copyWith(decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              height(40),
            ],
          ),
        ),
      ),
    );
  }

  void _login() {
    context.push(Routes.main);
    //   if (_formKey.currentState?.validate() ?? false) {
    //     ref
    //         .read(authenticationViewModelProvider.notifier)
    //         .login(
    //           mobile: _mobileNoController.text.trim(),
    //           password: _passwordController.text.trim(),
    //           fcmToken: fcmToken ?? '',
    //           deviceId: deviceId ?? '',
    //           platform: PlatformUtils.platform,
    //           rememberMe: _rememberMe,
    //         );
    //   }
  }
}
