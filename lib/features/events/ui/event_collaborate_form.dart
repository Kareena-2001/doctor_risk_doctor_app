import 'package:Doctors_App/core/widgets/custom_text_field.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/dimensions.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../theme/app_colors.dart';

class EventCollaborateScreen extends StatefulWidget {
  final Map<String, String> event;

  const EventCollaborateScreen({super.key, required this.event});

  @override
  State<EventCollaborateScreen> createState() => _EventCollaborateScreenState();
}

class _EventCollaborateScreenState extends State<EventCollaborateScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form Field Tracking Controllers
  final _nameController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _purposeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _purposeController.dispose();
    super.dispose();
  }

  void _submitCollaboration() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Collaboration proposal submitted successfully!',
            style: customTextStyle(color: Colors.white, fontSize: 14),
          ),
          backgroundColor: AppColors.primary,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      appBar: const CustomAppBar(title: "Collaborate Proposal"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Responsive.w(16)),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildContextSummaryCard(),
                height(Responsive.h(24)),
                Text(
                  "Collaboration Details",
                  style: customTextStyle(
                    fontSize: Responsive.sp(14),
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                height(Responsive.h(12)),

                // 1. Name Input Field
                CustomTextField(
                  label: "Full Name / Organization",
                  controller: _nameController,
                  icon: Icons.business_center_outlined,
                  validator: (val) =>
                  val!.isEmpty ? 'Please enter your name or firm' : null,
                ),
                height(Responsive.h(16)),

                // 2. City Input Field
                CustomTextField(
                  label: "City",
                  controller: _cityController,
                  icon: Icons.location_city_rounded,
                  validator: (val) =>
                  val!.isEmpty ? 'Please enter operating city' : null,
                ),
                height(Responsive.h(16)),

                // 3. State Input Field
                CustomTextField(
                  label: "State",
                  controller: _stateController,
                  icon: Icons.map_outlined,
                  validator: (val) =>
                  val!.isEmpty ? 'Please enter operating state' : null,
                ),
                height(Responsive.h(16)),

                // 4. Purpose / Proposal Statement
                CustomTextField(
                  label: "Purpose of Collaboration",
                  controller: _purposeController,
                  icon: Icons.handshake_outlined,
                  maxLines: 4,
                  validator: (val) =>
                  val!.isEmpty ? 'Please specify your collaboration intent' : null,
                ),
                height(Responsive.h(32)),

                // 5. Submit Event Trigger
                PrimaryButton(
                  text: "Submit Proposal",
                  backgroundColor: AppColors.newPri,
                  onPressed: _submitCollaboration,
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

  Widget _buildContextSummaryCard() {
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
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.w(8),
                  vertical: Responsive.h(4),
                ),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(Responsive.w(6)),
                ),
                child: Text(
                  "COLLABORATION TARGET",
                  style: customTextStyle(
                    fontSize: Responsive.sp(9),
                    fontWeight: FontWeight.bold,
                    color: Colors.amber.shade800,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                widget.event['type'] ?? '',
                style: customTextStyle(
                  fontSize: Responsive.sp(11),
                  fontWeight: FontWeight.w600,
                  color: AppColors.homeTextMuted,
                ),
              ),
            ],
          ),
          height(Responsive.h(10)),
          Text(
            widget.event['title'] ?? 'Selected Initiative',
            style: customTextStyle(
              fontSize: Responsive.sp(14),
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      maxLines: maxLines,
      style: customTextStyle(fontSize: 14, color: AppColors.textColor),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: customTextStyle(
          fontSize: 13,
          color: AppColors.homeTextMuted,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.only(bottom: maxLines > 1 ? Responsive.h(40) : 0),
          child: Icon(icon, color: AppColors.homeTextMuted, size: 20),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          vertical: Responsive.h(14),
          horizontal: Responsive.w(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Responsive.w(12)),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Responsive.w(12)),
          borderSide: BorderSide(color: AppColors.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Responsive.w(12)),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Responsive.w(12)),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
        ),
      ),
    );
  }
}