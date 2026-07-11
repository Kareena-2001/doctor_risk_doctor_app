import 'dart:async';
import 'package:Doctors_App/features/common/ui/widgets/common_back_button.dart';
import 'package:Doctors_App/features/common/ui/widgets/common_background.dart';
import 'package:Doctors_App/features/forgot_password/ui/view_model/forgot_password_view_model.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constants/dimensions.dart';
import '../../../../../core/constants/values/app_text_style.dart';
import '../../../../../extensions/build_context_extension.dart';
import '../../../core/constants/responsive.dart';
import '../../../routing/routes.dart';
import '../../common/ui/widgets/primary_button.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String email;

  const OtpScreen({super.key, required this.email});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  bool _isExpired = false;

  static const int _totalSeconds = 120; // 2 minutes
  int _remainingSeconds = _totalSeconds;
  Timer? _timer;

  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final controller in _otpControllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _remainingSeconds = _totalSeconds;
      _isExpired = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds == 0) {
        timer.cancel();
        setState(() => _isExpired = true);
      } else {
        setState(() => _remainingSeconds--);
      }
    });
  }

  void _resendOtp() {
    for (final controller in _otpControllers) {
      controller.clear();
    }
    _focusNodes[0].requestFocus();
    _startTimer();

    ref
        .read(forgotPasswordViewModelProvider.notifier)
        .forgotPassword(widget.email);
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  String _getOtp() {
    return _otpControllers.map((e) => e.text).join();
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    ref.listen(forgotPasswordViewModelProvider, (prev, next) {
      next.whenOrNull(
        data: (state) {
          // if (state.otpResp != null) {
          //   context.push(
          //     Routes.createNewPassword,
          //     extra: state.otpResp!.data.userid.toString(),
          //   );
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Text(
                'Verify Code',
                style: customTextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              Text(
                'Please enter the code we just sent to your email ${widget.email}',
                style: customTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
              height(24),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: _isExpired
                        ? Colors.red.withValues(alpha: 0.1)
                        : AppColors.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _isExpired
                          ? Colors.red.withValues(alpha: 0.4)
                          : AppColors.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        size: 16,
                        color: _isExpired ? Colors.red : AppColors.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _isExpired
                            ? 'OTP Expired'
                            : 'Expires in ${_formatTime(_remainingSeconds)}',
                        style: customTextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: _isExpired ? Colors.red : AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              height(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                  (index) => Container(
                    height: Responsive.h(65),
                    width: Responsive.h(65),
                    decoration: BoxDecoration(
                      color: _isExpired
                          ? Colors.grey.withValues(alpha: 0.3)
                          : const Color(0xffF0F0F0),
                      border: Border.all(
                        color: _isExpired
                            ? Colors.red.withValues(alpha: 0.5)
                            : const Color(0xFFE8E8E8),
                      ),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      controller: _otpControllers[index],
                      focusNode: _focusNodes[index],
                      onChanged: (value) {
                        if (value.length == 1 && index < 3) {
                          _focusNodes[index + 1].requestFocus();
                        } else if (value.isEmpty && index > 0) {
                          _focusNodes[index - 1].requestFocus();
                        }
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "",
                      ),
                      style: customTextStyle(
                        fontSize: 16,
                        color: _isExpired
                            ? Colors.grey
                            : const Color(0xFF767676),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      enabled: !_isExpired,
                    ),
                  ),
                ),
              ),
              height(40),
              PrimaryButton(
                text: 'Verify',
                backgroundColor: _isExpired ? Colors.grey : AppColors.red,
                onPressed: (asyncState.isLoading || _isExpired)
                    ? null
                    : () {
                        // final otp = _getOtp();
                        // if (otp.length != 4) {
                        //   context.showWarningSnackBar("Enter valid OTP");
                        //   return;
                        // }
                        // ref
                        //     .read(forgotPasswordViewModelProvider.notifier)
                        //     .otpVerification(otp);

                        context.push(Routes.createNewPassword);
                      },
                borderRadius: 50,
              ),
              height(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive code? ",
                    style: customTextStyle(fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: (asyncState.isLoading || !_isExpired)
                        ? null
                        : _resendOtp,
                    child: Text(
                      'Resend Code',
                      style:
                          customTextStyle(
                            fontWeight: FontWeight.w500,
                            // Grey out resend while OTP is still valid & not expired
                            color: (!_isExpired && _remainingSeconds > 0)
                                ? Colors.grey
                                : AppColors.red,
                          ).copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor:
                                (!_isExpired && _remainingSeconds > 0)
                                ? Colors.grey
                                : AppColors.red,
                          ),
                    ),
                  ),
                ],
              ),
              if (!_isExpired)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      'Resend available after OTP expires',
                      style: customTextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ),
                ),

              height(60),
            ],
          ),
        ),
      ),
    );
  }
}
