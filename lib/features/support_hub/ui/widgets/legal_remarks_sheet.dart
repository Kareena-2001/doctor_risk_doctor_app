import 'dart:io';

import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/custom_text_field.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/common/ui/widgets/loading.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/support_hub/model/legal_ticket_model.dart';
import 'package:Doctors_App/features/support_hub/model/ticket_item.dart';
import 'package:Doctors_App/features/support_hub/ui/view_model/support_hub_view_model.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:Doctors_App/theme/app_theme.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

/// Call this from a tap handler (not from build/initState).
void showLegalRemarksSheet(
  BuildContext context,
  WidgetRef ref,
  TicketItem ticket,
) {
  ref
      .read(supportHubViewModelProvider.notifier)
      .fetchRemarks(id: ticket.id.toString());

  showModalBottomSheet<void>(
    context: context,
    backgroundColor: context.primaryBackgroundColor,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => LegalRemarksSheet(ticket: ticket),
  );
}

enum _AttachType {
  image('Attach Image', FileType.image, null),
  pdf('Attach PDF', FileType.custom, ['pdf']),
  word('Attach Word Doc', FileType.custom, ['doc', 'docx']),
  audio('Attach Audio', FileType.audio, null),
  video('Attach Video', FileType.video, null);

  const _AttachType(this.label, this.fileType, this.extensions);

  final String label;
  final FileType fileType;
  final List<String>? extensions;
}

/// API sends "Name - Role" (e.g. "Test - Legal Team", "Dr. X - You").
({String name, String role}) _splitSender(String raw) {
  final i = raw.lastIndexOf(' - ');
  if (i == -1) return (name: raw.trim(), role: '');
  return (name: raw.substring(0, i).trim(), role: raw.substring(i + 3).trim());
}

class LegalRemarksSheet extends ConsumerStatefulWidget {
  final TicketItem ticket;

  const LegalRemarksSheet({super.key, required this.ticket});

  @override
  ConsumerState<LegalRemarksSheet> createState() => _LegalRemarksSheetState();
}

class _LegalRemarksSheetState extends ConsumerState<LegalRemarksSheet> {
  final _ctrl = TextEditingController();
  final ScrollController _remarksScrollController = ScrollController();
  File? _file;
  String? _remarkError;

  @override
  void initState() {
    super.initState();
    _remarksScrollController.addListener(_loadMoreWhenNearEnd);
    _ctrl.addListener(() {
      if (_remarkError != null && _ctrl.text.trim().isNotEmpty) {
        setState(() => _remarkError = null);
      }
    });
    _scheduleRemarksCheck();
  }

  @override
  void dispose() {
    _remarksScrollController
      ..removeListener(_loadMoreWhenNearEnd)
      ..dispose();
    _ctrl.dispose();
    super.dispose();
  }

