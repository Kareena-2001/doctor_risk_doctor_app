import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/features/authentication/ui/view_model/authentication_view_model.dart';
import 'package:Doctors_App/features/home/ui/widgets/social_link_widget.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/exceptions/exception_extension.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../extensions/build_context_extension.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../routing/routes.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/validator.dart';
import '../../common/ui/widgets/primary_button.dart';
import '../../fcm/device_service.dart';
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

  bool _isSignInTab = true;

  String? fcmToken;
  String? deviceId;

  static const Color accentGreen = Color(0xFF16A34A);
  static const Color cardBg = Color(0xFFF1F5F9);

  @override
  void initState() {
    super.initState();
    _getDeviceToken();
    _mobileNoController = TextEditingController();
    _passwordController = TextEditingController();
    _loadSavedCredentials();
  }

  Future<void> _getDeviceToken() async {
    deviceId = await DeviceService.getDeviceId();
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
              context.go(Routes.main);
            } else if (applicationStatus == 'Accept') {
              context.go(Routes.main);
            } else {
              context.go(Routes.main);
            }
          }
        },
        error: (e, _) {
          context.showWarningSnackBar(e.readableMessage);
        },
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.w(24),
                  vertical: Responsive.h(24),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.newPri, AppColors.primary],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/login_logo.png',
                              height: Responsive.h(24),
                              fit: BoxFit.contain,
                            ),
                            width(8),
                            Text(
                              'DOCTORS RISK',
                              style: customTextStyle(
                                fontSize: Responsive.sp(14),
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      ' Medico‑Legal Services · Est. 2005',
                      style: customTextStyle(
                        fontSize: Responsive.sp(12),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    height(Responsive.h(16)),
                    Text(
                      'One login. Your entire\n professional life, protected.',
                      style: customTextStyle(
                        fontSize: Responsive.sp(16),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ).copyWith(height: 1.25),
                    ),
                    height(Responsive.h(14)),
                    Container(
                      padding: EdgeInsets.all(Responsive.w(10)),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.12),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Indemnity cover, medico‑legal defense, documents, community and expert guidance — inside a single ecosystem built for practising professionals',
                              style: customTextStyle(
                                fontSize: Responsive.sp(11),
                                color: Colors.white.withValues(alpha: 0.9),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              height(Responsive.h(20)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Responsive.w(24)),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isSignInTab = true;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: _isSignInTab
                                  ? Colors.white
                                  : AppColors.lightGreen,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: _isSignInTab
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.05,
                                        ),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Center(
                              child: Text(
                                'Sign in',
                                style: customTextStyle(
                                  color: _isSignInTab
                                      ? AppColors.newPri
                                      : const Color(0xFF64748B),
                                  fontWeight: _isSignInTab
                                      ? FontWeight.bold
                                      : FontWeight.w600,
                                  fontSize: Responsive.sp(13),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isSignInTab = false;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: !_isSignInTab
                                  ? Colors.white
                                  : AppColors.lightGreen,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: !_isSignInTab
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.05,
                                        ),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Center(
                              child: Text(
                                'Create account',
                                style: customTextStyle(
                                  color: !_isSignInTab
                                      ? AppColors.newPri
                                      : const Color(0xFF64748B),
                                  fontWeight: !_isSignInTab
                                      ? FontWeight.bold
                                      : FontWeight.w600,
                                  fontSize: Responsive.sp(13),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              height(Responsive.h(8)),
              _isSignInTab
                  ? _buildSignInForm(authState)
                  : _buildCreateAccountCard(),
              _buildEmergencyWidget(),
              height(Responsive.h(0)),
              SocialLinkWidget(),
              height(Responsive.h(24)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmergencyWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Responsive.w(24)),
      padding: EdgeInsets.symmetric(vertical: Responsive.h(16)),
      child: Column(
        children: [
          Text(
            'Doctors • Hospitals • Clinics • Allied Professionals',
            textAlign: TextAlign.center,
            style: customTextStyle(
              fontSize: Responsive.sp(11),
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
          ),
          height(Responsive.h(8)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.phone_in_talk_rounded,
                size: 14,
                color: Color(0xFFDC2626),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  'Need help? Call +91-8080099908 (24×7 Emergency)',
                  textAlign: TextAlign.center,
                  style: customTextStyle(
                    fontSize: Responsive.sp(11),
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF334155),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSignInForm(AsyncValue authState) {
    return Padding(
      padding: EdgeInsets.all(Responsive.sp(24)),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back, Doctor',
              style: customTextStyle(
                fontSize: Responsive.sp(22),
                fontWeight: FontWeight.w900,
                color: AppColors.textColor,
              ),
            ),
            height(Responsive.h(4)),
            Text(
              'Sign in to access your membership dashboard.',
              style: customTextStyle(
                fontSize: Responsive.sp(13),
                color: const Color(0xFF64748B),
              ),
            ),
            height(Responsive.h(24)),
            CustomTextField(
              label: 'Mobile or email ',
              hint: 'e.g. 98765 43210 or you@clinic.com',
              controller: _mobileNoController,
              validator: notEmptyPhoneValidator,
              isRequired: true,
            ),
            height(Responsive.h(16)),
            CustomTextField(
              label: 'Password',
              hint: 'Enter your password',
              controller: _passwordController,
              isRequired: true,
              obscureText: !_isPasswordVisible,
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: const Color(0xFF64748B),
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
            height(Responsive.h(8)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                        activeColor: accentGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Remember Me',
                      style: AppTheme.label12.copyWith(
                        color: const Color(0xFF475569),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    context.push(Routes.forgotPassword);
                  },
                  child: Text(
                    'Forgot password?',
                    style: AppTheme.label12.copyWith(
                      color: accentGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            height(Responsive.h(28)),
            PrimaryButton(
              fontSize: 14,
              borderRadius: 25,
              text: 'Sign In to Dashboard',
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.newPri],
              ),
              isLoading: authState.isLoading,
              onPressed: authState.isLoading ? null : _login,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateAccountCard() {
    return Padding(
      padding: EdgeInsets.all(Responsive.sp(24)),
      child: Container(
        padding: EdgeInsets.all(Responsive.w(20)),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'New to DoctorsRisk?',
              style: customTextStyle(
                fontSize: Responsive.sp(18),
                fontWeight: FontWeight.w700,
                color: AppColors.textColor,
              ),
            ),
            height(Responsive.h(8)),
            Text(
              'Registration takes about 3 minutes. We\'ll verify your medical registration before activating cover.',
              style: customTextStyle(
                fontSize: Responsive.sp(13),
                color: const Color(0xFF64748B),
              ).copyWith(height: 1.4),
            ),
            height(Responsive.h(20)),
            PrimaryButton(
              fontSize: 14,
              borderRadius: 25,
              text: 'Start Registration',
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.newPri],
              ),
              onPressed: () => context.push(Routes.register),
            ),
            height(Responsive.h(12)),
            Text(
              'Already mid‑registration? Your progress is saved automatically.',
              style: customTextStyle(
                fontSize: Responsive.sp(11),
                color: Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _login() {
    context.push(Routes.main);
  }
}
