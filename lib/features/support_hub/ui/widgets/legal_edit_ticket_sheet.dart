import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/widgets/custom_dropdown_field.dart';
import 'package:Doctors_App/core/widgets/custom_text_field.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/support_hub/model/legal_ticket_model.dart';
import 'package:Doctors_App/features/support_hub/ui/view_model/support_hub_view_model.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:Doctors_App/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Returns true/false = update success/fail, null = dismissed.
Future<bool?> showLegalEditTicketSheet(
  BuildContext context,
  LegalTicket ticket,
) {
  return showModalBottomSheet<bool>(
    context: context,
    backgroundColor: context.primaryBackgroundColor,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => LegalEditTicketSheet(ticket: ticket),
  );
}

class LegalEditTicketSheet extends ConsumerStatefulWidget {
  final LegalTicket ticket;

  const LegalEditTicketSheet({super.key, required this.ticket});

  @override
  ConsumerState<LegalEditTicketSheet> createState() =>
      _LegalEditTicketSheetState();
}

class _LegalEditTicketSheetState extends ConsumerState<LegalEditTicketSheet> {
  static const _priorities = ['Normal', 'High', 'Urgent'];

  late final TextEditingController _descCtrl;
  late String _priority;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _descCtrl = TextEditingController(text: widget.ticket.description ?? '');
    _priority = _priorities.contains(widget.ticket.priority)
        ? widget.ticket.priority
        : _priorities.first;
  }

  @override
  void dispose() {
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_saving) return;
    setState(() => _saving = true);
    final ok = await ref
        .read(supportHubViewModelProvider.notifier)
        .updateTicket(
          id: widget.ticket.id.toString(),
          description: _descCtrl.text.trim(),
          priority: _priority,
        );
    if (mounted) Navigator.pop(context, ok);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Edit Ticket', style: AppTheme.title16),
              height(8),
              Text(
                'You can edit this ticket until it enters In Progress, or for 36 hours from when it was raised — whichever comes first.',
                style: AppTheme.subtitle12.copyWith(
                  color: context.secondaryTextColor,
                ),
              ),
              height(16),
              CustomDropdownField<String>(
                value: _priority,
                label: 'Priority',
                items: _priorities,
                onChanged: (v) => setState(() => _priority = v ?? _priority),
              ),
              height(12),
              CustomTextField(
                controller: _descCtrl,
                maxLines: 4,
                label: 'Description',
              ),
              height(20),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  height: 50,
                  fontSize: 14,
                  gradient: LinearGradient(
                    colors: [AppColors.newPri, AppColors.primary],
                  ),
                  text: _saving ? 'Saving...' : 'Save Changes',
                  onPressed: _save,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
