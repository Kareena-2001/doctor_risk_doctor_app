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

  // Controllers for the input fields
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _licenceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _licenceController.dispose();
    super.dispose();
  }

  void _submitRegistration() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Successfully registered for ${widget.event['title']}!',
            style: customTextStyle(color: Colors.white, fontSize: 14),
          ),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
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
                Text(
                  "Enter Attendee Details",
                  style: customTextStyle(
                    fontSize: Responsive.sp(14),
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                height(Responsive.h(12)),
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
                height(Responsive.h(16)),
                CustomTextField(
                  label: "Medical Licence Number (Optional)",
                  controller: _licenceController,
                  icon: Icons.badge_outlined,
                ),
                height(Responsive.h(32)),
                PrimaryButton(
                  text: "Confirm Registration",
                  backgroundColor: AppColors.newPri,
                  onPressed: _submitRegistration,
                  fontSize: 14,
                  height: 48,
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(Responsive.w(16)),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.w(8),
              vertical: Responsive.h(4),
            ),
            decoration: BoxDecoration(
              color: AppColors.newPri.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(Responsive.w(6)),
            ),
            child: Text(
              // Changed ! to ?? ''
              widget.event['speciality'] ?? 'General',
              style: customTextStyle(
                fontSize: Responsive.sp(10),
                fontWeight: FontWeight.bold,
                color: AppColors.newPri,
              ),
            ),
          ),
          height(Responsive.h(8)),
          Text(
            // Changed ! to ?? 'Event'
            widget.event['title'] ?? 'Unnamed Event',
            style: customTextStyle(
              fontSize: Responsive.sp(14),
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          height(Responsive.h(12)),
          Row(
            children: [
              Icon(
                Icons.calendar_today_rounded,
                size: 14,
                color: AppColors.homeTextMuted,
              ),
              width(4),
              Text(
                "${widget.event['day'] ?? ''} ${widget.event['month'] ?? ''}",
                style: customTextStyle(
                  fontSize: 12,
                  color: AppColors.homeTextMuted,
                ),
              ),
              width(16),
              Icon(
                Icons.access_time_rounded,
                size: 14,
                color: AppColors.homeTextMuted,
              ),
              width(4),
              Text(
                // Changed ! to ?? ''
                widget.event['time'] ?? '',
                style: customTextStyle(
                  fontSize: 12,
                  color: AppColors.homeTextMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
