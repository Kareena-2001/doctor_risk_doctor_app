import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/widgets/custom_date_picker.dart';
import 'package:Doctors_App/core/widgets/custom_text_field.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/values/app_text_style.dart';
import '../../../../theme/app_colors.dart';
import '../../model/purchase_model.dart';
import '../state/purchase_wizard_state.dart';
import '../view_model/purchase_wizard_controller.dart';

class HospitalDetailsStep extends ConsumerStatefulWidget {
  final WizardArgs controllerArgs;

  const HospitalDetailsStep({super.key, required this.controllerArgs});

  @override
  ConsumerState<HospitalDetailsStep> createState() =>
      _HospitalDetailsStepState();
}

class _HospitalDetailsStepState extends ConsumerState<HospitalDetailsStep> {
  final _formKey = GlobalKey<FormState>();
  final _regStateCtrl = TextEditingController();
  final _regNoCtrl = TextEditingController();
  final _regYearCtrl = TextEditingController();
  final _staffCountCtrl = TextEditingController(text: '0');

  final _retroactiveDateCtrl = TextEditingController();
  String? _diplomaPath;
  String? _previousPolicyPath;
  DateTime? _retroactiveDate;
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
    if (!_formKey.currentState!.validate() || _retroactiveDate == null) {
      if (_retroactiveDate == null) {
        context.showWarningSnackBar('Please select a retroactive date');
      }
      return;
    }

    final details = HospitalDetails(
      medicalRegState: _regStateCtrl.text.trim(),
      medicalRegNo: _regNoCtrl.text.trim(),
      medicalRegYear: _regYearCtrl.text.trim(),
      diplomaCertificatePath: _diplomaPath,
      previousPolicyPath: _previousPolicyPath,
      retroactiveDate: _retroactiveDate!,
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
            CustomTextField(
              label: 'Medical reg. state',
              controller: _regStateCtrl,
              isRequired: true,
            ),
            height(10),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: 'Medical reg. no.',
                    controller: _regNoCtrl,
                    isRequired: true,
                  ),
                ),
                width(10),
                Expanded(
                  child: CustomTextField(
                    label: 'Medical reg. year',
                    controller: _regYearCtrl,
                    isRequired: true,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            height(14),
            _FilePickerTile(
              label: 'Diploma/degree/additional certificate',
              fileName: _diplomaPath,
              onTap: () => _pickFile((p) => _diplomaPath = p),
            ),
            height(10),
            _FilePickerTile(
              label: 'Previous policy',
              fileName: _previousPolicyPath,
              onTap: () => _pickFile((p) => _previousPolicyPath = p),
            ),
            height(14),
            // InkWell(
            //   onTap: _pickRetroactiveDate,
            //   child: InputDecorator(
            //     decoration: const InputDecoration(
            //       labelText: 'Retroactive date',
            //     ),
            //     child: Text(
            //       _retroactiveDate == null
            //           ? 'Select date'
            //           : '${_retroactiveDate!.day}/${_retroactiveDate!.month}/${_retroactiveDate!.year}',
            //     ),
            //   ),
            // ),
            CustomDatePicker(
              label: 'Retroactive date',
              hint: 'Select Date',
              controller: _retroactiveDateCtrl,
              onTap: _pickRetroactiveDate,
            ),
            height(14),
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
                label: 'Unqualified staff count',
                controller: _staffCountCtrl,
                keyboardType: TextInputType.number,
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

class _FilePickerTile extends StatelessWidget {
  final String label;
  final String? fileName;
  final VoidCallback onTap;

  const _FilePickerTile({
    required this.label,
    required this.fileName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.attach_file_rounded,
              size: 18,
              color: Color(0xFF64748B),
            ),
            width(8),
            Expanded(
              child: Text(
                fileName ?? label,
                style: customTextStyle(
                  fontSize: 12,
                  color: fileName == null
                      ? const Color(0xFF94A3B8)
                      : const Color(0xFF1E293B),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              'Attach',
              style: customTextStyle(fontSize: 12, color: AppColors.orange),
            ),
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
