import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/custom_seachbar.dart';
import 'package:Doctors_App/features/legal/ui/view_model/cases_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../core/constants/dimensions.dart';
import '../../../routing/routes.dart';
import '../../../theme/app_colors.dart';
import '../model/cases_model.dart';

class LegalNoticeView extends ConsumerWidget {
  const LegalNoticeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final casesList = ref.watch(casesProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Legal Notice',
        showRefresh: true,
        showBack: true,
        onRefresh: () {},
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomSearchBar(
              controller: TextEditingController(),
              hint: 'Search cases...',
              onChanged: (value) {},
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              itemCount: casesList.length,
              itemBuilder: (context, index) {
                final cases = casesList[index];
                return _buildLegalCard(cases);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: AppColors.accent,
        onPressed: () => context.push(Routes.addLegalNotice),
        child: Icon(Icons.add, color: AppColors.white, size: 25),
      ),
    );
  }

  Widget _buildLegalCard(CasesModel cases) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        // gradient: LinearGradient(
        //   colors: [Colors.white, Colors.grey.shade50],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
        borderRadius: BorderRadius.circular(16),
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
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Title: ${'......'}',
                        style: customTextStyle(
                          fontSize: 14,
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
                _buildInfoRow(Icons.call, 'Receiver: ${cases.complainantName}'),
                height(6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoRow(
                      Icons.mobile_friendly,
                      'mobile: ${9326481598}',
                    ),
                    _buildInfoRow(Icons.person, 'Date: ${'25th , 2025'}'),
                  ],
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.gavel, size: 16, color: Colors.blueGrey),
                      const SizedBox(width: 6),
                      Text(
                        'Notice Status: ${cases.caseStatus}',
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

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.textColor),
        const SizedBox(width: 6),
        Flexible(
          fit: FlexFit.loose,
          child: Text(
            text,
            style: customTextStyle(fontSize: 12, color: AppColors.textColor),
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.isNotEmpty ? status : 'N/A',
        style: customTextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: text,
        ),
      ),
    );
  }
}
