import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/core/widgets/custom_text_field.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/home/ui/widgets/social_link_widget.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/values/app_text_style.dart';
import '../../../routing/routes.dart';

class SourceDetailsView extends StatefulWidget {
  const SourceDetailsView({super.key});

  @override
  State<SourceDetailsView> createState() => _SourceDetailsViewState();
}

class _SourceDetailsViewState extends State<SourceDetailsView> {
  final _orgCtrl = TextEditingController();
  final _codeCtrl = TextEditingController();

  @override
  void dispose() {
    _orgCtrl.dispose();
    _codeCtrl.dispose();
    super.dispose();
  }

  void _proceed() {
    context.push(
      Routes.planCategory,
      extra: {
        'orgName': _orgCtrl.text.trim().isEmpty ? null : _orgCtrl.text.trim(),
        'staffCode': _codeCtrl.text.trim().isEmpty
            ? null
            : _codeCtrl.text.trim(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFF8FAFC),
      appBar: CustomAppBar(title: 'Browse Plans'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              // border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECFDF5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.home_work_outlined,
                        color: AppColors.newPri,
                        size: 20,
                      ),
                    ),
                    width(12),
                    Text(
                      'Enter Source Details',
                      style: customTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textColor,
                      ),
                    ),
                  ],
                ),
                height(20),
                LayoutBuilder(
                  builder: (context, c) {
                    final narrow = c.maxWidth < 520;
                    final orgField = CustomTextField(
                      label: 'Enter your organisation name',
                      hint: 'e.g. OrthoSquare',
                      controller: _orgCtrl,
                    );
                    final codeField = CustomTextField(
                      label: 'Enter your staff or associate code',
                      hint: 'If referred by a staff member',
                      controller: _codeCtrl,
                    );
                    if (narrow) {
                      return Column(
                        children: [orgField, height(14), codeField],
                      );
                    }
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: orgField),
                        width(16),
                        Expanded(child: codeField),
                      ],
                    );
                  },
                ),
                height(16),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.blueberry10),
                    color: Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.info_outline_rounded,
                        size: 16,
                        color: AppColors.cardBlue,
                      ),
                      width(8),
                      Expanded(
                        child: Text(
                          "Both fields are optional. Once you proceed, your "
                          "organisation is locked to your account — to change "
                          "it later, you'll need to contact Support or raise "
                          "a ticket.",
                          style: customTextStyle(
                            fontSize: 12,
                            color: AppColors.textColor,
                          ).copyWith(height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),
                height(20),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 160,
                    child: PrimaryButton(
                      height: 44,
                      borderRadius: 25,
                      fontSize: 14,
                      text: 'Proceed',
                      gradient: LinearGradient(
                        colors: [AppColors.newPri, AppColors.primary],
                      ),
                      onPressed: _proceed,
                    ),
                  ),
                ),
                SocialLinkWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;

  const _LabeledField({
    required this.label,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: customTextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF475569),
          ),
        ),
        height(6),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: customTextStyle(
              color: const Color(0xFFCBD5E1),
              fontSize: 13,
            ),
            filled: true,
            fillColor: const Color(0xFFF8F9FC),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFF6366F1),
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
