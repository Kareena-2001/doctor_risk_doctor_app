import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/core/widgets/custom_attachment_field.dart';
import 'package:Doctors_App/core/widgets/custom_dropdown_field.dart';
import 'package:Doctors_App/core/widgets/custom_text_field.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/support_hub//model/suppport_enums.dart';
import 'package:Doctors_App/features/support_hub/model/support_ticket_enums.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'view_model/support_hub_view_model.dart';

class AddServiceTicketScreen extends ConsumerStatefulWidget {
  const AddServiceTicketScreen({super.key});

  @override
  ConsumerState<AddServiceTicketScreen> createState() =>
      _AddServiceTicketScreenState();
}

class _AddServiceTicketScreenState
    extends ConsumerState<AddServiceTicketScreen> {
  final _detailsController = TextEditingController();
  final _attachmentController = TextEditingController();

  ServiceRelatedTo _relatedTo = ServiceRelatedTo.renewal;
  String? _commonQuery;
  PreferredContact? _preferredContact;
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

  Future<void> _submit() async {
    if (_commonQuery == null ||
        _preferredContact == null ||
        _priority == null) {
      context.showErrorSnackBar('Please fill in all required fields');
      return;
    }
    if (_detailsController.text.trim().isEmpty) {
      context.showErrorSnackBar('Please describe your query');
      return;
    }

    final ok = await ref.read(supportHubViewModelProvider.notifier).addTicket(
          ticketType: 'service',
          queryType: _relatedTo.displayName,
          commonQuery: _commonQuery!,
          preferredContact: _preferredContact!.displayName,
          priority: _priority!.displayName,
          description: _detailsController.text.trim(),
          legalType: '',
        );

    if (ok && mounted) {
      final ticketNo =
          ref.read(supportHubViewModelProvider).tktNumber ?? '';
      if (mounted) {
        context.showSuccessSnackBar(
          ticketNo.isNotEmpty
              ? 'Service ticket raised — reference $ticketNo'
              : 'Service ticket raised successfully',
        );
        Navigator.pop(context, true);
      }
    } else if (mounted) {
      final err = ref.read(supportHubViewModelProvider).error;
      if (err != null) context.showErrorSnackBar(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSubmitting =
        ref.watch(supportHubViewModelProvider).isLoading;

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
              backgroundColor: AppColors
                  .newPri,
              text: 'Submit Ticket',
              onPressed: isSubmitting ? null : _submit,
            ),
          ],
        ),
      ),
    );
  }
}