import 'dart:io';
import 'package:Doctors_App/core/widgets/custom_attachment_field.dart';
import 'package:Doctors_App/core/widgets/custom_dropdown_field.dart';
import 'package:Doctors_App/core/widgets/custom_text_field.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/helpdesk/ui/state/help_state.dart';
import 'package:Doctors_App/features/helpdesk/ui/view_model/help_view_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../extensions/build_context_extension.dart';
import '../model/suppport_enums.dart';
import 'widgets/success_view.dart';

class RegisterQueryScreen extends ConsumerStatefulWidget {
  const RegisterQueryScreen({super.key});

  @override
  ConsumerState<RegisterQueryScreen> createState() =>
      _RegisterQueryScreenState();
}

class _RegisterQueryScreenState extends ConsumerState<RegisterQueryScreen> {
  final TextEditingController _detailsController = TextEditingController();

  QueryType? _queryType;
  RequestType? _requestType;
  PriorityLevel? _priority;
  PlatformFile? _selectedFile;
  bool isSubmitted = false;

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<HelpState>(helpViewModelProvider, (prev, next) {
      if (prev?.isSuccess == false && next.isSuccess) {
        context.showSuccessSnackBar('Query submitted successfully');
        setState(() => isSubmitted = true);
      }
      if (next.error != null && next.error != prev?.error) {
        context.showErrorSnackBar(next.error!);
      }
    });

    final helpState = ref.watch(helpViewModelProvider);

    return Scaffold(
      appBar: CustomAppBar(title: 'Register / Request a Query'),
      body: isSubmitted
          ? const SuccessView()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomDropdownField<QueryType>(
                    label: 'Query Type',
                    hint: 'Select type',
                    value: _queryType,
                    items: QueryType.values,
                    itemBuilder: (v) => v.displayName,
                    onChanged: (v) => setState(() => _queryType = v),
                  ),
                  height(16),
                  CustomDropdownField<RequestType>(
                    label: 'Request Type',
                    value: _requestType,
                    hint: 'Select type',
                    items: RequestType.values,
                    itemBuilder: (v) => v.displayName,
                    onChanged: (v) => setState(() => _requestType = v),
                  ),
                  height(16),
                  CustomDropdownField<PriorityLevel>(
                    label: 'Priority',
                    value: _priority,
                    hint: 'Select type',
                    items: PriorityLevel.values,
                    itemBuilder: (v) => v.displayName,
                    onChanged: (v) => setState(() => _priority = v),
                  ),
                  height(16),
                  CustomTextField(
                    label: 'Details',
                    hint: 'Elaborate on your query...',
                    maxLines: 5,
                  ),
                  height(16),
                  // SupportAttachmentField(
                  //   selectedFile: _selectedFile,
                  //   onChanged: (f) => setState(() => _selectedFile = f),
                  // ),
                  CustomAttachmentField(
                    label: 'Attachments',
                    hint: 'Choose file',
                    controller: TextEditingController(),
                    onTap: () {},
                  ),
                  height(24),
                  PrimaryButton(
                    text: 'Submit Query',
                    onPressed: helpState.isLoading ? null : _submit,
                  ),
                ],
              ),
            ),
    );
  }

  void _submit() {
    if (_queryType == null || _requestType == null || _priority == null) {
      context.showErrorSnackBar('Please fill in all required fields');
      return;
    }
    ref
        .read(helpViewModelProvider.notifier)
        .registerQuery(
          queryType: _queryType!,
          requestType: _requestType!,
          priority: _priority!,
          details: _detailsController.text,
          userAttachment: _selectedFile?.path != null
              ? File(_selectedFile!.path!)
              : null,
        );
  }
}
