import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/core/widgets/custom_dropdown_field.dart';
import 'package:Doctors_App/core/widgets/custom_text_field.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AddLegalNoticeForm extends ConsumerStatefulWidget {
  const AddLegalNoticeForm({super.key});

  @override
  ConsumerState<AddLegalNoticeForm> createState() => _AddLegalNoticeFormState();
}

class _AddLegalNoticeFormState extends ConsumerState<AddLegalNoticeForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _complainantNameController = TextEditingController();
  final _complainantMobileController = TextEditingController();
  final _placeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _documentNameController = TextEditingController();

  // State Variables
  String _noticeTypeSelection =
      'Select'; // Handles Notice: Select, Send, Received
  String? _selectedNoticeCategory; // Handles Type of Notice Dropdown
  DateTime? _selectedDate;
  final List<String> _uploadedFiles = [];

  // Dropdown options for Type of Notice
  final List<String> _noticeCategories = [
    'Defamation',
    'Recovery',
    '138 NI',
    'Medical Negligence',
  ];

  @override
  void dispose() {
    _complainantNameController.dispose();
    _complainantMobileController.dispose();
    _placeController.dispose();
    _descriptionController.dispose();
    _documentNameController.dispose();
    super.dispose();
  }

  // Pure white theme styled Date Picker helper
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Please pick a date')));
        return;
      }
      if (_selectedNoticeCategory == null) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text('Please select a Notice Type')),
        // );
        context.showWarningSnackBar('Please select a Notice Type');
        return;
      }

      debugPrint("Mode: $_noticeTypeSelection");
      debugPrint("Category: $_selectedNoticeCategory");
      debugPrint("Place: ${_placeController.text}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Add Legal Notice', showBack: true),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(Responsive.sp(16)),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Notice Action Selector Radio Items
              Text('Notice', style: Theme.of(context).textTheme.titleSmall),
              Row(
                children: ['Send', 'Received'].map((option) {
                  return Expanded(
                    child: RadioListTile<String>(
                      title: Text(option, style: customTextStyle(fontSize: 13)),
                      value: option,
                      groupValue: _noticeTypeSelection,
                      activeColor: AppColors.newPri,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (val) =>
                          setState(() => _noticeTypeSelection = val!),
                    ),
                  );
                }).toList(),
              ),
              height(12),

              // Date Selector Block
              Text('Date', style: Theme.of(context).textTheme.titleSmall),
              height(6),
              InkWell(
                onTap: () => _selectDate(context),
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.sp(12),
                    vertical: Responsive.sp(14),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedDate == null
                            ? 'Select Date'
                            : DateFormat('dd MMM yyyy').format(_selectedDate!),
                        style: customTextStyle(color: AppColors.textColor),
                      ),
                      Icon(
                        Icons.calendar_today,
                        size: 18,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),
                ),
              ),
              height(16),
              CustomDropdownField(
                label: 'Type Of Notice',
                hint: 'Select Notice Type',
                items: _noticeCategories,
                onChanged: (newValue) {
                  setState(() {
                    _selectedNoticeCategory = newValue;
                  });
                },
                validator: (val) =>
                    val == null ? 'Notice type configuration required' : null,
              ),
              height(16),

              // Complainant Input Fields
              CustomTextField(
                controller: _complainantNameController,
                label: 'Complainant Name',
                hint: 'Enter complainant name',
                validator: (val) => val!.isEmpty ? 'Name required' : null,
              ),
              height(16),
              CustomTextField(
                label: 'Complainant Mobile',
                controller: _complainantMobileController,
                keyboardType: TextInputType.phone,
                hint: 'Enter mobile number',
                validator: (val) =>
                    val!.isEmpty ? 'Mobile number required' : null,
              ),
              height(16),

              // Place Input Field
              CustomTextField(
                controller: _placeController,
                label: 'Place',
                hint: 'Enter place location',
                validator: (val) =>
                    val!.isEmpty ? 'Place requirement missing' : null,
              ),
              height(16),

              // Description Form Text field
              CustomTextField(
                label: 'Description',
                controller: _descriptionController,
                maxLines: 3,
                hint: 'Enter notice brief summary details...',
                validator: (val) =>
                    val!.isEmpty ? 'Description details required' : null,
              ),
              height(16),

              // Document Upload Configuration Section
              Text(
                'Upload Documents',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              height(6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: 'Documents Name',
                      hint: 'e.g., Medical Report, Case Bill',
                      controller: _documentNameController,
                    ),
                  ),
                  width(8),
                  Padding(
                    padding: const EdgeInsets.only(top: 22.0),
                    // Pushes button clear of field text label
                    child: ElevatedButton.icon(
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
                      icon: const Icon(Icons.upload_file, size: 16),
                      label: Text('Upload', style: customTextStyle()),
                    ),
                  ),
                ],
              ),

              // Dynamic uploaded listing panel
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

              // Finalized Submit Form Action Control Button
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
                      fontSize: 16,
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

  // Consistent Input decoration for standard configurations like Dropdowns
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: customTextStyle(color: AppColors.textColor, fontSize: 13),
      contentPadding: EdgeInsets.symmetric(
        horizontal: Responsive.sp(12),
        vertical: Responsive.sp(12),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
    );
  }
}
