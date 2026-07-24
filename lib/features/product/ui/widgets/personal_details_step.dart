import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/widgets/custom_dropdown_field.dart';
import 'package:Doctors_App/core/widgets/custom_text_field.dart';
import 'package:Doctors_App/core/widgets/multi_select_dropdown.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/product/model/product_tier.dart';
import 'package:Doctors_App/features/product/ui/widgets/plan_summary_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/values/app_text_style.dart';
import '../../../../core/widgets/custom_date_picker.dart';
import '../../../../theme/app_colors.dart';
import '../../model/product_model.dart';
import '../../model/purchase_model.dart';
import '../state/purchase_wizard_state.dart';
import '../view_model/purchase_wizard_controller.dart';

class PersonalDetailsStep extends ConsumerStatefulWidget {
  final Product product;
  final TierPlan tier;
  final String duration;
  final double sumAssured;
  final double premium;
  final WizardArgs controllerArgs;

  const PersonalDetailsStep({
    super.key,
    required this.product,
    required this.tier,
    required this.duration,
    required this.sumAssured,
    required this.premium,
    required this.controllerArgs,
  });

  @override
  ConsumerState<PersonalDetailsStep> createState() =>
      _PersonalDetailsStepState();
}

class _PersonalDetailsStepState extends ConsumerState<PersonalDetailsStep> {
  final _formKey = GlobalKey<FormState>();

  final degrees = ['MBBS', 'MS', 'MDS', 'BDS', 'MD', 'DM'];
  final _prefixCtrl = TextEditingController(text: 'Dr.');
  final _firstNameCtrl = TextEditingController();
  final _middleNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();

  final _opdCtrl = TextEditingController();
  final _ipdCtrl = TextEditingController();

  final _degreeCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _mobileCtrl = TextEditingController();
  final _altMobileCtrl = TextEditingController();
  final _orgCtrl = TextEditingController();

  final _dobCtrl = TextEditingController();
  List<String> _selectedDegrees = [];

  DateTime? _dob;
  final Gender _gender = Gender.male;

