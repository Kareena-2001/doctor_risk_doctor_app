import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/core/widgets/custom_date_picker.dart';
import 'package:Doctors_App/core/widgets/custom_radio_group.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/custom_text_field.dart';

class AddLegalConsultantForm extends ConsumerStatefulWidget {
  const AddLegalConsultantForm({super.key});

  @override
  ConsumerState<AddLegalConsultantForm> createState() =>
      _AddLegalConsultantFormState();
}

class _AddLegalConsultantFormState
    extends ConsumerState<AddLegalConsultantForm> {
  final _formKey = GlobalKey<FormState>();

  final _descriptionController = TextEditingController();
  final _complainantNameController = TextEditingController();
  final _complainantMobileController = TextEditingController();
  final _documentNameController = TextEditingController();

  String _supportType = 'Medical';
  DateTime? _selectedDate;
  final List<String> _uploadedFiles = [];

  @override
  void dispose() {
    _descriptionController.dispose();
    _complainantNameController.dispose();
    _complainantMobileController.dispose();
    _documentNameController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              surface: Colors.white,
              primary: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _addMockAttachment() {
    if (_documentNameController.text.trim().isEmpty) return;
    setState(() {
      _uploadedFiles.add(_documentNameController.text.trim());
      _documentNameController.clear();
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null) {
        context.showWarningSnackBar('Please pick an incident date');
        return;
      }
      // ref.read(casesProvider.notifier).addNewCase(...);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Add New Case', showBack: true),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(Responsive.sp(16)),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                label: 'Description',
                controller: _descriptionController,
                maxLines: 3,
                hint: 'Enter case brief or details...',
                validator: (val) =>
                    val!.isEmpty ? 'Description required' : null,
              ),
              height(16),
              // Text(
              //   'Legal Support Type',
              //   style: Theme.of(context).textTheme.titleSmall,
              // ),
              Row(
                children: [
                  CustomRadioGroup(
                    label: 'Legal Support Type',
                    options: ['Medical', 'Non Medical'],
                    onChanged: (val) => setState(() => _supportType = val!),
                  ),
                ],
              ),
              height(8),
              CustomTextField(
                controller: _complainantNameController,
                label: 'Full legal name',
                validator: (val) => val!.isEmpty ? 'Name required' : null,
              ),
              height(16),
              CustomTextField(
                label: 'Complainant Mobile',
                controller: _complainantMobileController,
                keyboardType: TextInputType.phone,
                validator: (val) =>
                    val!.isEmpty ? 'Mobile number required' : null,
              ),
              height(16),
              CustomDatePicker(
                label: 'Incident Date',
                hint: 'Select Date',
                controller: TextEditingController(),
                onTap: () => _selectDate(context),
              ),
              height(16),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: 'Document Attachment Name',
                      hint: 'Medical Report, Case Bill',
                      controller: _documentNameController,
                    ),
                  ),
                  width(8),
                  ElevatedButton.icon(
                    onPressed: _addMockAttachment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.divider,
                      foregroundColor: Theme.of(
                        context,
                      ).colorScheme.onPrimaryContainer,
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.sp(12),
                        vertical: Responsive.sp(14),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: Icon(Icons.upload_file, size: 16),
                    label: Text('Add File', style: customTextStyle()),
                  ),
                ],
              ),

              // Generated dynamic list displaying files attached so far
              if (_uploadedFiles.isNotEmpty) ...[
                height(12),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _uploadedFiles.length,
                    itemBuilder: (context, idx) => ListTile(
                      leading: const Icon(
                        Icons.file_present,
                        color: Colors.blueGrey,
                      ),
                      title: Text(
                        _uploadedFiles[idx],
                        style: customTextStyle(fontSize: 13),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.redAccent,
                          size: 18,
                        ),
                        onPressed: () =>
                            setState(() => _uploadedFiles.removeAt(idx)),
                      ),
                    ),
                  ),
                ),
              ],
              height(32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.newPri,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Submit Case Files',
                    style: customTextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
