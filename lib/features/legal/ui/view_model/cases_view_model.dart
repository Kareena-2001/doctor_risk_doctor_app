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
    id: '',
    advocateName: 'John Doe',
    status: 'Active',
    complainantName: 'Alice Smith',
    complainantNo: '+123456789',
    doctorId: 'DOC001',
    addedOn: '2026-05-12',
    updateOn: '2026-07-10',
    caseStatus: 'Hearing Stage',
  ),
  CasesModel(
    advocateName: 'Robert Vance',
    status: 'In-Progress',
    complainantName: 'Michael Scott',
    complainantNo: '+987654321',
    doctorId: '',
    addedOn: '2026-01-15',
    updateOn: '2026-06-22',
    caseStatus: 'Document Review',
    id: '',
  ),
];

final casesProvider = StateNotifierProvider<CasesNotifier, List<CasesModel>>((
  ref,
) {
  return CasesNotifier();
});
