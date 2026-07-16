import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/widgets/custom_seachbar.dart';
import '../../../routing/routes.dart';
import '../../../theme/app_colors.dart';

// Structured model mapping to store multiple historical remarks for each notice file
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

class LegalNoticeModel {
  final String id;
  final String noticeMode;
  final String noticeType;
  final DateTime date;
  final String complainantName;
  final String complainantMobile;
  final String place;
  final String description;
  final String status;
  final List<String> uploadedFiles;
  final List<LegalRemark> remarks; // Multi-remark support field
  final String addedOn;
  final String updateOn;

  LegalNoticeModel({
    required this.id,
    required this.noticeMode,
    required this.noticeType,
    required this.date,
    required this.complainantName,
    required this.complainantMobile,
    required this.place,
    required this.description,
    required this.status,
    required this.uploadedFiles,
    required this.remarks,
    required this.addedOn,
    required this.updateOn,
  });
}

final mockCasesProvider = Provider<List<LegalNoticeModel>>((ref) {
  return [
    LegalNoticeModel(
      id: "1",
      noticeMode: "Received",
      noticeType: "Medical Negligence",
      date: DateTime(2026, 5, 12),
      complainantName: "Dr. Alex Chambers",
      complainantMobile: "9326481598",
      place: "City General Hospital",
      description: "Alleged misdiagnosis claim concerning postoperative management protocols.",
      status: "Active",
      uploadedFiles: ["Report_2026.pdf", "Scan_Copy.jpg"],
      addedOn: "14 May 2026",
      updateOn: "Today",
      remarks: [
        LegalRemark(
          remarkText: "Initial response copy prepared and verified by the legal panel.",
          documentName: "Legal Panel Clearance Certificate",
          fileName: "Response_Draft_v1.pdf",
          timeStamp: "15 May 2026",
        ),
        LegalRemark(
          remarkText: "Medical summary report signed off by the Head of Surgery.",
          documentName: "Clinical Case Summary",
          fileName: "Surgical_Audit.pdf",
          timeStamp: "Today at 10:30 AM",
        ),
      ],
    ),
    LegalNoticeModel(
      id: "2",
      noticeMode: "Send",
      noticeType: "Recovery",
      date: DateTime(2026, 4, 20),
      complainantName: "Apex Medical Supplies Ltd.",
      complainantMobile: "9876543210",
      place: "Downtown Clinic Branch",
      description: "Legal notice served regarding outstanding equipment lease clearances.",
      status: "In-Progress",
      uploadedFiles: ["Invoice_77B.pdf"],
      addedOn: "22 Apr 2026",
      updateOn: "3 days ago",
      remarks: [
        LegalRemark(
          remarkText: "Demand notice successfully served to tenant via registered post.",
          documentName: "Postal Dispatch Slip",
          fileName: "SpeedPost_Receipt.jpg",
          timeStamp: "24 Apr 2026",
        ),
      ],
    ),
    LegalNoticeModel(
      id: "3",
      noticeMode: "Received",
      noticeType: "138 NI",
      date: DateTime(2026, 3, 05),
      complainantName: "Rajesh Kumar Mehta",
      complainantMobile: "9123456789",
      place: "Metro Health Chambers",
      description: "Notice regarding dishonored consulting fee retainer checks.",
      status: "Closed",
      uploadedFiles: [],
      addedOn: "06 Mar 2026",
      updateOn: "12 May 2026",
      remarks: [],
    ),
  ];
});

