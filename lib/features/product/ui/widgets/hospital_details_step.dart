import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/widgets/custom_attachment_field.dart';
import 'package:Doctors_App/core/widgets/custom_date_picker.dart';
import 'package:Doctors_App/core/widgets/custom_dropdown_field.dart';
import 'package:Doctors_App/core/widgets/custom_text_field.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/values/app_text_style.dart';
import '../../../../theme/app_colors.dart';
import '../../model/product_model.dart';
import '../../model/purchase_model.dart';
import '../state/purchase_wizard_state.dart';
import '../view_model/purchase_wizard_controller.dart';

class HospitalDetailsStep extends ConsumerStatefulWidget {
  final WizardArgs controllerArgs;
  final Product product;

  const HospitalDetailsStep({
    super.key,
    required this.controllerArgs,
    required this.product,
  });

  @override
  ConsumerState<HospitalDetailsStep> createState() =>
      _HospitalDetailsStepState();
}

class _HospitalDetailsStepState extends ConsumerState<HospitalDetailsStep> {
  final _opdCtrl = TextEditingController();
  final _ipdCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _regStateCtrl = TextEditingController();
  final _regNoCtrl = TextEditingController();
  final _regYearCtrl = TextEditingController();

  final _hospitalClinicStateCtrl = TextEditingController();
  final _hospitalClinicNoCtrl = TextEditingController();
  final _hospitalClinicYearCtrl = TextEditingController();

  final _staffCountCtrl = TextEditingController(text: '0');
  final _retroactiveDateCtrl = TextEditingController();

  String? _diplomaPath;
  String? _previousPolicyPath;
  DateTime? _retroactiveDate;
  bool retroactive = false;
  bool _worldwide = false;
  bool _hasUnqualifiedStaff = false;

  @override
  void dispose() {
    for (final c in [
      _regStateCtrl,
      _regNoCtrl,
      _regYearCtrl,
      _staffCountCtrl,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _pickRetroactiveDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _retroactiveDate = picked;
        _retroactiveDateCtrl.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> _pickFile(void Function(String path) onPicked) async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) onPicked(result.files.single.path!);
    onPicked('selected_document.pdf');
    setState(() {});
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    if (retroactive) {
      if (_retroactiveDate == null) {
        context.showWarningSnackBar('Please select the retroactive date.');
        return;
      }

      if (_previousPolicyPath == null || _previousPolicyPath!.isEmpty) {
        context.showWarningSnackBar('Please upload your previous policy.');
        return;
      }
    }

    final details = HospitalDetails(
      medicalRegState: _regStateCtrl.text.trim(),
      medicalRegNo: _regNoCtrl.text.trim(),
      medicalRegYear: _regYearCtrl.text.trim(),
      diplomaCertificatePath: _diplomaPath,
      previousPolicyPath: _previousPolicyPath,
      retroactiveDate: _retroactiveDate,
      retroActive: retroactive,
      worldwide: _worldwide,
      hasUnqualifiedStaff: _hasUnqualifiedStaff,
      unqualifiedStaffCount: int.tryParse(_staffCountCtrl.text) ?? 0,
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
        .saveHospitalDetails(details);
  }

  @override
  Widget build(BuildContext context) {
    final isEstablishment =
        widget.product.type == ProductType.medicalEstablishment;
    final isIndividual = widget.product.type == ProductType.individual;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hospital/clinic details',
              style: customTextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            height(12),
            CustomDropdownField(
              label: 'Medical reg. state',
              hint: 'Select State',
              controller: _regStateCtrl,
              isRequired: isIndividual,
              items: ['Maharashtra', 'Goa'],
            ),
            height(10),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: 'Medical reg. no.',
                    controller: _regNoCtrl,
                    isRequired: isIndividual,
                  ),
                ),
                width(10),
                Expanded(
                  child: CustomTextField(
                    label: 'Medical reg. year',
                    controller: _regYearCtrl,
                    isRequired: isIndividual,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            height(12),
            CustomDropdownField(
              label: 'Hospital/clinic reg. state',
              hint: 'Select State',
              controller: _hospitalClinicStateCtrl,
              isRequired: isEstablishment,
              items: ['Maharashtra', 'Goa'],
            ),
            height(10),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: 'Hospital/clinic reg. no.',
                    controller: _hospitalClinicNoCtrl,
                    isRequired: isEstablishment,
                  ),
                ),
                width(10),
                Expanded(
                  child: CustomTextField(
                    label: 'Hospital/clinic reg. year',
                    controller: _hospitalClinicYearCtrl,
                    isRequired: isEstablishment,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            height(14),
            if (isEstablishment)
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: 'OPD',
                      controller: _opdCtrl,
                      hint: 'Enter OPD',
                    ),
                  ),
                  width(10),
                  Expanded(
                    child: CustomTextField(
                      label: 'IPD',
                      controller: _ipdCtrl,
                      isRequired: true,
                      hint: 'Enter IPD',
                    ),
                  ),
                ],
              ),
            height(14),
            CustomAttachmentField(
              label: 'Diploma/degree/additional certificate',
              // fileName: _previousPolicyPath,
              onTap: () => _pickFile((p) => _diplomaPath = p),
              hint: '',
              controller: TextEditingController(),
            ),
            height(14),
            CustomAttachmentField(
              label: 'Training Document',
              // fileName: _previousPolicyPath,
              onTap: () => _pickFile((p) => _diplomaPath = p),
              hint: '',
              controller: TextEditingController(),
            ),
            height(14),
            _YesNoRow(
              label: 'Retroactive?',
              value: retroactive,
              onChanged: (v) => setState(() => retroactive = v),
            ),
            if (retroactive) ...[
              CustomDatePicker(
                label: 'Retroactive Date',
                hint: 'Select Date',
                controller: _retroactiveDateCtrl,
                onTap: _pickRetroactiveDate,
                isRequired: retroactive,
              ),
              height(14),
              CustomAttachmentField(
                label: 'Previous Policy',
                controller: TextEditingController(
                  text: _previousPolicyPath ?? '',
                ),
                hint: '',
                isRequired: retroactive,
                onTap: () => _pickFile((p) => _previousPolicyPath = p),
              ),
              height(14),
            ],
            _YesNoRow(
              label: 'Worldwide coverage?',
              value: _worldwide,
              onChanged: (v) => setState(() => _worldwide = v),
            ),
            height(10),
            _YesNoRow(
              label: 'Unqualified staff?',
              value: _hasUnqualifiedStaff,
              onChanged: (v) => setState(() => _hasUnqualifiedStaff = v),
            ),
            if (_hasUnqualifiedStaff) ...[
              height(10),
              CustomTextField(
                label: 'Unqualified Staff Count',
                controller: _staffCountCtrl,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (!_hasUnqualifiedStaff) return null;

                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter staff count';
                  }

                  final count = int.tryParse(value);

                  if (count == null) {
                    return 'Enter a valid number';
                  }

                  if (count < 1 || count > 5) {
                    return 'Staff count must be between 1 and 5';
                  }

                  return null;
                },
              ),
            ],
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
}

class _YesNoRow extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _YesNoRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label, style: customTextStyle(fontSize: 13))),
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: AppColors.orange,
        ),
      ],
    );
  }
}
