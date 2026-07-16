import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../model/my_plan_model.dart';

class RenewForm extends StatefulWidget {
  final MyPlan plan;

  const RenewForm({super.key, required this.plan});

  @override
  State<RenewForm> createState() => _RenewFormState();
}

class _RenewFormState extends State<RenewForm> {
  final TextEditingController _couponController = TextEditingController();
  String? _appliedCoupon;

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
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

  // Method to display the custom Coupon Dialog
  void _showCouponDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Apply Coupon',
                      style: customTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close,
                        size: 20,
                        color: Color(0xFF64748B),
                      ),
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
                height(4),
                Text(
                  'Enter a voucher or promotional coupon code to claim your discount.',
                  style: customTextStyle(fontSize: 12, color: AppColors.grey),
                ),
                height(16),
                TextField(
                  controller: _couponController,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    hintText: 'HAVE A CODE? ENTER HERE',
                    hintStyle: customTextStyle(
                      fontSize: 12,
                      color: const Color(0xFF94A3B8),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF8FAFC),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.newPri),
                    ),
                    suffixIcon: _couponController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 16),
                            onPressed: () {
                              _couponController.clear();
                              (context as Element)
                                  .markNeedsBuild(); // Rebuild dialog state to hide icon
                            },
                          )
                        : null,
                  ),
                  style: customTextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0F172A),
                  ),
                  onChanged: (text) {
                    // Force dialog to rebuild to show/hide the clear button
                    (context as Element).markNeedsBuild();
                  },
                ),
                height(20),
                PrimaryButton(
                  height: 44,
                  text: 'Apply',
                  fontSize: 14,
                  backgroundColor: AppColors.newPri,
                  onPressed: () {
                    if (_couponController.text.trim().isNotEmpty) {
                      setState(() {
                        _appliedCoupon = _couponController.text
                            .trim()
                            .toUpperCase();
                      });
                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Coupon "$_appliedCoupon" applied successfully!',
                          ),
                          backgroundColor: const Color(0xFF059669),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Renew'),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Confirm Renewal Details',
              style: customTextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
            height(4),
            Text(
              'Review your summary layout below before proceeding to premium transaction.',
              style: customTextStyle(fontSize: 12, color: AppColors.grey),
            ),
            height(20),

            // Policy Overview Grid Container
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                children: [
                  _summaryRow('Policy:', widget.plan.planName),
                  const Divider(height: 20, color: Color(0xFFE2E8F0)),
                  _summaryRow('Speciality:', 'Doctor / Practitioner'),
                  const Divider(height: 20, color: Color(0xFFE2E8F0)),
                  _summaryRow(
                    'Sum Assured:',
                    _fmtMoney(widget.plan.sumAssured),
                  ),
                  const Divider(height: 20, color: Color(0xFFE2E8F0)),
                  _summaryRow('Duration Year:', widget.plan.duration),
                  if (_appliedCoupon != null) ...[
                    const Divider(height: 20, color: Color(0xFFE2E8F0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Coupon Applied:',
                          style: customTextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFF059669,
                                ).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                _appliedCoupon!,
                                style: customTextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF059669),
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _appliedCoupon = null;
                                  _couponController.clear();
                                });
                              },
                              child: const Icon(
                                Icons.cancel,
                                size: 16,
                                color: Color(0xFFDC2626),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],

                  const Divider(height: 20, color: Color(0xFFE2E8F0)),
                  _summaryRow(
                    'Premium Amount:',
                    _fmtMoney(widget.plan.payable),
                    isHighlighted: true,
                  ),
                ],
              ),
            ),
            height(24),

            // Outlined treatment for alternate actions like applying coupons
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.local_offer_outlined, size: 18),
                label: Text(
                  _appliedCoupon != null
                      ? 'Change Coupon Code'
                      : 'Apply Coupon Code',
                  style: customTextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.newPri,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.newPri),
                  foregroundColor: AppColors.newPri,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _showCouponDialog,
              ),
            ),
            height(12),

            PrimaryButton(
              height: 48,
              text: 'Proceed to Payment',
              fontSize: 15,
              backgroundColor: AppColors.newPri,
              onPressed: () {
                // Trigger payment gateway sheet execution loop
              },
            ),
            height(10),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isHighlighted = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: customTextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF64748B),
          ),
        ),
        Text(
          value,
          style: customTextStyle(
            fontSize: isHighlighted ? 15 : 13,
            fontWeight: isHighlighted ? FontWeight.w800 : FontWeight.w700,
            color: isHighlighted ? AppColors.newPri : const Color(0xFF1E293B),
          ),
        ),
      ],
    );
  }
}
