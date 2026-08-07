import 'package:Doctors_App/features/helpdesk/model/service_ticket_model.dart';
import 'package:Doctors_App/theme/app_theme.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/values/app_text_style.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../theme/app_colors.dart';

class TicketStatusBadge extends StatelessWidget {
  final TicketStatus status;

  const TicketStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: status.color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(status.icon, size: 14, color: status.color),
          width(6),
          Text(
            status.label,
            style: customTextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: status.color,
            ),
          ),
        ],
      ),
    );
  }
}

class TicketCard extends StatelessWidget {
  final SupportTicket ticket;
  final VoidCallback onView;
  final VoidCallback onRemarks;
  final VoidCallback? onEdit;
  final VoidCallback? onCancel;

  const TicketCard({
    super.key,
    required this.ticket,
    required this.onView,
    required this.onRemarks,
    this.onEdit,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final editable = ticket.isEditable;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ticket.status.color.withValues(alpha: 0.3),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: (isDark ? Colors.black : Colors.grey.shade300).withValues(
              alpha: 0.25,
            ),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TicketStatusBadge(status: ticket.status),
              Spacer(),
              Text(
                ticket.ref,
                style: customTextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
                ),
              ),
            ],
          ),
          height(10),
          if (ticket.category != null) ...[
            Container(
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                ticket.category!,
                style: customTextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
          Text(
            ticket.typeLabel,
            style: customTextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          height(4),
          Text(
            '${ticket.priority} Priority',
            style: customTextStyle(
              fontSize: 11,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          ),
          height(6),
          Text(
            ticket.description,
            style: customTextStyle(
              fontSize: 12,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (editable) ...[
            height(8),
            Text(
              'Editable ${ticket.editableHoursLeft}h more',
              style: customTextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.newPri,
              ),
            ),
          ],
          height(5),
          Divider(color: isDark ? Colors.grey.shade800 : Colors.grey.shade200),
          // height(5),
          Row(
            children: [
              // Icon(
              //   Icons.access_time_rounded,
              //   size: 14,
              //   color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
              // ),
              // width(6),
              // Text(
              //   ticket.raisedAgo,
              //   style: customTextStyle(
              //     fontSize: 12,
              //     color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
              //   ),
              // ),
              // Spacer(),
              Wrap(
                spacing: 10,
                // crossAxisAlignment: CrossAxisAlignment.space,
                runSpacing: 4,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      side: BorderSide(
                        color: AppColors.fieldGrey.withValues(alpha: 0.6),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                    ),
                    onPressed: onView,
                    child: Text('View', style: customTextStyle()),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      side: BorderSide(
                        color: AppColors.fieldGrey.withValues(alpha: 0.6),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                    ),
                    onPressed: onRemarks,
                    child: Text(
                      ticket.remarks.isEmpty
                          ? 'Remarks'
                          : 'Remarks (${ticket.remarks.length})',
                      style: customTextStyle(),
                    ),
                  ),
                  if (editable && onEdit != null)
                    TextButton(
                      style: TextButton.styleFrom(
                        side: BorderSide(
                          color: AppColors.fieldGrey.withValues(alpha: 0.6),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                      ),
                      onPressed: onEdit,
                      child: Text('Edit', style: customTextStyle()),
                    ),
                  if (editable && onCancel != null)
                    TextButton(
                      style: TextButton.styleFrom(
                        side: BorderSide(
                          color: AppColors.fieldGrey.withValues(alpha: 0.6),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                      ),
                      onPressed: onCancel,
                      child: Text(
                        'Cancel',
                        style: customTextStyle(color: Colors.red.shade400),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Bottom sheet: read-only ticket detail.
Future<void> showTicketDetailSheet(BuildContext context, SupportTicket t) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) => Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(t.ref, style: AppTheme.title16),
              width(10),
              TicketStatusBadge(status: t.status),
            ],
          ),
          height(16),
          _detailRow('Type', t.typeLabel),
          if (t.category != null) _detailRow('Category', t.category!),
          _detailRow('Priority', t.priority),
          _detailRow('Raised', t.raisedAgo),
          height(10),
          Text('Description', style: AppTheme.title14),
          height(4),
          Text(t.description, style: AppTheme.label12),
          height(20),
        ],
      ),
    ),
  );
}

Widget _detailRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: customTextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: customTextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}

/// Bottom sheet: edit priority + description (only for editable tickets).
Future<void> showTicketEditSheet(
  BuildContext context,
  SupportTicket t,
  List<String> priorities,
  void Function(String priority, String description) onSave,
) {
  final descController = TextEditingController(text: t.description);
  String priority = t.priority;

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setState) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Edit Ticket · ${t.ref}', style: AppTheme.title16),
            height(16),
            DropdownButtonFormField<String>(
              initialValue: priority,
              decoration: const InputDecoration(labelText: 'Priority'),
              items: priorities
                  .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                  .toList(),
              onChanged: (v) => setState(() => priority = v ?? priority),
            ),
            height(12),
            TextField(
              controller: descController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            height(20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  onSave(priority, descController.text.trim());
                  Navigator.pop(ctx);
                },
                child: const Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Bottom sheet: remarks / communication thread with reply box.
Future<void> showRemarksSheet(
  BuildContext context,
  SupportTicket t,
  void Function(String message) onSend,
) {
  final inputController = TextEditingController();

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setState) => Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
        ),
        child: SizedBox(
          height: MediaQuery.of(ctx).size.height * 0.75,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text('${t.ref} · Remarks', style: AppTheme.title16),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(ctx),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: t.remarks.isEmpty
                    ? Center(
                        child: Text(
                          'No remarks yet — start the conversation below.',
                          style: AppTheme.label12,
                        ),
                      )
                    : ListView.builder(
                        itemCount: t.remarks.length,
                        itemBuilder: (_, i) {
                          final r = t.remarks[i];
                          return Align(
                            alignment: r.isTeam
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              padding: const EdgeInsets.all(12),
                              constraints: const BoxConstraints(maxWidth: 280),
                              decoration: BoxDecoration(
                                color: r.isTeam
                                    ? Colors.grey.shade100
                                    : AppColors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    r.isTeam
                                        ? (r.teamRole ?? 'Support Team')
                                        : 'You',
                                    style: customTextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  height(4),
                                  Text(r.message, style: AppTheme.label12),
                                  if (r.attachmentName != null) ...[
                                    height(6),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.attach_file_rounded,
                                          size: 14,
                                        ),
                                        width(4),
                                        Flexible(
                                          child: Text(
                                            r.attachmentName!,
                                            style: customTextStyle(
                                              fontSize: 11,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
              height(8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: inputController,
                      decoration: const InputDecoration(
                        hintText: 'Write a remark…',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                  ),
                  width(8),
                  IconButton(
                    onPressed: () {
                      final text = inputController.text.trim();
                      if (text.isEmpty) return;
                      onSend(text);
                      inputController.clear();
                      setState(() {});
                    },
                    icon: Icon(Icons.send_rounded, color: AppColors.newPri),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
