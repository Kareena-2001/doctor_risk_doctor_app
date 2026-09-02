import 'package:Doctors_App/core/widgets/custom_dropdown_field.dart';
import 'package:Doctors_App/core/widgets/custom_text_field.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
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

  final _targetController = TextEditingController();
  final _nameController = TextEditingController();
  final _organisationController = TextEditingController();
  final _areaController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _purposeController = TextEditingController();

  @override
  void dispose() {
    _targetController.dispose();
    _nameController.dispose();
    _organisationController.dispose();
    _areaController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _purposeController.dispose();
    super.dispose();
  }

  void _submitCollaboration() {
    if (_formKey.currentState!.validate()) {
      context.showSuccessSnackBar(
        'Collaboration proposal submitted successfully!',
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      appBar: const CustomAppBar(title: 'Collaborate Proposal'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Responsive.w(16)),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildContextSummaryCard(),

              height(Responsive.h(24)),

              Text(
                'Collaboration Details',
                style: customTextStyle(
                  fontSize: Responsive.sp(14),
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),

              height(Responsive.h(12)),

              CustomDropdownField(
                label: 'Collaboration Target',
                controller: _targetController,
                items: [
                  'Host a Joint Webinar / CME',
                  'Workshop Partnership',
                  'Sponsor an Event',
                  'Speacker Exchange',
                  'Host a Joint Webinar / CME',
                  'Other',
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select collaboration target';
                  }
                  return null;
                },
              ),

              height(Responsive.h(16)),

              CustomTextField(
                label: 'Full Name',
                controller: _nameController,
                icon: Icons.person_outline_rounded,
                hint: 'Your full name',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),

              height(Responsive.h(16)),

              CustomTextField(
                label: 'Organisation',
                controller: _organisationController,
                icon: Icons.business_outlined,
                hint: 'Hospital / association / institute',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your organisation';
                  }
                  return null;
                },
              ),

              height(Responsive.h(16)),

              CustomTextField(
                label: 'Area',
                controller: _areaController,
                icon: Icons.location_on_outlined,
                hint: 'Locality',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your area';
                  }
                  return null;
                },
              ),

              height(Responsive.h(16)),

              CustomTextField(
                label: 'City',
                controller: _cityController,
                icon: Icons.location_city_outlined,
                hint: 'City',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your city';
                  }
                  return null;
                },
              ),
              height(Responsive.h(16)),

              CustomTextField(
                label: 'State',
                controller: _stateController,
                icon: Icons.map_outlined,
                hint: 'State',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your state';
                  }
                  return null;
                },
              ),

              height(Responsive.h(16)),

              CustomTextField(
                label: 'Purpose of Collaboration',
                controller: _purposeController,
                icon: Icons.handshake_outlined,
                hint: 'What would you like to organise, and why?',
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please specify your collaboration intent';
                  }
                  return null;
                },
              ),

              height(Responsive.h(32)),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(double.infinity, Responsive.h(48)),
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Responsive.w(12)),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: customTextStyle(
                          fontSize: Responsive.sp(14),
                          fontWeight: FontWeight.w600,
                          color: AppColors.textColor,
                        ),
                      ),
                    ),
                  ),

                  width(Responsive.w(12)),

                  Expanded(
                    child: PrimaryButton(
                      text: 'Submit Proposal',
                      backgroundColor: AppColors.newPri,
                      onPressed: _submitCollaboration,
                      fontSize: 14,
                      height: 48,
                    ),
                  ),
                ],
              ),

              height(Responsive.h(16)),
            ],
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
          Text(
            'Propose a Collaboration',
            style: customTextStyle(
              fontSize: Responsive.sp(13),
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),

          height(Responsive.h(8)),

          Text(
            'Tell us what you have in mind — our events team will reach out to confirm details.',
            style: customTextStyle(
              fontSize: Responsive.sp(11),
              fontWeight: FontWeight.w600,
              color: AppColors.homeTextMuted,
            ),
          ),
        ],
      ),
    );
  }
}
