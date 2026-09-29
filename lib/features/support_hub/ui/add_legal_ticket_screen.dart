import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_dropdown_field.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/custom_attachment_field.dart';
import '../../../theme/app_colors.dart';
import '../../common/ui/widgets/primary_button.dart';
import '../model/service_ticket_model.dart';
import '../model/support_ticket_enums.dart';
import '../model/suppport_enums.dart';

class AddLegalTicketScreen extends StatefulWidget {
  const AddLegalTicketScreen({super.key});

  @override
  State<AddLegalTicketScreen> createState() => _AddLegalTicketScreenState();
}

class _AddLegalTicketScreenState extends State<AddLegalTicketScreen> {
  final _detailsController = TextEditingController();
  final _attachmentController = TextEditingController();

  LegalQueryType _queryType = LegalQueryType.registerQuery;
  String? _commonQuery;
  AppointmentMode? _appointmentMode;
  DateTime? _preferredDate;
  TimeOfDay? _preferredTime;
  PriorityLevel? _priority;
  PlatformFile? _selectedFile;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _detailsController.dispose();
    _attachmentController.dispose();
    super.dispose();
  }

  List<String> get _commonQueryOptions => kLegalCommonQueries[_queryType]!;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedFile = result.files.first;
        _attachmentController.text = _selectedFile!.name;
      });
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _preferredDate = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) setState(() => _preferredTime = picked);
  }

  String? _mapCategory() {
    final q = _commonQuery ?? '';
    if (q.contains('Notice')) return 'Notice';
    if (_queryType == LegalQueryType.bookAppointment) return 'Case';
    return 'Consultation';
  }

  void _submit() {
    if (_commonQuery == null || _priority == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }
    if (_detailsController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please describe your query')),
      );
      return;
    }
    if (_queryType == LegalQueryType.bookAppointment &&
        (_appointmentMode == null ||
            _preferredDate == null ||
            _preferredTime == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete the appointment details'),
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final ref = 'LS-2026-0${100 + Random().nextInt(899)}';
    var description = _detailsController.text.trim();
    if (_queryType == LegalQueryType.bookAppointment) {
      final time = _preferredTime!.format(context);
      description =
          'Mode: ${_appointmentMode!.displayName}\n'
          'Preferred Date: ${_preferredDate!.day}/${_preferredDate!.month}/${_preferredDate!.year}\n'
          'Preferred Time: $time\n$description';
    }

    final ticket = SupportTicket(
      ref: ref,
      typeLabel: '${_queryType.displayName} — $_commonQuery',
      category: _mapCategory(),
      priority: _priority!.displayName,
      status: TicketStatus.open,
      description: description,
      raisedAt: DateTime.now(),
    );

    // TODO: replace with a real call, e.g.
    // ref.read(helpViewModelProvider.notifier).registerLegalTicket(...)
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      Navigator.pop(context, ticket);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    child: OutlinedButton.icon(
                      onPressed: _pickDate,
                      icon: const Icon(Icons.calendar_today_rounded, size: 16),
                      label: Text(
                        _preferredDate == null
                            ? 'Preferred date'
                            : '${_preferredDate!.day}/${_preferredDate!.month}/${_preferredDate!.year}',
                      ),
                    ),
                  ),
                  width(12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _pickTime,
                      icon: const Icon(Icons.access_time_rounded, size: 16),
                      label: Text(
                        _preferredTime == null
                            ? 'Preferred time'
                            : _preferredTime!.format(context),
                      ),
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
            ),
            height(24),
            PrimaryButton(
              backgroundColor: AppColors.newPri,
              text: 'Submit Ticket',
              onPressed: _isSubmitting ? null : _submit,
            ),
          ],
        ),
      ),
    );
  }
}
