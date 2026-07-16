import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../model/legal_court_case_model.dart';

class AddLegalCasesForm extends StatefulWidget {
  const AddLegalCasesForm({super.key});

  @override
  State<AddLegalCasesForm> createState() => _AddLegalCasesFormState();
}

class _AddLegalCasesFormState extends State<AddLegalCasesForm> {
  final _formKey = GlobalKey<FormState>();

  final _advocateNameController = TextEditingController();
  final _caseTypeController = TextEditingController();
  final _caseNoController = TextEditingController();
  final _complainantNameController = TextEditingController();
  final _complainantMobileController = TextEditingController();
  final _courtController = TextEditingController();

  DateTime? _previousDate;
  DateTime? _nextDate;
  bool _presentRequired = false;
  CourtCaseStatus _selectedStatus = CourtCaseStatus.pending;

  @override
  void dispose() {
    _advocateNameController.dispose();
    _caseTypeController.dispose();
    _caseNoController.dispose();
    _complainantNameController.dispose();
    _complainantMobileController.dispose();
    _courtController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Future<void> _selectDate(BuildContext context, bool isNextDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.newPri,
              onPrimary: Colors.white,
              onSurface: const Color(0xFF0F172A),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isNextDate) {
          _nextDate = picked;
        } else {
          _previousDate = picked;
        }
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Create structural CourtCaseModel instances using field inputs
      final newCase = CourtCaseModel(
        srNo: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        // Unique temporary serial reference key
        advocateName: _advocateNameController.text.trim(),
        previousDate: _formatDate(_previousDate),
        caseType: _caseTypeController.text.trim(),
        caseNo: _caseNoController.text.trim(),
        complainantName: _complainantNameController.text.trim(),
        complainantMobile: _complainantMobileController.text.trim(),
        court: _courtController.text.trim(),
        presentRequired: _presentRequired,
        addedOn: _formatDate(DateTime.now()),
        nextDate: _formatDate(_nextDate),
        status: _selectedStatus,
        remarks: [], // Initial empty remarks list log
      );

      // Return generated item model metadata structure back to previous state screen pop handler
      Navigator.pop(context, newCase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const CustomAppBar(title: 'Add New Case'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Case Information',
                  style: customTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                height(12),

                // Form card wrapper
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    children: [
                      _buildTextField(
                        controller: _caseNoController,
                        label: 'Case Number',
                        hint: 'e.g. CC/1042/2026',
                        icon: Icons.gavel_rounded,
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter case number' : null,
                      ),
                      height(16),
                      _buildTextField(
                        controller: _caseTypeController,
                        label: 'Case Type',
                        hint: 'e.g. Criminal, Civil Appeal',
                        icon: Icons.category_outlined,
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter case type' : null,
                      ),
                      height(16),
                      _buildTextField(
                        controller: _courtController,
                        label: 'Court Name',
                        hint: 'e.g. High Court, District Session Court',
                        icon: Icons.account_balance_outlined,
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter court name' : null,
                      ),
                      height(16),
                      _buildTextField(
                        controller: _advocateNameController,
                        label: 'Advocate Name',
                        hint: 'Enter professional advocate name',
                        icon: Icons.person_outline,
                        validator: (value) => value!.isEmpty
                            ? 'Please enter advocate name'
                            : null,
                      ),
                    ],
                  ),
                ),
                height(24),

                Text(
                  'Complainant Contact details',
                  style: customTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                height(12),

                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    children: [
                      _buildTextField(
                        controller: _complainantNameController,
                        label: 'Complainant Name',
                        hint: 'Enter full complainant name',
                        icon: Icons.person_pin_outlined,
                        validator: (value) => value!.isEmpty
                            ? 'Please enter complainant name'
                            : null,
                      ),
                      height(16),
                      _buildTextField(
                        controller: _complainantMobileController,
                        label: 'Complainant Contact',
                        hint: 'e.g. 9876543210',
                        icon: Icons.phone_android_outlined,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty)
                            return 'Please enter contact number';
                          if (value.length < 10)
                            return 'Please enter valid contact number';
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                height(24),

                Text(
                  'Schedule Hearings & Current Status',
                  style: customTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                height(12),

                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    children: [
                      _buildDatePickerField(
                        label: 'Previous Hearing Date',
                        selectedDate: _previousDate,
                        onTap: () => _selectDate(context, false),
                      ),
                      height(16),
                      _buildDatePickerField(
                        label: 'Next Hearing Date',
                        selectedDate: _nextDate,
                        onTap: () => _selectDate(context, true),
                      ),
                      height(16),

                      // Status Dropdown Select field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Case Hearing Status',
                            style: customTextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF475569),
                            ),
                          ),
                          height(6),
                          DropdownButtonFormField<CourtCaseStatus>(
                            value: _selectedStatus,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFFF8FAFC),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 12,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color(0xFFE2E8F0),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: AppColors.newPri),
                              ),
                            ),
                            items: CourtCaseStatus.values.map((status) {
                              return DropdownMenuItem<CourtCaseStatus>(
                                value: status,
                                child: Text(
                                  status.name.toUpperCase(),
                                  style: customTextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => _selectedStatus = val);
                              }
                            },
                          ),
                        ],
                      ),
                      const Divider(height: 32, color: Color(0xFFF1F5F9)),

                      // Presence Required Switch Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Court Presence Required',
                                  style: customTextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Does physical attendance matter for this next hearing date?',
                                  style: customTextStyle(
                                    fontSize: 11,
                                    color: AppColors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch.adaptive(
                            value: _presentRequired,
                            activeColor: AppColors.newPri,
                            onChanged: (val) =>
                                setState(() => _presentRequired = val),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                height(32),

                // Submit Form Button
                PrimaryButton(
                  height: 48,
                  text: 'Submit Case File',
                  fontSize: 15,
                  backgroundColor: AppColors.newPri,
                  onPressed: _submitForm,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: customTextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF475569),
          ),
        ),
        height(6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: customTextStyle(
              fontSize: 12.5,
              color: const Color(0xFF94A3B8),
            ),
            prefixIcon: Icon(icon, size: 18, color: const Color(0xFF64748B)),
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.newPri),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFFCA5A5)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFDC2626)),
            ),
          ),
          style: customTextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  Widget _buildDatePickerField({
    required String label,
    required DateTime? selectedDate,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: customTextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF475569),
          ),
        ),
        height(6),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate == null
                      ? 'Select Hearing Date'
                      : _formatDate(selectedDate),
                  style: customTextStyle(
                    fontSize: 13,
                    fontWeight: selectedDate == null
                        ? FontWeight.w500
                        : FontWeight.w600,
                    color: selectedDate == null
                        ? const Color(0xFF94A3B8)
                        : const Color(0xFF0F172A),
                  ),
                ),
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 18,
                  color: Color(0xFF64748B),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
