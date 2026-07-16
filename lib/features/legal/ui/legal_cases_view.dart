import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/features/legal/model/legal_court_case_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/widgets/custom_seachbar.dart';
import '../../../routing/routes.dart';
import '../../../theme/app_colors.dart';

class LegalRemark {
  final String remarkText;
  final String documentName;
  final String fileName;
  final String timeStamp;

  LegalRemark({
    required this.remarkText,
    required this.documentName,
    required this.fileName,
    required this.timeStamp,
  });
}

final mockCasesProvider = Provider<List<CourtCaseModel>>((ref) {
  return [
    CourtCaseModel(
      srNo: 1,
      advocateName: 'Adv. Rajesh Sharma',
      previousDate: '15/07/2026',
      caseType: 'Medical Negligence',
      caseNo: 'MC/2026/105',
      complainantName: 'Amit Verma',
      complainantMobile: '9876543210',
      court: 'District Court, Mumbai',
      presentRequired: true,
      addedOn: '10/07/2026',
      nextDate: '28/07/2026',
      remarks: [],
    ),
    CourtCaseModel(
      srNo: 2,
      advocateName: 'Adv. Neha Patel',
      previousDate: '02/07/2026',
      caseType: 'Consumer Complaint',
      caseNo: 'CC/2026/221',
      complainantName: 'Rohit Shah',
      complainantMobile: '9123456780',
      court: 'Consumer Court, Pune',
      presentRequired: false,
      addedOn: '25/06/2026',
      nextDate: '05/08/2026',
      remarks: [],
    ),
  ];
});

class LegalCasesView extends ConsumerWidget {
  const LegalCasesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final casesList = ref.watch(mockCasesProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      // appBar: CustomAppBar(
      //   title: 'Legal Notice Records',
      //   showRefresh: true,
      //   showBack: true,
      //   onRefresh: () {},
      // ),
      body: Column(
        children: [
          height(12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomSearchBar(
              controller: TextEditingController(),
              hint: 'Search by complainant, type or place...',
              onChanged: (value) {},
            ),
          ),
          height(6),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              physics: const BouncingScrollPhysics(),
              itemCount: casesList.length,
              itemBuilder: (context, index) {
                final currentCase = casesList[index];
                return _buildLegalCard(context, currentCase);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: AppColors.newPri,
        onPressed: () => context.push(Routes.addLegalCases),
        child: const Icon(Icons.add, color: Colors.white, size: 26),
      ),
    );
  }

  Widget _buildLegalCard(BuildContext context, CourtCaseModel courtCase) {
    // final bool isSent = courtCase.noticeMode.toLowerCase() == 'send';
    // final Color modeColor = isSent
    //     ? Colors.blue.shade700
    //     : Colors.purple.shade700;
    // final Color modeBg = isSent ? Colors.blue.shade50 : Colors.purple.shade50;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showRemarksBottomSheet(context, courtCase),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Header
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            courtCase.caseType,
                            style: customTextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Case No. ${courtCase.caseNo}',
                            style: customTextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    _buildStatusBadge(courtCase.status),
                  ],
                ),

                const Divider(height: 28),

                _buildInfoRow(Icons.person_outline, courtCase.complainantName),

                const SizedBox(height: 8),

                _buildInfoRow(
                  Icons.phone_outlined,
                  courtCase.complainantMobile,
                ),

                const SizedBox(height: 8),

                _buildInfoRow(Icons.gavel_outlined, courtCase.advocateName),

                const SizedBox(height: 8),

                _buildInfoRow(Icons.account_balance_outlined, courtCase.court),

                const SizedBox(height: 18),

