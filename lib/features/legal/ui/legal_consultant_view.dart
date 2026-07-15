import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/widgets/custom_detail_bottom_sheet.dart';
import 'package:Doctors_App/core/widgets/custom_seachbar.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/legal/model/cases_model.dart';
import 'package:Doctors_App/features/legal/ui/view_model/cases_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../routing/routes.dart';
import '../../../theme/app_colors.dart';

class LegalConsultantView extends ConsumerWidget {
  const LegalConsultantView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final casesList = ref.watch(casesProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Legal Consultant',
        showRefresh: true,
        showBack: true,
        onRefresh: () {},
      ),
      body: Column(
        children: [
          height(8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Responsive.sp(16)),
            child: CustomSearchBar(
              controller: TextEditingController(),
              hint: 'Search cases...',
              onChanged: (value) {},
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(Responsive.sp(16)),
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
        shape: CircleBorder(),
        backgroundColor: AppColors.newPri,
        onPressed: () => context.push(Routes.addLegalConsultant),
        child: Icon(Icons.add, color: AppColors.white, size: 25),
      ),
    );
  }

  Widget _buildLegalCard(BuildContext context, CasesModel cases) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: Responsive.sp(14)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Responsive.sp(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(Responsive.sp(16)),
          onTap: () => _showOptionsBottomSheet(context, cases),
          child: Padding(
            padding: EdgeInsets.all(Responsive.sp(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Advocate: ${cases.advocateName}',
                        style: customTextStyle(
                          fontSize: Responsive.sp(12),
                          fontWeight: FontWeight.w700,
                          color: AppColors.textColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    _buildStatusBadge(cases.status),
                  ],
                ),
                height(6),
                _buildInfoRow(
                  Icons.person,
                  'Complainant: ${cases.complainantName}',
                ),
                height(6),
                _buildInfoRow(
                  Icons.call,
                  'Complainant No: ${cases.complainantNo}',
                ),
                height(6),
                InkWell(
                  borderRadius: BorderRadius.circular(6),
                  onTap: () {
                    if (cases.doctorId.toString().trim().isNotEmpty) {
                      _showOptionsBottomSheet(context, cases);
                    } else {
                      context.showWarningSnackBar(
                        'Doctor options not available for this case.',
                      );
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.badge,
                        size: Responsive.sp(16),
                        color: AppColors.textColor,
                      ),
                      SizedBox(width: Responsive.sp(6)),
                      Flexible(
                        child: Text(
                          'Doctor ID: ${cases.doctorId.toString().trim().isEmpty ? 'N/A' : cases.doctorId}',
                          style: customTextStyle(
                            fontSize: Responsive.sp(12),
                            color: AppColors.textColor,
                          ).copyWith(decoration: TextDecoration.underline),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                height(6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoRow(
                      Icons.calendar_today,
                      'Added: ${cases.addedOn}',
                    ),
                    _buildInfoRow(Icons.update, 'Updated: ${cases.updateOn}'),
                  ],
                ),
                height(10),
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.gavel,
                        size: Responsive.sp(16),
                        color: Colors.blueGrey,
                      ),
                      SizedBox(width: Responsive.sp(6)),
                      Text(
                        'Case Status: ${cases.caseStatus}',
                        style: customTextStyle(
                          fontSize: 11,
                          color: AppColors.grey,
                          fontWeight: FontWeight.w600,
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

  // Changed to standard Material showModalBottomSheet for consistent routing architecture
  void _showOptionsBottomSheet(BuildContext context, CasesModel cases) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        // Build items array inside context so it can safely execute navigation
        final options = [
          OptionItem(
            icon: Icons.person_outline,
            title: 'Personal Details',
            onTap: () {
              Navigator.pop(context);
              // Use GoRouter or standard Navigator depending on your routes system setup:
              // context.push('/PERSONALDETAILS', extra: cases);
            },
          ),
          OptionItem(
            icon: Icons.policy_outlined,
            title: 'Policy',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          OptionItem(
            icon: Icons.gavel_outlined,
            title: 'Legal Consulting',
            onTap: () => Navigator.pop(context),
          ),
        ];

        return CustomOptionsBottomSheet(
          title: 'Select Option',
          subtitle: 'Choose an action for this case',
          options: options,
        );
      },
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: Responsive.sp(16), color: AppColors.textColor),
        SizedBox(width: Responsive.sp(6)),
        Flexible(
          fit: FlexFit.loose,
          child: Text(
            text,
            style: customTextStyle(
              fontSize: Responsive.sp(12),
              color: AppColors.textColor,
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
        bg = Colors.green.shade100;
        text = Colors.green.shade800;
        break;
      case 'in-progress':
        bg = Colors.orange.shade100;
        text = Colors.orange.shade800;
        break;
      case 'closed':
        bg = Colors.red.shade100;
        text = Colors.red.shade800;
        break;
      default:
        bg = Colors.grey.shade200;
        text = Colors.grey.shade700;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.sp(10),
        vertical: Responsive.sp(4),
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.isNotEmpty ? status : 'N/A',
        style: customTextStyle(
          fontSize: Responsive.sp(10),
          fontWeight: FontWeight.w600,
          color: text,
        ),
      ),
    );
  }
}

// Dummy model representation for option selections if missing in imports
class OptionItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  OptionItem({required this.icon, required this.title, required this.onTap});
}
