import 'dart:math';
import 'package:Doctors_App/features/helpdesk/model/suppport_enums.dart';
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
class AddServiceTicketScreen extends StatefulWidget {
  const AddServiceTicketScreen({super.key});

  @override
  State<AddServiceTicketScreen> createState() => _AddServiceTicketScreenState();
}

class _AddServiceTicketScreenState extends State<AddServiceTicketScreen> {
  final _detailsController = TextEditingController();
  final _attachmentController = TextEditingController();

  ServiceRelatedTo _relatedTo = ServiceRelatedTo.renewal;
  String? _commonQuery;
  PreferredContact? _preferredContact;
  PriorityLevel? _priority;
  PlatformFile? _selectedFile;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _detailsController.dispose();
    _attachmentController.dispose();
    super.dispose();
  }

  List<String> get _commonQueryOptions => kServiceCommonQueries[_relatedTo]!;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedFile = result.files.first;
        _attachmentController.text = _selectedFile!.name;
      });
    }
  }

  void _submit() {
    if (_commonQuery == null || _preferredContact == null || _priority == null) {
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

    setState(() => _isSubmitting = true);

    final ref = 'SS-2026-0${100 + Random().nextInt(899)}';
    final ticket = SupportTicket(
      ref: ref,
      typeLabel: '${_relatedTo.displayName} — $_commonQuery',
      priority: _priority!.displayName,
      status: TicketStatus.open,
      description: _detailsController.text.trim(),
      raisedAt: DateTime.now(),
    );

    // TODO: replace with a real call, e.g.
    // ref.read(helpViewModelProvider.notifier).registerServiceTicket(...)
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      Navigator.pop(context, ticket);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Raise a Service Support Query'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomDropdownField<ServiceRelatedTo>(
              label: 'Related to',
              hint: 'Select type',
              value: _relatedTo,
              items: ServiceRelatedTo.values,
              itemBuilder: (v) => v.displayName,
              onChanged: (v) {
                if (v == null) return;
                setState(() {
                  _relatedTo = v;
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
            height(16),
            CustomDropdownField<PreferredContact>(
              label: 'Preferred contact',
              hint: 'Select type',
              value: _preferredContact,
              items: PreferredContact.values,
              itemBuilder: (v) => v.displayName,
              onChanged: (v) => setState(() => _preferredContact = v),
            ),
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