                Row(
                  children: [
                    Expanded(
                      child: _dateTile('Previous', courtCase.previousDate),
                    ),

                    const SizedBox(width: 10),

                    Expanded(child: _dateTile('Next', courtCase.nextDate)),
                  ],
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: courtCase.presentRequired
                            ? Colors.red.shade50
                            : Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            courtCase.presentRequired
                                ? Icons.person
                                : Icons.check_circle,
                            size: 14,
                            color: courtCase.presentRequired
                                ? Colors.red
                                : Colors.green,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            courtCase.presentRequired
                                ? 'Presence Required'
                                : 'Presence Not Required',
                            style: customTextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: courtCase.presentRequired
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    Text(
                      'Added ${courtCase.addedOn}',
                      style: customTextStyle(fontSize: 11, color: Colors.grey),
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

  Widget _dateTile(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: customTextStyle(fontSize: 11, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(
            value,
            style: customTextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  // Interactive Panel: Allows adding new remarks and immediately lists existing records
  void _showRemarksBottomSheet(BuildContext context, CourtCaseModel courtCase) {
    // Local controllers for handling the state within the bottom sheet overlay
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
        // StatefulBuilder allows the local upload button state to refresh smoothly without needing full page rebuilding
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return DraggableScrollableSheet(
              initialChildSize: 0.75,
              maxChildSize: 0.95,
              minChildSize: 0.5,
              expand: false,
              builder: (context, scrollController) {
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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Case History & Remarks',
                              style: customTextStyle(
                                fontSize: 18,
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
                        padding: const EdgeInsets.all(20),
                        children: [
                          // ==========================================
                          // SECTION 1: ADD NEW REMARK FORM
                          // ==========================================
                          Text(
                            'Add New Remark Log',
                            style: customTextStyle(
                              fontSize: 14,
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
                                fontSize: 13,
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
                              hintText:
                                  'Document Name (e.g., Rejoinder Affidavit)',
                              hintStyle: customTextStyle(
                                fontSize: 13,
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

                          // File attachment simulator row
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
                                  // Simulating a file picking engine operation choice
                                  setModalState(() {
                                    attachedFileName =
                                        "Selected_Doc_${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}.pdf";
                                  });
                                },
                                icon: const Icon(
                                  Icons.cloud_upload_outlined,
                                  size: 16,
                                ),
                                label: Text(
                                  'Attach File',
                                  style: customTextStyle(
                                    fontSize: 12,
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
                                              fontSize: 11,
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
                          height(12),

                          // Form Action Trigger Button
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

                              // Logic Connection: Here you will point to your caseNotifier state updates
                              // e.g., ref.read(casesViewModelProvider.notifier).addNewRemark(...)

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Remark log successfully stored.',
                                  ),
                                ),
                              );

                              Navigator.pop(
                                context,
                              ); // close sheet after saving change
                            },
                            child: Text(
                              'Save Operational Log Entry',
                              style: customTextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Divider(color: AppColors.divider),
                          ),

                          // ==========================================
                          // SECTION 2: CHRONOLOGICAL REMARKS LIST VIEW
                          // ==========================================
                          Text(
                            'Historical Logs (${courtCase.remarks.length})',
                            style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textColor,
                            ),
                          ),
                          height(12),

                          courtCase.remarks.isEmpty
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 30,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'No historic updates filed for this notice instance.',
                                      style: customTextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: courtCase.remarks.length,
                                  itemBuilder: (context, index) {
                                    final remark = courtCase.remarks[index];
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      padding: const EdgeInsets.all(12),
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
                                                'Log Entry #${courtCase.remarks.length - index}',
                                                style: customTextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12,
                                                  color: AppColors.newPri,
                                                ),
                                              ),
                                              Text(
                                                remark.timeStamp,
                                                style: customTextStyle(
                                                  fontSize: 11,
                                                  color: Colors.grey.shade500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          height(6),
                                          Text(
                                            remark.remarkText,
                                            style: customTextStyle(
                                              fontSize: 13,
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
                                                          remark.documentName,
                                                          style:
                                                              customTextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Text(
                                                          remark.fileName,
                                                          style:
                                                              customTextStyle(
                                                                fontSize: 10,
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

  Widget _buildInfoRow(IconData icon, String text, {Color? color}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: color ?? Colors.grey.shade700),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            text,
            style: customTextStyle(
              fontSize: 12,
              color: color ?? AppColors.textColor,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(CourtCaseStatus status) {
    late Color bg;
    late Color text;
    late String title;

    switch (status) {
      case CourtCaseStatus.pending:
        bg = Colors.orange.shade50;
        text = Colors.orange.shade700;
        title = 'Pending';
        break;

      case CourtCaseStatus.completed:
        bg = Colors.green.shade50;
        text = Colors.green.shade700;
        title = 'Completed';
        break;

      case CourtCaseStatus.adjourned:
        bg = Colors.purple.shade50;
        text = Colors.purple.shade700;
        title = 'Adjourned';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: customTextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: text,
        ),
      ),
    );
  }
}
