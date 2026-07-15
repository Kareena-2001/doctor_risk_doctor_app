import 'dart:io';

import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/core/widgets/custom_date_picker.dart';
import 'package:Doctors_App/core/widgets/custom_radio_group.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_filex/open_filex.dart';

import '../../../core/widgets/custom_text_field.dart';
import '../model/legal_attachement_model.dart';

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

  final List<LegalAttachment> _attachedDocumentsList = [];

  Future<void> _pickAndAddAttachment() async {
    final docName = _documentNameController.text.trim();

    if (docName.isEmpty) {
      context.showErrorSnackBar(
        'Please enter a Document Name before uploading',
      );

      return;
    }

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'docx'],
    );

    if (result != null && result.files.single.path != null) {
      final File pickedFile = File(result.files.single.path!);

      setState(() {
        _attachedDocumentsList.add(
          LegalAttachment(documentName: docName, file: pickedFile),
        );
        _documentNameController.clear();
      });
    } else {
      context.showErrorSnackBar('File upload cancelled');
    }
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
                label: 'Complainant Name',
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: CustomTextField(
                          label: 'Document Attachment Name',
                          hint: 'e.g., Medical Report, Case Bill',
                          controller: _documentNameController,
                        ),
                      ),
                      width(8),
                      ElevatedButton.icon(
                        onPressed: _pickAndAddAttachment,
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
                        icon: const Icon(Icons.upload_file, size: 16),
                        label: Text('Upload File', style: customTextStyle()),
                      ),
                    ],
                  ),

                  if (_attachedDocumentsList.isNotEmpty) ...[
                    height(16),
                    Text(
                      'Uploaded Documents (${_attachedDocumentsList.length})',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    height(6),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _attachedDocumentsList.length,
                        separatorBuilder: (_, __) =>
                            Divider(color: Colors.grey.shade200, height: 1),
                        itemBuilder: (context, index) {
                          final attachment = _attachedDocumentsList[index];
                          final actualFileName = attachment.file.path
                              .split('/')
                              .last;

                          return ListTile(
                            dense: true,
                            leading: Icon(
                              _getFileIcon(actualFileName),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            title: Text(
                              attachment.documentName,
                              style: customTextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                            subtitle: Text(
                              actualFileName,
                              style: customTextStyle(
                                color: AppColors.textColor,
                                fontSize: 11,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.visibility_outlined,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.secondary,
                                    size: 20,
                                  ),
                                  tooltip: 'View Document',
                                  onPressed: () =>
                                      _viewAttachedFile(attachment.file),
                                ),
                                // 2. DELETE FILE BUTTON
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    color: Colors.redAccent,
                                    size: 20,
                                  ),
                                  tooltip: 'Delete Document',
                                  onPressed: () {
                                    setState(() {
                                      _attachedDocumentsList.removeAt(index);
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),

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

  IconData _getFileIcon(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();
    switch (extension) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icons.image;
      case 'doc':
      case 'docx':
        return Icons.description;
      default:
        return Icons.insert_drive_file;
    }
  }

  Future<void> _viewAttachedFile(File file) async {
    if (await file.exists()) {
      final result = await OpenFilex.open(file.path);

      if (result.type != ResultType.done) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open file: ${result.message}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('File no longer exists on this device.')),
      );
    }
  }
}
