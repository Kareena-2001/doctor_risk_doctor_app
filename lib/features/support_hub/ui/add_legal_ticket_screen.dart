import 'dart:io';

import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/core/widgets/custom_attachment_field.dart';
import 'package:Doctors_App/core/widgets/custom_date_picker.dart';

import 'package:Doctors_App/core/widgets/custom_dropdown_field.dart';
import 'package:Doctors_App/core/widgets/custom_text_field.dart';
import 'package:Doctors_App/core/widgets/custom_time_picker.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/support_hub/model/support_ticket_enums.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'view_model/support_hub_view_model.dart';

class AddLegalTicketScreen extends ConsumerStatefulWidget {
  const AddLegalTicketScreen({super.key});

  @override
  ConsumerState<AddLegalTicketScreen> createState() =>
      _AddLegalTicketScreenState();
}

class _AddLegalTicketScreenState extends ConsumerState<AddLegalTicketScreen> {
  final _detailsController = TextEditingController();
  final _attachmentController = TextEditingController();
  final _preferredDateController = TextEditingController();
  final _preferredTimeController = TextEditingController();
  LegalQueryType _queryType = LegalQueryType.registerQuery;
  String? _commonQuery;
  LegalType? _legalType;
  AppointmentMode? _appointmentMode;
  DateTime? _preferredDate;
  TimeOfDay? _preferredTime;
  PriorityLevel? _priority;
  PlatformFile? _selectedFile;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(supportHubViewModelProvider.notifier).resetState();
    });
  }

  @override
  void dispose() {
    _detailsController.dispose();
    _attachmentController.dispose();
    _preferredDateController.dispose();
    _preferredTimeController.dispose();
    super.dispose();
  }

  List<String> get _commonQueryOptions => kLegalCommonQueries[_queryType]!;

  bool get _showLegalType => _queryType != LegalQueryType.bookAppointment;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedFile = result.files.first;
        _attachmentController.text = _selectedFile!.name;
      });
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _preferredTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        _preferredTime = picked;
        _preferredTimeController.text = picked.format(context);
      });
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate:
          _preferredDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        _preferredDate = picked;

        _preferredDateController.text =
            '${picked.day.toString().padLeft(2, '0')}/'
            '${picked.month.toString().padLeft(2, '0')}/'
            '${picked.year}';
      });
    }
  }

  String _mapLegalType() {
    if (_showLegalType && _legalType != null) return _legalType!.apiValue;

    final q = _commonQuery ?? '';
    if (q.contains('Notice')) return 'notice';
    if (_queryType == LegalQueryType.bookAppointment) return 'case';
    return 'consultation';
  }

  String _buildDescription() {
    var desc = _detailsController.text.trim();
    if (_queryType == LegalQueryType.bookAppointment &&
        _preferredDate != null &&
        _preferredTime != null) {
      final timeStr = _preferredTime!.format(context);
      desc =
          'Mode: ${_appointmentMode?.displayName ?? ''}\n'
          'Preferred Date: ${_preferredDate!.day}/${_preferredDate!.month}/${_preferredDate!.year}\n'
          'Preferred Time: $timeStr\n$desc';
    }
    return desc;
  }

  String _formatDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  String _formatTime(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  Future<void> _submit() async {
    if (_commonQuery == null ||
        _priority == null ||
        (_showLegalType && _legalType == null)) {
      context.showErrorSnackBar('Please fill in all required fields');
      return;
    }

    final isAppointment = _queryType == LegalQueryType.bookAppointment;

    if (isAppointment &&
        (_appointmentMode == null ||
            _preferredDate == null ||
            _preferredTime == null)) {
      context.showErrorSnackBar('Please complete the appointment details');
      return;
    }

    final file = _selectedFile?.path != null
        ? File(_selectedFile!.path!)
        : null;
    final vm = ref.read(supportHubViewModelProvider.notifier);

    final ok = isAppointment
        ? await vm.addAppointment(
            appointmentType: 'legal',
            appointmentQuery: _commonQuery!,
            modeOfAppointment: _appointmentMode!.displayName,
            priority: _priority!.displayName,
            description: _detailsController.text.trim(),
            preferredDate: _formatDate(_preferredDate!),
            preferredTime: _formatTime(_preferredTime!),
            file: file,
          )
        : await vm.addTicket(
            ticketType: 'legal',
            queryType: _queryType.displayName,
            commonQuery: _commonQuery!,
            preferredContact: '',
            priority: _priority!.displayName,
            description: _buildDescription(),
            legalType: _mapLegalType(),
            file: file,
          );

    if (!mounted) return;

    if (ok) {
      context.showSuccessSnackBar(
        isAppointment
            ? 'Appointment booked successfully'
            : 'Legal ticket raised successfully',
      );
      Navigator.pop(context, true);
    } else {
      final err = ref.read(supportHubViewModelProvider).error;
      if (err != null) context.showErrorSnackBar(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSubmitting = ref.watch(supportHubViewModelProvider).isLoading;
    final isAppointment = _queryType == LegalQueryType.bookAppointment;

    return Scaffold(
      appBar: CustomAppBar(title: 'Raise a Legal Support Query'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomDropdownField<LegalQueryType>(
              label: 'Query type',
              hint: 'Select type',
              value: _queryType,
              items: LegalQueryType.values,
              itemBuilder: (v) => v.displayName,
              onChanged: (v) {
                if (v == null) return;

                setState(() {
                  _queryType = v;
                  _commonQuery = null;

                  if (v == LegalQueryType.bookAppointment) {
                    _legalType = null;
                  } else {
                    _appointmentMode = null;
                    _preferredDate = null;
                    _preferredTime = null;
                    _preferredDateController.clear();
                    _preferredTimeController.clear();
                  }
                });
              },
            ),
            height(16),
            CustomDropdownField<String>(
              label: 'Common query',
              hint: 'Select query',
              value: _commonQuery,
              items: _commonQueryOptions,
              itemBuilder: (v) => v,
              onChanged: (v) => setState(() => _commonQuery = v),
            ),
            if (_showLegalType) ...[
              height(16),
              CustomDropdownField<LegalType>(
                label: 'Legal type',
                hint: 'Select legal type',
                value: _legalType,
                items: LegalType.values,
                itemBuilder: (v) => v.displayName,
                onChanged: (v) => setState(() => _legalType = v),
              ),
            ],
            if (isAppointment) ...[
              height(16),
              CustomDropdownField<AppointmentMode>(
                label: 'Mode of appointment',
                hint: 'Select mode',
                value: _appointmentMode,
                items: AppointmentMode.values,
                itemBuilder: (v) => v.displayName,
                onChanged: (v) => setState(() => _appointmentMode = v),
              ),
              height(16),
              Row(
                children: [
                  Expanded(
                    child: CustomDatePicker(
                      label: 'Preferred date',
                      hint: 'Select preferred date',
                      controller: _preferredDateController,
                      onTap: _pickDate,
                      isRequired: true,
                    ),
                  ),
                  width(12),
                  Expanded(
                    child: CustomTimePicker(
                      label: 'Preferred time',
                      hint: 'Select preferred time',
                      controller: _preferredTimeController,
                      onTap: _pickTime,
                      isRequired: true,
                    ),
                  ),
                ],
              ),
            ],
            height(16),
            CustomDropdownField<PriorityLevel>(
              label: 'Priority',
              hint: 'Select type',
              value: _priority,
              items: PriorityLevel.values,
              itemBuilder: (v) => v.displayName,
              onChanged: (v) => setState(() => _priority = v),
            ),
            height(16),
            CustomTextField(
              isRequired: false,
              label: 'Describe your query',
              hint: "Tell us what's going on…",
              maxLines: 5,
              controller: _detailsController,
            ),
            height(16),
            CustomAttachmentField(
              label: 'Attach document (optional)',
              hint: 'Choose file',
              controller: _attachmentController,
              onTap: _pickFile,
              isRequired: false,
            ),
            height(24),
            Center(
              child: PrimaryButton(
                gradient: LinearGradient(
                  colors: [AppColors.newPri, AppColors.primary],
                ),
                borderRadius: 25,
                text: 'Submit Ticket',
                height: 50,
                width: 180,
                fontSize: 14,
                isLoading: isSubmitting,
                onPressed: isSubmitting ? null : _submit,
              ),
            ),
            height(50),
          ],
        ),
      ),
    );
  }
}
