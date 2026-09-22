import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/dimensions.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../theme/app_colors.dart';

class EventRegisterScreen extends StatefulWidget {
  final Map<String, String> event;

  const EventRegisterScreen({super.key, required this.event});

  @override
  State<EventRegisterScreen> createState() => _EventRegisterScreenState();
}

class _EventRegisterScreenState extends State<EventRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _memberIdController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _licenceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _memberIdController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _licenceController.dispose();
    super.dispose();
  }

  void _submitRegistration() {
    if (_formKey.currentState!.validate()) {
      context.showSuccessSnackBar(
        'Successfully registered for ${widget.event['title']}!',
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.primaryBackgroundColor,
      appBar: const CustomAppBar(title: "Event Registration"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Responsive.w(16)),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildEventSummaryCard(),
                height(Responsive.h(24)),
                CustomTextField(
                  label: "Member Id",
                  controller: _memberIdController,
                  icon: Icons.person_outline_rounded,
                ),
                height(Responsive.h(16)),
                CustomTextField(
                  label: "Full Name",
                  controller: _nameController,
                  icon: Icons.person_outline_rounded,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter your name' : null,
                ),
                height(Responsive.h(16)),
                CustomTextField(
                  label: "Email Address",
                  controller: _emailController,
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val!.isEmpty) return 'Please enter your email';
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(val)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                height(Responsive.h(16)),
                CustomTextField(
                  label: "Mobile Number",
                  controller: _phoneController,
                  icon: Icons.phone_android_outlined,
                  keyboardType: TextInputType.phone,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter mobile number' : null,
                ),
                height(Responsive.h(32)),
                // CustomTextField(
                //   label: "Medical Licence Number (Optional)",
                //   controller: _licenceController,
                //   icon: Icons.badge_outlined,
                // ),
                // height(Responsive.h(32)),
                PrimaryButton(
                  borderRadius: 25,
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.newPri],
                  ),
                  fontSize: 14,
                  height: 48,
                  text: "Confirm Registration",
                  backgroundColor: AppColors.newPri,
                  onPressed: _submitRegistration,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEventSummaryCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.w(16)),
      decoration: BoxDecoration(
        color:context.secondaryWidgetColor,
        borderRadius: BorderRadius.circular(Responsive.w(16)),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.event['title'] ?? 'Unnamed Event',
            style: customTextStyle(
              fontSize: Responsive.sp(14),
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          height(Responsive.h(12)),
          Wrap(
            spacing: Responsive.w(12),
            runSpacing: Responsive.h(6),
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    size: Responsive.sp(14),
                    color: AppColors.homeTextMuted,
                  ),
                  width(Responsive.w(4)),
                  Text(
                    '22 Aug 2026',
                    style: customTextStyle(
                      fontSize: Responsive.sp(11),
                      color: AppColors.homeTextMuted,
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    size: Responsive.sp(14),
                    color: AppColors.homeTextMuted,
                  ),
                  width(Responsive.w(4)),
                  Text(
                    ' 6:30 PM IST',
                    style: customTextStyle(
                      fontSize: Responsive.sp(11),
                      color: AppColors.homeTextMuted,
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.event['type'] == 'Online'
                        ? Icons.videocam_outlined
                        : Icons.location_on_outlined,
                    size: Responsive.sp(14),
                    color: AppColors.homeTextMuted,
                  ),
                  width(Responsive.w(4)),
                  Text(
                    widget.event['type'] ?? '',
                    style: customTextStyle(
                      fontSize: Responsive.sp(11),
                      color: AppColors.homeTextMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
