import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'help_categories_provider.g.dart';

@riverpod
Map<String, List<String>> helpCategories(HelpCategoriesRef ref) {
  // 'Leave & Attendance': [
  //   'How to apply for leave?',
  //   'Check my leave balance',
  //   'Attendance marking issues',
  //   'Holiday calendar information',
  // ],
  return {
    'Payroll & Salary': [
      'When will I receive my salary?',
      'Salary not credited',
      'Incorrect salary amount',
      'Payslip download issue',
    ],

    'Salary Deductions': [
      'Unexpected salary deduction',
      'Professional tax deduction',
      'Income tax (TDS) deduction query',
      'Loan or advance deduction',
      'Other deduction related issue',
    ],

    'PF (Provident Fund)': [
      'PF account details',
      'PF deduction mismatch',
      'PF balance check',
      'PF transfer issue',
      'PF withdrawal / settlement query',
    ],

    'ESIC (ESI Card)': [
      'ESIC card generation issue',
      'ESIC number not received',
      'ESIC deduction query',
      'Hospital / dispensary details',
      'ESIC benefit clarification',
    ],

    'Profile & Documents': [
      'Update personal information',
      'Upload documents',
      'Change password',
      'Profile verification status',
      'Incorrect details in records',
    ],

    'Technical Issues': [
      'App not working properly',
      'Login problems',
      'Data not syncing',
      'Slow performance',
      'Other technical issue',
    ],

    'Other / General': [
      'General inquiry',
      'Feedback or suggestion',
      'Policy related question',
      'Custom question',
    ],
  };
}
