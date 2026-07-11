import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/widgets/custom_dropdown_field.dart';
import 'package:Doctors_App/core/widgets/custom_text_field.dart';
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
  final _degreeCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _mobileCtrl = TextEditingController();
  final _altMobileCtrl = TextEditingController();
  final _orgCtrl = TextEditingController();

  final _dobCtrl = TextEditingController();

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
    if (!_formKey.currentState!.validate() || _dob == null) {
      if (_dob == null) {
        context.showWarningSnackBar('Please select date of birth');
      }
      return;
    }

    final details = PersonalDetails(
      prefix: _prefixCtrl.text.trim(),
      firstName: _firstNameCtrl.text.trim(),
      middleName: _middleNameCtrl.text.trim(),
      lastName: _lastNameCtrl.text.trim(),
      degree: _degreeCtrl.text.trim(),
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            CustomDropdownField(
              label: 'Degree',
              hint: 'Select Degree',
              controller: _degreeCtrl,
              isRequired: true,
              items: degrees,
            ),
            height(10),
            CustomTextField(
              label: 'Email ID',
              controller: _emailCtrl,
              hint: 'Enter Email Id',
              isRequired: true,
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
              backgroundColor: AppColors.orange,
              onPressed: _submit,
            ),
            height(20),
          ],
        ),
      ),
    );
  }
}
