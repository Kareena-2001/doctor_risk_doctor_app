import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/values/app_text_style.dart';
import '../../../../core/widgets/app_dialog.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../routing/routes.dart';
import '../../../../theme/app_colors.dart';
import '../../../common/ui/widgets/loading.dart';
import '../../../common/ui/widgets/secondary_button.dart';
import '../../model/query_detail_model.dart';
import '../view_model/help_view_model.dart';

class QueryDetailsScreen extends ConsumerStatefulWidget {
  final String queryId;

  const QueryDetailsScreen({super.key, required this.queryId});

  @override
  ConsumerState<QueryDetailsScreen> createState() => _QueryDetailsScreenState();
}

class _QueryDetailsScreenState extends ConsumerState<QueryDetailsScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(helpViewModelProvider.notifier).fetchQueryDetail(widget.queryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = ref.watch(helpViewModelProvider);

    if (state.isFetchingQueryDetail) {
      return const Scaffold(
        appBar: CustomAppBar(title: 'Query Details'),
        body: Center(child: Loading()),
      );
    }

    if (state.queryDetailError != null) {
      return Scaffold(
        appBar: CustomAppBar(title: 'Query Details'),
        body: Center(
          child: Text(
            state.queryDetailError!,
            style: customTextStyle(color: Colors.red),
          ),
        ),
      );
    }

    final query = state.queryDetail;
    if (query == null) {
      return const Scaffold(
        appBar: CustomAppBar(title: 'Query Details'),
        body: Center(child: Text('No query details found')),
      );
    }

    final statusColor = _getStatusColor(query.ticketStatus);

    return Scaffold(
      appBar: CustomAppBar(title: 'Query Details'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(query, statusColor, isDark),
            height(24),
            _buildQuerySection(query, isDark),
            height(20),
            _buildReplySection(query, isDark),
            height(20),
            _buildHelpButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildQuerySection(QueryDetailItem query, bool isDark) {
    return _buildSection(
      title: 'Your Query',
      icon: Icons.help_outline_rounded,
      isDark: isDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('Category', query.category, isDark),
          height(10),
          _buildInfoRow('Question', query.question, isDark),
          height(10),
          _buildInfoRow('Description', query.description, isDark),
          if (query.userAttachment != null &&
              query.userAttachment!.isNotEmpty) ...[
            height(10),
            // _buildInfoRow('Attachment', query.userAttachment!, isDark),
            _buildAttachment('Attachment', query.userAttachment!, isDark),
          ],
        ],
      ),
    );
  }

  Widget _buildReplySection(QueryDetailItem query, bool isDark) {
    if (query.replied == null || query.replied!.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.orange.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            const Icon(Icons.pending_rounded, color: Colors.orange, size: 24),
            width(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Waiting for Response',
                    style: customTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  height(4),
                  Text(
                    'Our support team is reviewing your query',
                    style: customTextStyle(
                      fontSize: 12,
                      color: isDark
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return _buildSection(
      title: 'Admin Response',
      icon: Icons.replay,
      isDark: isDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('Admin Reply', query.replied!, isDark),
          height(10),
          _buildInfoRow('Reply Date', query.repliedDate ?? 'N/A', isDark),
          if (query.replyAttachment != null &&
              query.replyAttachment!.isNotEmpty) ...[
            height(10),
            // _buildInfoRow('Attachment', query.replyAttachment!, isDark),
            _buildAttachment('Attachment', query.replyAttachment!, isDark),
          ],
        ],
      ),
    );
  }

  Widget _buildHelpButton(BuildContext context) {
    return SecondaryButton(
      textColor: AppColors.primary,
      text: 'Need More Help?',
      icon: const Icon(Icons.help_outline_rounded, color: AppColors.primary),
      onPressed: () {
        _showNeedMoreHelpDialog(context);
      },
    );
  }

  Widget _buildHeader(QueryDetailItem query, Color statusColor, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            statusColor.withValues(alpha: 0.15),
            statusColor.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: statusColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.confirmation_number_rounded,
                color: statusColor,
                size: 24,
              ),
              width(10),
              Expanded(
                child: Text(
                  query.ticketNumber,
                  style: customTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  query.ticketStatus.toUpperCase(),
                  style: customTextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          height(12),
          Text(
            'Submitted: ${query.querySubmit}',
            style: customTextStyle(
              fontSize: 12,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required bool isDark,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: AppColors.primary),
            width(8),
            Text(
              title,
              style: customTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
        height(12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
            ),
          ),
          child: child,
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: customTextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
          ),
        ),
        height(6),
        Text(
          value,
          style: customTextStyle(
            fontSize: 13,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildAttachment(String label, String url, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: customTextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
          ),
        ),
        height(6),
        InkWell(
          onTap: () async {
            final uri = Uri.parse(url);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            }
          },
          child: Text(
            'View Attachment',
            style: customTextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.blue,
            ).copyWith(decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }

  void _showNeedMoreHelpDialog(BuildContext context) {
    AppDialog.confirm(
      context: context,
      title: 'Need More Help?',
      message:
          'Would you like to submit a follow-up query or contact support directly?',
      cancelText: 'Cancel',
      confirmText: 'Submit New Query',
      onConfirm: () {
        context.pop();
        context.push(Routes.addSupport);
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'in progress':
      case 'inprogress':
        return Colors.blue;
      case 'resolved':
        return Colors.green;
      case 'closed':
        return Colors.grey;
      default:
        return Colors.orange;
    }
  }
}
