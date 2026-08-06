import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/responsive.dart';

class OnboardingWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subTitle;

  const OnboardingWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.w(24),
        vertical: Responsive.h(16),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: Responsive.h(10)),
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: customTextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: Responsive.sp(22),
                    fontWeight: FontWeight.w700,
                    color: AppColors.textColor,
                  ),
                ),
                height(Responsive.h(12)),
                Text(
                  subTitle,
                  textAlign: TextAlign.center,
                  style: customTextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: Responsive.sp(14),
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[700],
                  ).copyWith(height: 1.4),
                ),
              ],
            ),
          ),
          height(Responsive.h(24)),
          Expanded(child: Image.asset(imagePath, fit: BoxFit.contain)),
          height(Responsive.h(30)),
          Container(
            padding: EdgeInsets.all(Responsive.w(14)),
            decoration: BoxDecoration(
              color: const Color(0xffF0F6FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: _StatColumn(number: "20+", label: "Years Exp."),
                ),
                Expanded(
                  child: _StatColumn(
                    number: "18,000+",
                    label: "Doctors Protected",
                  ),
                ),
                Expanded(
                  child: _StatColumn(
                    number: "15,000+",
                    label: "Cases Resolved",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String number;
  final String label;

  const _StatColumn({required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: customTextStyle(
            fontSize: Responsive.sp(20),
            fontWeight: FontWeight.w800,
            color: const Color(0xff0A5EB0),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: customTextStyle(
            fontSize: Responsive.sp(11),
            color: const Color(0xff1A1C1E),
          ),
        ),
      ],
    );
  }
}
