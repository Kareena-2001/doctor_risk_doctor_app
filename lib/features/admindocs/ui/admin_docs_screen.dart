import 'package:Doctors_App/features/admindocs/ui/viewmodel/admin_docs_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/dimensions.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../core/widgets/common_empty_state.dart';
import '../../../core/widgets/common_error_state.dart';
import '../../../extensions/build_context_extension.dart';

class AdminDocsScreen extends ConsumerWidget {
  const AdminDocsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final asyncState = ref.watch(adminDocsViewModelProvider);

    return asyncState.when(
      data: (state) => _buildContent(context, ref, state, isDark),
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stack) => CommonErrorState(
        icon: Icons.error_outline,
        title: 'Failed to load documents',
        message: error.toString(),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    dynamic state,
    bool isDark,
  ) {
    final docs = state.docs ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        height(10),
        Text(
          'Documents issued by admin for your review',
          style: customTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
          ),
        ),
        height(20),
        if (docs.isEmpty)
          CommonEmptyState(
            icon: Icons.folder_open_outlined,
            title: 'No documents available',
            message: 'Documents issued by admin will appear here',
          )
        else
          ...docs.asMap().entries.map((entry) {
            final index = entry.key;
            final doc = entry.value;
            return _buildAnimatedCard(
              delay: index * 100,
              isDark: isDark,
              child: InkWell(
                onTap: () => _openDocument(context, doc.fileUrl),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _getDocColor(
                        doc.letterType,
                      ).withValues(alpha: 0.3),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _getDocColor(
                          doc.letterType,
                        ).withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: _getDocColor(
                            doc.letterType,
                          ).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          _getDocIcon(doc.letterType),
                          size: 26,
                          color: _getDocColor(doc.letterType),
                        ),
                      ),
                      width(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doc.letterType,
                              style: customTextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                            height(6),
                            Text(
                              doc.fileSendDate,
                              style: customTextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: isDark
                                    ? Colors.grey.shade400
                                    : Colors.grey.shade600,
                              ),
                            ),
                            height(8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'View Document',
                                style: customTextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18,
                        color: isDark
                            ? Colors.grey.shade600
                            : Colors.grey.shade400,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
      ],
    );
  }

  Widget _buildAnimatedCard({
    required int delay,
    required Widget child,
    required bool isDark,
  }) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 500 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, _) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
    );
  }

  Future<void> _openDocument(BuildContext context, String url) async {
    try {
      // Convert Google Drive file URL to viewer URL if it's a Drive link
      String viewerUrl = url;

      if (url.contains('drive.google.com')) {
        // Extract file ID from various Google Drive URL formats
        String? fileId;

        if (url.contains('/file/d/')) {
          fileId = url.split('/file/d/')[1].split('/')[0];
        } else if (url.contains('id=')) {
          fileId = Uri.parse(url).queryParameters['id'];
        }

        if (fileId != null) {
          // Use Google Drive viewer URL that opens in Drive app
          viewerUrl = 'https://drive.google.com/file/d/$fileId/view';
        }
      }

      final uri = Uri.parse(viewerUrl);
      if (await canLaunchUrl(uri)) {
        // Use platformDefault mode to open in Drive app on mobile
        await launchUrl(uri, mode: LaunchMode.platformDefault);
      } else {
        if (context.mounted) {
          context.showErrorSnackBar('Unable to open document');
        }
      }
    } catch (e) {
      if (context.mounted) {
        context.showErrorSnackBar('Error opening document: $e');
      }
    }
  }

  Color _getDocColor(String letterType) {
    final type = letterType.toLowerCase();
    if (type.contains('esic')) return Colors.green;
    if (type.contains('experience')) return Colors.blue;
    if (type.contains('insurance')) return Colors.orange;
    if (type.contains('relieving')) return Colors.purple;
    if (type.contains('warning')) return Colors.red;
    return Colors.indigo;
  }

  IconData _getDocIcon(String letterType) {
    final type = letterType.toLowerCase();
    if (type.contains('esic')) return Icons.medical_services_rounded;
    if (type.contains('experience')) return Icons.work_history_rounded;
    if (type.contains('insurance')) return Icons.medical_services_outlined;
    if (type.contains('relieving')) return Icons.description_rounded;
    if (type.contains('warning')) return Icons.warning_amber_rounded;
    return Icons.description_rounded;
  }
}
