import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MyPlansWidgets extends StatefulWidget {
  const MyPlansWidgets({super.key});

  @override
  State<MyPlansWidgets> createState() => _MyPlansWidgetsState();
}

class _MyPlansWidgetsState extends State<MyPlansWidgets> {
  bool isPlanListSelected = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSectionHeader(
          title: 'Active Protection',
          badgeText: 'SUCCESSFUL',
          badgeColor: AppColors.newPri,
        ),
        height(12),
        _buildProductDetailsCard(),
        height(20),
        _buildSupportHubCard(),
        height(24),
        Row(
          children: [
            Icon(Icons.history, color: Colors.black54, size: 20),
            width(8),
            Text(
              'Plan History & renewals',
              style: customTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        height(12),
        _buildPlanHistoryTable(),
        height(80),
      ],
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required String badgeText,
    required Color badgeColor,
  }) {
    return Row(
      children: [
        const Icon(
          Icons.verified_user_outlined,
          color: Color(0xFF0D4435),
          size: 22,
        ),
        width(8),
        Text(
          title,
          style: customTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: badgeColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            badgeText,
            style: customTextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
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
              Icon(Icons.shield_outlined, size: 48, color: Color(0xFFECECEC)),
            ],
          ),
          height(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDetailItem('Duration', '2 Years'),
              _buildDetailItem('Sum Assured', '₹ 50,000,000', isCurrency: true),
            ],
          ),
          height(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDetailItem('Premium Paid', '₹ 44,000'),
              _buildDetailItem('Renewal Date', '31/08/2026'),
            ],
          ),
          height(16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F3F4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Coverage Status',
                  style: customTextStyle(fontSize: 11, color: Colors.black54),
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
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '65% Term Remaining',
                    style: customTextStyle(fontSize: 10, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
          height(16),
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
        SizedBox(height: 2),
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

  Widget _buildSupportHubCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.newPri,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Support Hub',
            style: customTextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          height(4),
          Text(
            'Need assistance with your current policy or claims?',
            style: customTextStyle(color: Colors.white70, fontSize: 12),
          ),
          height(16),
          _buildSupportActionRow('Contact Advisor'),
          height(8),
          _buildSupportActionRow('Raise a Query'),
        ],
      ),
    );
  }

  Widget _buildSupportActionRow(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: customTextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
          const Icon(Icons.arrow_forward, color: Colors.white, size: 16),
        ],
      ),
    );
  }

  Widget _buildPlanHistoryTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(2.2),
          2: FlexColumnWidth(1.8),
          3: FlexColumnWidth(2.2),
          4: FlexColumnWidth(2),
        },
        children: [
          // Table Header
          TableRow(
            decoration: const BoxDecoration(
              color: Color(0xFFF8F9FA),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            children: [
              _buildTableCell('SR.\nNO', isHeader: true),
              _buildTableCell('PLAN\nNAME', isHeader: true),
              _buildTableCell('DURATION', isHeader: true),
              _buildTableCell('PREMIUM\n(₹)', isHeader: true),
              _buildTableCell('STATUS', isHeader: true),
            ],
          ),
          // Row 1
          TableRow(
            children: [
              _buildTableCell('01'),
              _buildTableCell('Product A'),
              _buildTableCell('2 Years'),
              _buildTableCell('44,000.00'),
              _buildStatusBadge('SUCCESSFUL', const Color(0xFF0A6C4A)),
            ],
          ),
          // Row 2
          TableRow(
            children: [
              _buildTableCell('02'),
              _buildTableCell('Product B - Lite'),
              _buildTableCell('1 Year'),
              _buildTableCell('18,500.00'),
              _buildStatusBadge(
                'EXPIRED',
                Colors.black54,
                textColors: Colors.black54,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: customTextStyle(
          fontSize: isHeader ? 10 : 12,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: isHeader ? Colors.black54 : Colors.black87,
        ),
      ),
    );
  }

  Widget _buildStatusBadge(
    String text,
    Color bg, {
    Color textColors = Colors.white,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            text,
            style: customTextStyle(
              color: textColors,
              fontSize: 8,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