  @override
  void dispose() {
    for (final c in [
      _prefixCtrl,
      _firstNameCtrl,
      _middleNameCtrl,
      _lastNameCtrl,
      _degreeCtrl,
      _emailCtrl,
      _mobileCtrl,
      _altMobileCtrl,
      _orgCtrl,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedDegrees.isEmpty) {
      context.showWarningSnackBar('Please select a degree');
      return;
    }

    if (_dob == null) {
      context.showWarningSnackBar('Please select date of birth');
      return;
    }

    final details = PersonalDetails(
      prefix: _prefixCtrl.text.trim(),
      firstName: _firstNameCtrl.text.trim(),
      middleName: _middleNameCtrl.text.trim(),
      lastName: _lastNameCtrl.text.trim(),
      degree: _selectedDegrees.isNotEmpty ? _selectedDegrees.first : '',
      emailId: _emailCtrl.text.trim(),
      mobileNumber: _mobileCtrl.text.trim(),
      alternateNumber: _altMobileCtrl.text.trim(),
      dateOfBirth: _dob!,
      gender: _gender,
      organisation: _orgCtrl.text.trim(),
    );

    ref
        .read(
          purchaseWizardControllerProvider(
            widget.controllerArgs.$1,
            widget.controllerArgs.$2,
            widget.controllerArgs.$3,
            widget.controllerArgs.$4,
            widget.controllerArgs.$5,
          ).notifier,
        )
        .savePersonalDetails(details);
  }

  Future<void> _pickDob() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1990, 1, 1),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _dob = picked;
        _dobCtrl.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEstablishment =
        widget.product.type == ProductType.medicalEstablishment;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Information',
                  style: customTextStyle(
                    fontSize: Responsive.h(13),
                    fontWeight: FontWeight.w600,
                    color: AppColors.newPri,
                  ),
                ),
                GestureDetector(
                  onTap: _showCodeGuide,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 16,
                        color: AppColors.newPri,
                      ),
                      width(4),
                      Text(
                        'Which one?',
                        style: customTextStyle(
                          fontSize: Responsive.h(12),
                          color: AppColors.newPri,
                        ).copyWith(decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            height(12),
            PlanSummaryCard(
              productName: widget.product.productNames.join(' / '),
              tierName: widget.tier.name,
              duration: widget.duration,
              sumAssured: widget.sumAssured,
              premium: widget.premium,
            ),
            height(20),
            Text(
              'Personal details',
              style: customTextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            height(12),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CustomTextField(
                    label: 'Prefix',
                    controller: _prefixCtrl,
                  ),
                ),
                width(10),
                Expanded(
                  flex: 3,
                  child: CustomTextField(
                    label: 'First name',
                    controller: _firstNameCtrl,
                    hint: 'Enter First Name',
                    isRequired: true,
                  ),
                ),
              ],
            ),
            height(Responsive.h(10)),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: 'Middle name',
                    controller: _middleNameCtrl,
                    hint: 'Enter Middle Name',
                  ),
                ),
                width(10),
                Expanded(
                  child: CustomTextField(
                    label: 'Last name',
                    controller: _lastNameCtrl,
                    isRequired: true,
                    hint: 'Enter Last Name',
                  ),
                ),
              ],
            ),
            height(10),
            MultiSelectDropdown(
              label: 'Degree',
              hintText: 'Select Degree',
              isRequired: !isEstablishment,
              options: degrees,
              selectedItems: _selectedDegrees,
              onSelectionChanged: (List<String> selected) {
                setState(() {
                  _selectedDegrees = selected;
                });
              },
            ),
            height(10),
            CustomTextField(
              label: 'Email ID',
              controller: _emailCtrl,
              hint: 'Enter Email Id',
              isRequired: !isEstablishment,
              keyboardType: TextInputType.emailAddress,
            ),
            height(10),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: 'Mobile number',
                    hint: 'Enter Mobile No.',
                    controller: _mobileCtrl,
                    isRequired: true,
                    keyboardType: TextInputType.phone,
                  ),
                ),
                width(10),
                Expanded(
                  child: CustomTextField(
                    label: 'Alternate number',
                    hint: 'Enter Alternate No.',
                    controller: _altMobileCtrl,
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),

            height(10),
            Row(
              children: [
                Expanded(
                  child: CustomDatePicker(
                    label: 'Date of birth',
                    hint: 'Select Dob',
                    controller: _dobCtrl,
                    onTap: _pickDob,
                  ),
                ),
                width(10),
                Expanded(
                  child: CustomDropdownField(
                    label: 'Gender',
                    hint: 'Select Gender',
                    items: ['Male', 'Female'],
                  ),
                ),
              ],
            ),
            height(10),
            CustomTextField(
              label: 'Organisation/Association',
              hint: 'Enter Organisation',
              controller: _orgCtrl,
            ),
            height(24),
            PrimaryButton(
              height: 50,
              text: 'Continue',
              backgroundColor: AppColors.newPri,
              onPressed: _submit,
            ),
            height(20),
          ],
        ),
      ),
    );
  }

  void _showCodeGuide() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: AppColors.newPri),
                width(8),
                Text(
                  'Which code should I enter?',
                  style: customTextStyle(
                    fontSize: Responsive.h(16),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            height(16),
            Text(
              '• If you are joining through an organization, enter the '
              'Organization Code (Source Code).\n\n'
              '• If you are joining independently through a referral, '
              'enter the Associate Code instead.\n\n'
              'You only need to fill one of these — not both.',
              style: customTextStyle(
                fontSize: Responsive.h(14),
                color: AppColors.grey,
              ),
            ),
            height(20),
            PrimaryButton(
              text: 'Got it',
              onPressed: () => Navigator.pop(context),
              backgroundColor: AppColors.newPri,
            ),
          ],
        ),
      ),
    );
  }
}
