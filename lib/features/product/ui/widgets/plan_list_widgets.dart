import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:flutter/material.dart';

class PlanListWidgets extends StatefulWidget {
  const PlanListWidgets({super.key});

  @override
  State<PlanListWidgets> createState() => _PlanListWidgetsState();
}

class _PlanListWidgetsState extends State<PlanListWidgets> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [_buildProductDetailsCard()]);
  }

  Widget _buildProductDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CURRENT PRODUCT',
                    style: customTextStyle(
                      color: Color(0xFF0A6C4A),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Product A - Medical Indemnity',
                    style: customTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              // Simplified Shield Icon placeholder matching UI
              const Icon(
                Icons.shield_outlined,
                size: 48,
                color: Color(0xFFECECEC),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDetailItem('Duration', '2 Years'),
              _buildDetailItem('Sum Assured', '₹ 50,000,000', isCurrency: true),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDetailItem('Premium Paid', '₹ 44,000'),
              _buildDetailItem('Renewal Date', '31/08/2026'),
            ],
          ),
          const SizedBox(height: 16),

          // Coverage Status Bar Indicator
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F3F4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Coverage Status',
                  style: TextStyle(fontSize: 11, color: Colors.black54),
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: 0.65,
                    minHeight: 6,
                    backgroundColor: Colors.black12,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF0D4435),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                const Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '65% Term Remaining',
                    style: TextStyle(fontSize: 10, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.file_download_outlined,
                color: Colors.white,
                size: 18,
              ),
              label: Text(
                'Download Policy',
                style: customTextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D4435),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(
    String title,
    String value, {
    bool isCurrency = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: customTextStyle(fontSize: 11, color: Colors.black54),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: customTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isCurrency ? const Color(0xFF0A6C4A) : Colors.black87,
          ),
        ),
      ],
    );
  }
}
