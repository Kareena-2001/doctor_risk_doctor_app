import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../model/legal_consultant_model.dart';

class CasesNotifier extends StateNotifier<List<CasesModel>> {
  CasesNotifier() : super(_mockCases);

  /// Overwrites the full system records state list
  void updateCases(List<CasesModel> newCases) {
    state = newCases;
  }

  /// Appends a new chronological operational log entry to a targeted case entity
  void addRemark({
    required String caseId,
    required String remarkText,
    required String documentName,
    required String fileName,
  }) {
    // Generate an automatic human-readable timestamp layout string matching 2026 calendar formats
    final String currentTimestamp = DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.now());

    final RemarkModel newRemark = RemarkModel(
      remarkText: remarkText.trim(),
      documentName: documentName.trim(),
      fileName: fileName.trim(),
      timeStamp: currentTimestamp,
    );

    // Map through the state list and update the specific target case with standard immutable copyWith mutations
    state = [
      for (final currentCase in state)
        if (currentCase.id == caseId)
          currentCase.copyWith(
            remarks: [...currentCase.remarks, newRemark],
            updateOn: 'Just now', // Automatically sets standard timestamp footprint update track hints
          )
        else
          currentCase
    ];
  }
}

// Mock cases dataset aligned perfectly with the expanded model capabilities architecture matrix blueprint
final List<CasesModel> _mockCases = [
  CasesModel(
    id: 'CASE001',
    noticeMode: 'Received',
    noticeType: 'Legal',
    complainantName: 'Alice Smith',
    complainantMobile: '+123456789',
    place: 'City General Hospital',
    description: 'Medical negligence complaint regarding post-operative care. The complainant alleges inadequate follow-up treatment after surgery, resulting in complications.',
    status: 'In-Progress',
    caseStatus: 'Hearing Stage',
    uploadedFiles: ['Initial_Notice.pdf', 'Patient_History.pdf'],
    addedOn: '12 May 2026',
    updateOn: '10 Jul 2026',
    remarks: [
      RemarkModel(
        remarkText: 'Case file opened and routed to the healthcare legal defense committee.',
        documentName: 'Panel Allocation Notice',
        fileName: 'Allocation_Slip.pdf',
        timeStamp: '12 May 2026, 10:00 AM',
      ),
      RemarkModel(
        remarkText: 'Initial responsive reply drafted and cross-verified against surgical log archives.',
        documentName: 'Defense Summary Draft',
        fileName: 'Response_v1.pdf',
        timeStamp: '10 Jul 2026, 03:45 PM',
      ),
    ],
  ),
  CasesModel(
    id: 'CASE002',
    noticeMode: 'Send',
    noticeType: 'Non Legal',
    complainantName: 'Michael Scott',
    complainantMobile: '+987654321',
    place: 'Scranton Medical Center',
    description: 'Dispute related to billing and treatment charges. Supporting documents, invoices, and patient records have been submitted for verification before the next hearing.',
    status: 'In-Progress',
    caseStatus: 'Document Review',
    uploadedFiles: ['Invoice_Summary.xlsx'],
    addedOn: '15 Jan 2026',
    updateOn: '22 Jun 2026',
    remarks: [],
  ),
];

final casesProvider = StateNotifierProvider<CasesNotifier, List<CasesModel>>((ref) {
  return CasesNotifier();
});