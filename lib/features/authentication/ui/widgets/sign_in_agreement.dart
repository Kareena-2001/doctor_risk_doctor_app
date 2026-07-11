import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/languages.dart';
import '../../../../core/constants/values/app_constants.dart';
import '/extensions/build_context_extension.dart';
import '/theme/app_theme.dart';

class SignInAgreement extends StatelessWidget {
  const SignInAgreement({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: AppTheme.body12.copyWith(color: context.secondaryTextColor),
            children: [
              TextSpan(text: '${Languages.signInAgreementPrefix} '),
              TextSpan(
                text: Languages.termOfService,
                style: AppTheme.title12,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    context.tryLaunchUrl(AppConstants.termOfService);
                  },
              ),
              TextSpan(text: ' ${Languages.signInAgreementMiddle} '),
              TextSpan(
                text: Languages.privacyPolicy,
                style: AppTheme.title12,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    context.tryLaunchUrl(AppConstants.privacyPolicy);
                  },
              ),
              TextSpan(text: ' ${Languages.signInAgreementSuffix}'),
            ],
          ),
        ),
      ),
    );
  }
}
