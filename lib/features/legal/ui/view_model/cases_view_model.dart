import 'package:Doctors_App/features/legal/model/cases_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CasesNotifier extends StateNotifier<List<CasesModel>> {
  CasesNotifier() : super(_mockCases);

  void updateCases(List<CasesModel> newCases) {
    state = newCases;
  }
}
final List<CasesModel> _mockCases = [
  CasesModel(
    id: 'CASE001',
    description:
    'Medical negligence complaint regarding post-operative care. The complainant alleges inadequate follow-up treatment after surgery, resulting in complications. The matter is currently under review.',
    status: 'In Progress',
    complainantName: 'Alice Smith',
    complainantNo: '+123456789',
    addedOn: '2026-05-12',
    updateOn: '2026-07-10',
    caseStatus: 'Hearing Stage',
  ),
  CasesModel(
    id: 'CASE002',
    description:
    'Dispute related to billing and treatment charges. Supporting documents, invoices, and patient records have been submitted for verification before the next hearing.',
    status: 'In Progress',
    complainantName: 'Michael Scott',
    complainantNo: '+987654321',
    addedOn: '2026-01-15',
    updateOn: '2026-06-22',
    caseStatus: 'Document Review',
  ),
];
final casesProvider = StateNotifierProvider<CasesNotifier, List<CasesModel>>((
  ref,
) {
  return CasesNotifier();
});