class LegalNoticeView extends ConsumerWidget {
  const LegalNoticeView({super.key});

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
        onPressed: () => context.push(Routes.addLegalNotice),
        child: const Icon(Icons.add, color: Colors.white, size: 26),
      ),
    );
  }

  Widget _buildLegalCard(BuildContext context, LegalNoticeModel notice) {
    final bool isSent = notice.noticeMode.toLowerCase() == 'send';
    final Color modeColor = isSent ? Colors.blue.shade700 : Colors.purple.shade700;
    final Color modeBg = isSent ? Colors.blue.shade50 : Colors.purple.shade50;

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
          onTap: () => _showRemarksBottomSheet(context, notice),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.gavel_rounded, size: 15, color: Colors.blueGrey.shade700),
                          const SizedBox(width: 6),
                          Text(
                            notice.noticeType,
                            style: customTextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.blueGrey.shade900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildStatusBadge(notice.status),
                  ],
                ),
                height(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: modeBg,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isSent ? Icons.call_made_rounded : Icons.call_received_rounded,
                            size: 13,
                            color: modeColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            notice.noticeMode.toUpperCase(),
                            style: customTextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: modeColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildInfoRow(
                      Icons.calendar_today_rounded,
                      DateFormat('dd MMM yyyy').format(notice.date),
                      color: Colors.grey.shade600,
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(height: 1, thickness: 0.5, color: AppColors.divider),
                ),
                Text(
                  notice.complainantName,
                  style: customTextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textColor,
                  ),
                ),
                height(6),
                Row(
                  children: [
                    Expanded(child: _buildInfoRow(Icons.phone_android_rounded, notice.complainantMobile)),
                    Expanded(child: _buildInfoRow(Icons.location_on_rounded, notice.place)),
                  ],
                ),
                height(8),
                Text(
                  notice.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: customTextStyle(fontSize: 12, color: Colors.grey.shade600).copyWith(height: 1.3),
                ),
                height(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.amber.shade50,
                            border: Border.all(color: Colors.amber.shade200, width: 0.5),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.attachment_rounded, size: 13, color: Colors.amber.shade900),
                              const SizedBox(width: 4),
                              Text(
                                '${notice.uploadedFiles.length} Docs',
                                style: customTextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.amber.shade900),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            border: Border.all(color: Colors.blue.shade200, width: 0.5),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '${notice.remarks.length} Remarks',
                            style: customTextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.blue.shade900),
                          ),
                        ),
                      ],
                    ),
                    Text('Updated: ${notice.updateOn}', style: customTextStyle(fontSize: 11, color: Colors.grey.shade500)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
// Interactive Panel: Allows adding new remarks and immediately lists existing records
  void _showRemarksBottomSheet(BuildContext context, LegalNoticeModel notice) {
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
                      decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)),
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
                              style: customTextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close_rounded),
                            style: IconButton.styleFrom(backgroundColor: Colors.grey.shade100),
                          )
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
                            style: customTextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textColor),
                          ),
                          height(10),
                          TextField(
                            controller: remarkController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: 'Type details of update or next action steps...',
                              hintStyle: customTextStyle(fontSize: 13, color: Colors.grey.shade400),
                              filled: true,
                              fillColor: Colors.grey.shade50,
                              contentPadding: const EdgeInsets.all(12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey.shade200),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey.shade200),
                              ),
                            ),
                          ),
                          height(10),
                          TextField(
                            controller: docNameController,
                            decoration: InputDecoration(
                              hintText: 'Document Name (e.g., Rejoinder Affidavit)',
                              hintStyle: customTextStyle(fontSize: 13, color: Colors.grey.shade400),
                              filled: true,
                              fillColor: Colors.grey.shade50,
                              prefixIcon: const Icon(Icons.title_rounded, size: 18),
                              contentPadding: const EdgeInsets.symmetric(vertical: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey.shade200),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey.shade200),
                              ),
                            ),
                          ),
                          height(10),

                          // File attachment simulator row
                          Row(
                            children: [
                              OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  side: BorderSide(color: AppColors.newPri.withValues(alpha: 0.5)),
                                ),
                                onPressed: () {
                                  // Simulating a file picking engine operation choice
                                  setModalState(() {
                                    attachedFileName = "Selected_Doc_${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}.pdf";
                                  });
                                },
                                icon: const Icon(Icons.cloud_upload_outlined, size: 16),
                                label: Text('Attach File', style: customTextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.newPri)),
                              ),
                              const SizedBox(width: 12),
                              if (attachedFileName.isNotEmpty)
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                    decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(6)),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.insert_drive_file, size: 14, color: Colors.amber),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            attachedFileName,
                                            style: customTextStyle(fontSize: 11, color: Colors.amber.shade900),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () => setModalState(() => attachedFileName = ''),
                                          child: const Icon(Icons.cancel, size: 14, color: Colors.grey),
                                        )
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
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () {
                              if (remarkController.text.trim().isEmpty) return;

                              // Logic Connection: Here you will point to your caseNotifier state updates
                              // e.g., ref.read(casesViewModelProvider.notifier).addNewRemark(...)

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Remark log successfully stored.')),
                              );

                              Navigator.pop(context); // close sheet after saving change
                            },
                            child: Text(
                              'Save Operational Log Entry',
                              style: customTextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
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
                            'Historical Logs (${notice.remarks.length})',
                            style: customTextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textColor),
                          ),
                          height(12),

                          notice.remarks.isEmpty
                              ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: Center(
                              child: Text(
                                'No historic updates filed for this notice instance.',
                                style: customTextStyle(fontSize: 12, color: Colors.grey.shade400),
                              ),
                            ),
                          )
                              : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: notice.remarks.length,
                            itemBuilder: (context, index) {
                              final remark = notice.remarks[index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  border: Border.all(color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Log Entry #${notice.remarks.length - index}',
                                          style: customTextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: AppColors.newPri),
                                        ),
                                        Text(
                                          remark.timeStamp,
                                          style: customTextStyle(fontSize: 11, color: Colors.grey.shade500),
                                        ),
                                      ],
                                    ),
                                    height(6),
                                    Text(
                                      remark.remarkText,
                                      style: customTextStyle(fontSize: 13, color: AppColors.textColor),
                                    ),
                                    if (remark.fileName.isNotEmpty) ...[
                                      height(10),
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: Colors.grey.shade200),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.description_rounded, size: 16, color: Colors.blueGrey),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    remark.documentName,
                                                    style: customTextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    remark.fileName,
                                                    style: customTextStyle(fontSize: 10, color: Colors.grey.shade500),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Icon(Icons.open_in_new_rounded, size: 14, color: Colors.blue.shade700),
                                          ],
                                        ),
                                      ),
                                    ]
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
            style: customTextStyle(fontSize: 12, color: color ?? AppColors.textColor),
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
      child: Text(
        status.isNotEmpty ? status : 'N/A',
        style: customTextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: text),
      ),
    );
  }
}