  void _scheduleRemarksCheck() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _loadMoreWhenNearEnd();
    });
  }

  void _loadMoreWhenNearEnd() {
    if (!_remarksScrollController.hasClients ||
        !ref.read(supportHubViewModelProvider.notifier).hasMoreRemarks ||
        ref.read(supportHubViewModelProvider).isFetchingRemarks ||
        ref.read(supportHubViewModelProvider).remarksError != null) {
      return;
    }
    if (_remarksScrollController.position.extentAfter < 200) {
      ref.read(supportHubViewModelProvider.notifier).loadMoreRemarks();
    }
  }

  Future<void> _pick(_AttachType type) async {
    final result = await FilePicker.platform.pickFiles(
      type: type.fileType,
      allowedExtensions: type.extensions,
    );
    final path = result?.files.single.path;
    if (path == null || !mounted) return;
    setState(() => _file = File(path));
  }

  Future<void> _send() async {
    final text = _ctrl.text.trim();
    if (text.isEmpty) {
      setState(() => _remarkError = 'Please enter a remark');
      return;
    }

    final ok = await ref
        .read(supportHubViewModelProvider.notifier)
        .addRemark(
          ticketId: widget.ticket.id.toString(),
          remark: text,
          file: _file,
        );
    if (!mounted) return;
    if (ok) {
      _ctrl.clear();
      setState(() => _file = null);
    } else {
      context.showErrorSnackBar('Failed to send remark');
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(supportHubViewModelProvider);
    final remarks = state.ticketRemarks?.data.remarks ?? const [];
    final media = MediaQuery.of(context);
    _scheduleRemarksCheck();

    return Padding(
      padding: EdgeInsets.only(bottom: media.viewInsets.bottom),
      child: SizedBox(
        height: (media.size.height - media.viewInsets.bottom) * 0.85,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 12, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(ticket: widget.ticket),
                height(12),
                Expanded(
                  child: state.isFetchingRemarks && remarks.isEmpty
                      ? Loading()
                      : remarks.isEmpty
                      ? Center(
                          child: state.remarksError != null
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      state.remarksError!,
                                      style: AppTheme.label12,
                                      textAlign: TextAlign.center,
                                    ),
                                    TextButton(
                                      onPressed: () => ref
                                          .read(
                                            supportHubViewModelProvider
                                                .notifier,
                                          )
                                          .fetchRemarks(
                                            id: widget.ticket.id.toString(),
                                          ),
                                      child: const Text('Retry'),
                                    ),
                                  ],
                                )
                              : Text(
                                  'No remarks yet — start the conversation below.',
                                  style: AppTheme.label12,
                                ),
                        )
                      : ListView.separated(
                          controller: _remarksScrollController,
                          padding: const EdgeInsets.only(right: 8),
                          itemCount:
                              remarks.length +
                              ((ref
                                          .read(
                                            supportHubViewModelProvider
                                                .notifier,
                                          )
                                          .hasMoreRemarks ||
                                      state.remarksError != null)
                                  ? 1
                                  : 0),
                          separatorBuilder: (_, _) => height(10),
                          itemBuilder: (_, i) {
                            if (i == remarks.length) {
                              if (state.remarksError != null) {
                                return Center(
                                  child: TextButton(
                                    onPressed: ref
                                        .read(
                                          supportHubViewModelProvider.notifier,
                                        )
                                        .loadMoreRemarks,
                                    child: const Text(
                                      'Could not load more remarks. Tap to retry.',
                                    ),
                                  ),
                                );
                              }
                              return state.isFetchingRemarks
                                  ? const Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : const SizedBox.shrink();
                            }
                            final r = remarks[i];
                            final sender = _splitSender(r.senderName);
                            return _RemarkCard(
                              name: sender.name,
                              role: sender.role,
                              isTeam: sender.role.toLowerCase() != 'you',
                              remark: r.remark.trim(),
                              dateTime: r.dateTime,
                              attachment: r.attachment,
                            );
                          },
                        ),
                ),
                const Divider(height: 24),
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        label: 'Add a remark',
                        controller: _ctrl,
                        hint: 'Type your update or question here…',
                        maxLines: 3,
                      ),
                      if (_remarkError != null) ...[
                        height(4),
                        Text(
                          _remarkError!,
                          style: customTextStyle(
                            fontSize: 11,
                            color: Colors.red.shade400,
                          ),
                        ),
                      ],
                      height(10),
                      Text(
                        'Attachment (optional)',
                        style: customTextStyle(
                          fontSize: 11,
                          color: context.secondaryTextColor,
                        ),
                      ),
                      height(6),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final t in _AttachType.values)
                            _AttachChip(label: t.label, onTap: () => _pick(t)),
                        ],
                      ),
                      if (_file != null) ...[
                        height(10),
                        _SelectedFile(
                          name: _file!.path.split(Platform.pathSeparator).last,
                          onRemove: () => setState(() => _file = null),
                        ),
                      ],
                      height(14),
                      SizedBox(
                        width: double.infinity,
                        child: PrimaryButton(
                          height: 50,
                          fontSize: 14,
                          gradient: LinearGradient(
                            colors: [AppColors.newPri, AppColors.primary],
                          ),
                          text: state.isLoading ? 'Sending...' : 'Send Remark',
                          onPressed: state.isLoading ? () {} : _send,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final TicketItem ticket;

  const _Header({required this.ticket});

  @override
  Widget build(BuildContext context) {
    final desc = ticket.description ?? '';
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(ticket.ticketNo, style: AppTheme.title16),
                    if (ticket.typeValue != null)
                      _Pill(
                        text: ticket.typeValue!.toUpperCase(),
                        background: AppColors.primary.withValues(alpha: 0.1),
                        color: AppColors.primary,
                      ),
                  ],
                ),
                if (desc.isNotEmpty) ...[
                  height(4),
                  Text(
                    desc,
                    style: customTextStyle(
                      fontSize: 12,
                      color: context.secondaryTextColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(20),
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: Icon(Icons.close_rounded, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class _RemarkCard extends StatelessWidget {
  final String name;
  final String role;
  final bool isTeam;
  final String remark;
  final String dateTime;
  final String? attachment;

  const _RemarkCard({
    required this.name,
    required this.role,
    required this.isTeam,
    required this.remark,
    required this.dateTime,
    this.attachment,
  });

  Future<void> _openAttachment(BuildContext context) async {
    final uri = Uri.tryParse(attachment ?? '');
    if (uri == null) {
      context.showErrorSnackBar('Invalid attachment URL');
      return;
    }
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && context.mounted) {
      context.showErrorSnackBar('Could not open attachment');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasAttachment = attachment != null && attachment!.isNotEmpty;

    final cardColor = isTeam
        ? AppColors.primary.withValues(alpha: 0.12)
        : (isDark ? Colors.grey.shade800 : Colors.grey.shade100);
    final accent = isTeam ? AppColors.primary : Colors.grey.shade400;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10),
        border: Border(left: BorderSide(color: accent, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: customTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (role.isNotEmpty) ...[
                width(6),
                _Pill(
                  text: role.toUpperCase(),
                  background: isTeam ? AppColors.primary : Colors.grey.shade300,
                  color: isTeam ? Colors.white : Colors.black87,
                ),
              ],
              const Spacer(),
              width(8),
              Text(
                dateTime,
                style: customTextStyle(
                  fontSize: 10,
                  color: context.secondaryTextColor,
                ),
              ),
            ],
          ),
          if (remark.isNotEmpty) ...[
            height(6),
            Text(remark, style: AppTheme.label12),
          ],
          if (hasAttachment) ...[
            height(6),
            InkWell(
              onTap: () => _openAttachment(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.attach_file_rounded,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  width(4),
                  Text(
                    'View attachment',
                    style: customTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String text;
  final Color background;
  final Color color;

  const _Pill({
    required this.text,
    required this.background,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: customTextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

class _AttachChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _AttachChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(
          label,
          style: customTextStyle(fontSize: 11, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _SelectedFile extends StatelessWidget {
  final String name;
  final VoidCallback onRemove;

  const _SelectedFile({required this.name, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.attach_file_rounded, size: 16, color: AppColors.primary),
          width(6),
          Expanded(
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: customTextStyle(fontSize: 12),
            ),
          ),
          InkWell(
            onTap: onRemove,
            child: const Icon(Icons.close_rounded, size: 16),
          ),
        ],
      ),
    );
  }
}
