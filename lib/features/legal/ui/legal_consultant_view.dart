import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/widgets/custom_seachbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../routing/routes.dart';
import '../../../theme/app_colors.dart';
import '../model/legal_consultant_model.dart';
import '../ui/view_model/cases_view_model.dart';

class LegalConsultantView extends ConsumerWidget {
  const LegalConsultantView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final casesList = ref.watch(casesProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: CustomAppBar(
        title: 'Legal Consultant',
        showRefresh: true,
        showBack: true,
        onRefresh: () {},
      ),
      body: Column(
        children: [
          height(12),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Responsive.sp(16)),
            child: CustomSearchBar(
              controller: TextEditingController(),
              hint: 'Search cases by complainant or type...',
              onChanged: (value) {},
            ),
          ),
          height(6),
          Expanded(
            child: casesList.isEmpty
                ? Center(
                    child: Text(
                      'No cases filed yet.',
                      style: customTextStyle(
                        fontSize: Responsive.sp(14),
                        color: Colors.grey.shade400,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.sp(16),
                      vertical: Responsive.sp(10),
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemCount: casesList.length,
                    itemBuilder: (context, index) {
                      final currentCase = casesList[index];
                      return _buildLegalCard(context, ref, currentCase);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: AppColors.newPri,
        onPressed: () => context.push(Routes.addLegalConsultant),
        child: const Icon(Icons.add, color: Colors.white, size: 26),
      ),
    );
  }

  Widget _buildLegalCard(
    BuildContext context,
    WidgetRef ref,
    CasesModel cases,
  ) {
    // Determine visual style based on notice type or mode
    final bool isSent = cases.noticeMode.toLowerCase() == 'send';
    final Color modeColor = isSent
        ? Colors.blue.shade700
        : Colors.purple.shade700;
    final Color modeBg = isSent ? Colors.blue.shade50 : Colors.purple.shade50;

    // Safety fallback for remarks count if list isn't initialized yet
    final remarksCount = cases.remarks.length ?? 0;
    final docsCount = cases.uploadedFiles.length;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: Responsive.sp(14)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Responsive.sp(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(Responsive.sp(16)),
          onTap: () => _showRemarksBottomSheet(context, ref, cases),
          child: Padding(
            padding: EdgeInsets.all(Responsive.sp(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header: Notice Category Type & Case Status Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.sp(10),
                        vertical: Responsive.sp(6),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.gavel_rounded,
                            size: Responsive.sp(14),
                            color: Colors.blueGrey.shade700,
                          ),
                          SizedBox(width: Responsive.sp(6)),
                          Text(
                            cases.noticeType.isNotEmpty
                                ? cases.noticeType
                                : 'Notice File',
                            style: customTextStyle(
                              fontSize: Responsive.sp(12),
                              fontWeight: FontWeight.w700,
                              color: Colors.blueGrey.shade900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildStatusBadge(cases.status),
                  ],
                ),
                height(12),

                // Notice Mode Indicator Flag & Case Creation Date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.sp(8),
                        vertical: Responsive.sp(4),
                      ),
                      decoration: BoxDecoration(
                        color: modeBg,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isSent
                                ? Icons.call_made_rounded
                                : Icons.call_received_rounded,
                            size: Responsive.sp(12),
                            color: modeColor,
                          ),
                          SizedBox(width: Responsive.sp(4)),
                          Text(
                            cases.noticeMode.toUpperCase(),
                            style: customTextStyle(
                              fontSize: Responsive.sp(10),
                              fontWeight: FontWeight.w800,
                              color: modeColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildInfoRow(
                      Icons.calendar_today_rounded,
                      cases.addedOn,
                      color: Colors.grey.shade600,
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: Responsive.sp(10)),
                  child: const Divider(
                    height: 1,
                    thickness: 0.5,
                    color: AppColors.divider,
                  ),
                ),

                // Primary Subject Information Fields
                Text(
                  cases.complainantName,
                  style: customTextStyle(
                    fontSize: Responsive.sp(15),
                    fontWeight: FontWeight.w700,
                    color: AppColors.textColor,
                  ),
                ),
                height(6),

                Row(
                  children: [
                    Expanded(
                      child: _buildInfoRow(
                        Icons.phone_android_rounded,
                        cases.complainantMobile,
                      ),
                    ),
                    // Expanded(
                    //   child: _buildInfoRow(
                    //     Icons.location_on_rounded,
                    //     cases.place,
                    //   ),
                    // ),
                  ],
                ),
                height(8),

                // Brief Contextual Description
                Text(
                  cases.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: customTextStyle(
                    fontSize: Responsive.sp(12),
                    color: Colors.grey.shade600,
                  ).copyWith(height: 1.3),
                ),
                height(14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Responsive.sp(8),
                            vertical: Responsive.sp(4),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber.shade50,
                            border: Border.all(
                              color: Colors.amber.shade200,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.attachment_rounded,
                                size: Responsive.sp(13),
                                color: Colors.amber.shade900,
                              ),
                              SizedBox(width: Responsive.sp(4)),
                              Text(
                                '$docsCount Docs',
                                style: customTextStyle(
                                  fontSize: Responsive.sp(11),
                                  fontWeight: FontWeight.w600,
                                  color: Colors.amber.shade900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: Responsive.sp(8)),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Responsive.sp(8),
                            vertical: Responsive.sp(4),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            border: Border.all(
                              color: Colors.blue.shade200,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.chat_bubble_outline_rounded,
                                size: Responsive.sp(13),
                                color: Colors.blue.shade900,
                              ),
                              SizedBox(width: Responsive.sp(4)),
                              Text(
                                '$remarksCount Remarks',
                                style: customTextStyle(
                                  fontSize: Responsive.sp(11),
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue.shade900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Updated: ${cases.updateOn}',
                      style: customTextStyle(
                        fontSize: Responsive.sp(11),
                        color: Colors.grey.shade500,
                      ),
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

  Widget _buildInfoRow(IconData icon, String text, {Color? color}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: Responsive.sp(15),
          color: color ?? Colors.grey.shade700,
        ),
        SizedBox(width: Responsive.sp(6)),
        Flexible(
          child: Text(
            text,
            style: customTextStyle(
              fontSize: Responsive.sp(12),
              color: color ?? AppColors.textColor,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    final lower = status.toLowerCase();
    Color bg, text;

    switch (lower) {
      case 'active':
        bg = Colors.amber.shade50;
        text = Colors.amber.shade700;
        break;
      case 'in-progress':
        bg = Colors.blue.shade50;
        text = Colors.blue.shade700;
        break;
      case 'closed':
        bg = Colors.red.shade50;
        text = Colors.red.shade700;
        break;
      default:
        bg = Colors.grey.shade100;
        text = Colors.grey.shade600;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.sp(10),
        vertical: Responsive.sp(4),
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.isNotEmpty ? status : 'N/A',
        style: customTextStyle(
          fontSize: Responsive.sp(11),
          fontWeight: FontWeight.w700,
          color: text,
        ),
      ),
    );
  }

  // Dual Action Overlay Panel: Contains form fields to append remarks and logs historical records directly
  void _showRemarksBottomSheet(
    BuildContext context,
    WidgetRef ref,
    CasesModel cases,
  ) {
    final TextEditingController remarkController = TextEditingController();
    final TextEditingController docNameController = TextEditingController();
    String attachedFileName = '';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return DraggableScrollableSheet(
              initialChildSize: 0.75,
              maxChildSize: 0.95,
              minChildSize: 0.5,
              expand: false,
              builder: (context, scrollController) {
                final currentRemarks = cases.remarks ?? [];

                return Column(
                  children: [
                    height(12),
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    height(16),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.sp(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Case History & Remarks',
                              style: customTextStyle(
                                fontSize: Responsive.sp(18),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close_rounded),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.grey.shade100,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: AppColors.divider),

                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        padding: EdgeInsets.all(Responsive.sp(20)),
                        children: [
                          // FORM INTERFACE: Add New Remark
                          Text(
                            'Add New Remark Log',
                            style: customTextStyle(
                              fontSize: Responsive.sp(14),
                              fontWeight: FontWeight.w700,
                              color: AppColors.textColor,
                            ),
                          ),
                          height(10),
                          TextField(
                            controller: remarkController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText:
                                  'Type details of update or next action steps...',
                              hintStyle: customTextStyle(
                                fontSize: Responsive.sp(13),
                                color: Colors.grey.shade400,
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade50,
                              contentPadding: const EdgeInsets.all(12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade200,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade200,
                                ),
                              ),
                            ),
                          ),
                          height(10),
                          TextField(
                            controller: docNameController,
                            decoration: InputDecoration(
                              hintText: 'Document Title (Optional)',
                              hintStyle: customTextStyle(
                                fontSize: Responsive.sp(13),
                                color: Colors.grey.shade400,
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade50,
                              prefixIcon: const Icon(
                                Icons.title_rounded,
                                size: 18,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade200,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade200,
                                ),
                              ),
                            ),
                          ),
                          height(10),

                          Row(
                            children: [
                              OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  side: BorderSide(
                                    color: AppColors.newPri.withValues(
                                      alpha: 0.5,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  setModalState(() {
                                    attachedFileName =
                                        "File_${DateTime.now().millisecondsSinceEpoch.toString().substring(9)}.pdf";
                                  });
                                },
                                icon: const Icon(
                                  Icons.cloud_upload_outlined,
                                  size: 16,
                                ),
                                label: Text(
                                  'Attach Document',
                                  style: customTextStyle(
                                    fontSize: Responsive.sp(12),
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.newPri,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              if (attachedFileName.isNotEmpty)
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.amber.shade50,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.insert_drive_file,
                                          size: 14,
                                          color: Colors.amber,
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            attachedFileName,
                                            style: customTextStyle(
                                              fontSize: Responsive.sp(11),
                                              color: Colors.amber.shade900,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () => setModalState(
                                            () => attachedFileName = '',
                                          ),
                                          child: const Icon(
                                            Icons.cancel,
                                            size: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          height(14),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.newPri,
                              minimumSize: const Size(double.infinity, 44),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              if (remarkController.text.trim().isEmpty) return;

                              // Wire up state updates using the new notifier method
                              ref
                                  .read(casesProvider.notifier)
                                  .addRemark(
                                    caseId: cases.id,
                                    remarkText: remarkController.text,
                                    documentName: docNameController.text,
                                    fileName: attachedFileName,
                                  );

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Operational log saved successfully.',
                                  ),
                                ),
                              );
                              Navigator.pop(
                                context,
                              ); // Dismiss sheet to reveal updated UI lists instantly
                            },
                            child: Text(
                              'Save Operational Log Entry',
                              style: customTextStyle(
                                color: Colors.white,
                                fontSize: Responsive.sp(13),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: Responsive.sp(20),
                            ),
                            child: const Divider(color: AppColors.divider),
                          ),

                          // DISPLAY INTERFACE: Historic Timeline List
                          Text(
                            'Historical Logs (${currentRemarks.length})',
                            style: customTextStyle(
                              fontSize: Responsive.sp(14),
                              fontWeight: FontWeight.w700,
                              color: AppColors.textColor,
                            ),
                          ),
                          height(12),

                          currentRemarks.isEmpty
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: Responsive.sp(30),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'No historic updates filed for this notice instance.',
                                      style: customTextStyle(
                                        fontSize: Responsive.sp(12),
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: currentRemarks.length,
                                  itemBuilder: (context, index) {
                                    // Visual order matches chronological stacking index descending order
                                    final remark =
                                        currentRemarks[currentRemarks.length -
                                            1 -
                                            index];
                                    return Container(
                                      margin: EdgeInsets.only(
                                        bottom: Responsive.sp(12),
                                      ),
                                      padding: EdgeInsets.all(
                                        Responsive.sp(12),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade50,
                                        border: Border.all(
                                          color: Colors.grey.shade200,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Log Entry #${currentRemarks.length - index}',
                                                style: customTextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: Responsive.sp(12),
                                                  color: AppColors.newPri,
                                                ),
                                              ),
                                              Text(
                                                remark.timeStamp,
                                                style: customTextStyle(
                                                  fontSize: Responsive.sp(11),
                                                  color: Colors.grey.shade500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          height(6),
                                          Text(
                                            remark.remarkText,
                                            style: customTextStyle(
                                              fontSize: Responsive.sp(13),
                                              color: AppColors.textColor,
                                            ),
                                          ),
                                          if (remark.fileName.isNotEmpty) ...[
                                            height(10),
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: Colors.grey.shade200,
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.description_rounded,
                                                    size: 16,
                                                    color: Colors.blueGrey,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          remark
                                                                  .documentName
                                                                  .isNotEmpty
                                                              ? remark
                                                                    .documentName
                                                              : 'Attached Document',
                                                          style: customTextStyle(
                                                            fontSize:
                                                                Responsive.sp(
                                                                  12,
                                                                ),
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Text(
                                                          remark.fileName,
                                                          style: customTextStyle(
                                                            fontSize:
                                                                Responsive.sp(
                                                                  10,
                                                                ),
                                                            color: Colors
                                                                .grey
                                                                .shade500,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.open_in_new_rounded,
                                                    size: 14,
                                                    color: Colors.blue.shade700,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    );
                                  },
                                ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
