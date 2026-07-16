import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/product/ui/widgets/renew_form.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/values/app_text_style.dart';
import '../model/my_plan_model.dart';

class MyPlanDetailsScreen extends StatelessWidget {
  final MyPlan plan;

  const MyPlanDetailsScreen({super.key, required this.plan});

  Color _statusColor(PlanStatus s) {
    switch (s) {
      case PlanStatus.active:
        return const Color(0xFF059669);
      case PlanStatus.expired:
        return const Color(0xFFDC2626);
      case PlanStatus.pendingRenewal:
        return const Color(0xFFD97706);
      case PlanStatus.inactive:
        return const Color(0xFF64748B);
    }
  }

  String _fmtMoney(double v) {
    final s = v.toStringAsFixed(0);
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final posFromEnd = s.length - i;
      buf.write(s[i]);
      if (posFromEnd > 1 && posFromEnd % 3 == 1 && i != 0) buf.write(',');
    }
    return '₹${buf.toString()}';
  }

  String _fmtDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  Future<void> _openDocument(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(plan.status);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const CustomAppBar(title: 'Plan Details'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            plan.planName,
                            style: customTextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            plan.status.label,
                            style: customTextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    height(6),
                    Text(
                      'Policy No. ${plan.policyNumber}',
                      style: customTextStyle(
                        fontSize: 12,
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              height(16),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _detailItem('Sum Assured', _fmtMoney(plan.sumAssured)),
                        _detailItem('Premium Payable', _fmtMoney(plan.payable)),
                      ],
                    ),
                    const Divider(height: 24, color: Color(0xFFF1F5F9)),
                    Row(
                      children: [
                        _detailItem('Duration', plan.duration),
                        _detailItem(
                          'Validity',
                          '${_fmtDate(plan.fromDate)} - ${_fmtDate(plan.toDate)}',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              height(24),

              // Actionable Document Buttons (TPA details requested)
              Text(
                'Documents & Agreements',
                style: customTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF334155),
                ),
              ),
              height(12),

              _documentTile(
                title: 'View Invoice',
                subtitle: 'Download receipt copy for your records',
                icon: Icons.receipt_long_outlined,
                onTap: () => _openDocument('assets/pdf/invoice.pdf'),
              ),
              height(12),

              _documentTile(
                title: 'View Agreement & TPA Docs',
                subtitle: 'View terms and conditions for this policy',
                icon: Icons.description_outlined,
                onTap: () => _openDocument('assets/pdf/agreement.pdf'),
              ),

              if (plan.isRenewable) ...[
                height(32),
                PrimaryButton(
                  height: 46,
                  text: 'Renew Subscription',
                  fontSize: 14,
                  backgroundColor: AppColors.newPri,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RenewForm(plan: plan),
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailItem(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: customTextStyle(fontSize: 10, color: AppColors.grey),
          ),
          height(4),
          Text(
            value,
            style: customTextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _documentTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.secondary.withValues(alpha: 0.1),
              child: Icon(icon, color: AppColors.secondary, size: 20),
            ),
            width(14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: customTextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  height(2),
                  Text(
                    subtitle,
                    style: customTextStyle(fontSize: 10, color: AppColors.grey),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF94A3B8), size: 18),
          ],
        ),
      ),
    );
  }
}
