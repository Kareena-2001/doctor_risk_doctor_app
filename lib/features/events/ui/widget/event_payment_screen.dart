import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/utils/decoration.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/common/ui/widgets/loading.dart';
import 'package:Doctors_App/features/events/model/payment_summary_model.dart';
import 'package:Doctors_App/features/events/ui/state/events_state.dart';
import 'package:Doctors_App/features/events/ui/view_model/events_view_model.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  final String eventRegistrationId;
  final String feeLabel;

  final Future<void> Function(PaymentSummaryData summary)? onPay;

  const PaymentScreen({
    super.key,
    required this.eventRegistrationId,
    this.feeLabel = 'Event registration fee',
    this.onPay,
  });

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  final _couponCtrl = TextEditingController();

  EventsViewModel get _vm => ref.read(eventsViewModelProvider.notifier);

  @override
  void initState() {
    super.initState();
    Future.microtask(_init);
  }

  @override
  void dispose() {
    _couponCtrl.dispose();
    super.dispose();
  }

  Future<void> _init() => _vm.initPayment(widget.eventRegistrationId);

  Future<void> _toggleRewards(bool value) async {
    final error = await _vm.toggleRewards(widget.eventRegistrationId, value);
    if (!mounted || error == null) return;
    context.showErrorSnackBar(error);
  }

  Future<void> _applyCoupon() async {
    final code = _couponCtrl.text.trim();
    if (code.isEmpty) {
      _vm.setCouponError('Enter a coupon code');
      return;
    }
    FocusScope.of(context).unfocus();
    await _vm.applyCoupon(widget.eventRegistrationId, code);
  }

  Future<void> _removeCoupon() async {
    _couponCtrl.clear();
    final error = await _vm.removeCoupon(widget.eventRegistrationId);
    if (!mounted || error == null) return;
    context.showErrorSnackBar(error);
  }

  Future<void> _pay(PaymentSummaryData data) async {
    final onPay = widget.onPay;
    if (onPay == null) {
      context.showWarningSnackBar('Payment gateway is not connected yet.');
      return;
    }

    final error = await _vm.runPayment(() => onPay(data));
    if (!mounted) return;

    if (error != null) {
      context.showErrorSnackBar(error);
      return;
    }
    Navigator.pop(context, true);
  }

  double _amount(String? raw) =>
      double.tryParse((raw ?? '').replaceAll(',', '').trim()) ?? 0;

  String _fmt(String? raw) {
    final value = _amount(raw);
    final hasPaise = value != value.truncateToDouble();
    return NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: hasPaise ? 2 : 0,
    ).format(value);
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(eventsViewModelProvider);
    final paymentState = s.paymentList;
    final data = paymentState.valueOrNull?.data;
    final refreshing = paymentState.isLoading && data != null;
    final busy = refreshing || s.applyingCoupon || s.paying;

    return Scaffold(
      appBar: CustomAppBar(title: 'Payment'),
      bottomNavigationBar: data == null
          ? null
          : _buildBottomBar(context, data, s, busy),
      body: SafeArea(
        child: data == null
            ? _buildInitialState(context, paymentState)
            : GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(Responsive.w(16)),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Complete your payment',
                          textAlign: TextAlign.center,
                          style: customTextStyle(
                            fontSize: Responsive.sp(20),
                            fontWeight: FontWeight.bold,
                            color: context.primaryTextColor,
                          ),
                        ),
                      ),
                      height(Responsive.h(6)),
                      Center(
                        child: Text(
                          'Bank-grade encryption. Your card details are never stored on our servers.',
                          textAlign: TextAlign.center,
                          style: customTextStyle(
                            fontSize: Responsive.sp(11),
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      height(Responsive.h(20)),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: refreshing ? 0.5 : 1,
                        child: _buildOrderSummary(context, data, s),
                      ),
                      height(Responsive.h(10)),
                      Row(
                        children: [
                          Icon(
                            Icons.check_rounded,
                            size: Responsive.sp(14),
                            color: Colors.green.shade700,
                          ),
                          width(Responsive.w(4)),
                          Text(
                            widget.feeLabel,
                            style: customTextStyle(
                              fontSize: Responsive.sp(11),
                              fontWeight: FontWeight.w600,
                              color: Colors.green.shade700,
                            ),
                          ),
                        ],
                      ),
                      height(Responsive.h(14)),
                      _buildRewardAndCoupon(context, data, s, busy),
                      height(Responsive.h(16)),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildInitialState(
    BuildContext context,
    AsyncValue<PaymentSummaryResponse> state,
  ) {
    if (state.hasError) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(Responsive.w(24)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                state.error.toString().replaceFirst('Exception: ', ''),
                textAlign: TextAlign.center,
                style: customTextStyle(
                  fontSize: Responsive.sp(12.5),
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
              height(Responsive.h(10)),
              TextButton(onPressed: _init, child: const Text('Retry')),
            ],
          ),
        ),
      );
    }
    return Center(child: Loading());
  }

  Widget _buildOrderSummary(
    BuildContext context,
    PaymentSummaryData d,
    EventsState s,
  ) {
    final rewardAmount = _amount(d.rewardDiscountAmount);
    final couponAmount = _amount(d.couponDiscountAmount);
    final savings = rewardAmount + couponAmount;
    final green = Colors.green.shade700;

    final rows = <Widget>[
      _summaryRow(context, label: 'Event name', value: d.eventName),
      _summaryRow(context, label: 'Event price', value: _fmt(d.eventPrice)),
      if (d.rewardPointsUsed > 0 || rewardAmount > 0)
        _summaryRow(
          context,
          label: 'Reward points (${d.rewardPointsUsed} pts)',
          value: '- ${_fmt(d.rewardDiscountAmount)}',
          valueColor: green,
        ),
      if (couponAmount > 0)
        _summaryRow(
          context,
          label: 'Coupon (${d.couponCode ?? s.appliedCoupon ?? ''})',
          value: '- ${_fmt(d.couponDiscountAmount)}',
          valueColor: green,
        ),
    ];

    final children = <Widget>[];
    for (int i = 0; i < rows.length; i++) {
      children.add(rows[i]);
      if (i != rows.length - 1) children.add(_DottedDivider(color: _dotColor));
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.w(18)),
      decoration: cardDecoration(context, radius: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(Responsive.w(8)),
                decoration: BoxDecoration(
                  color: AppColors.newPri.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.receipt_long_rounded,
                  size: Responsive.sp(16),
                  color: AppColors.newPri,
                ),
              ),
              width(Responsive.w(10)),
              Text(
                'Order summary',
                style: customTextStyle(
                  fontSize: Responsive.sp(14),
                  fontWeight: FontWeight.bold,
                  color: context.primaryTextColor,
                ),
              ),
            ],
          ),
          height(Responsive.h(12)),
          _DottedDivider(color: _dotColor),
          ...children,
          _DottedDivider(color: _dotColor),
          height(Responsive.h(12)),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.w(14),
              vertical: Responsive.h(12),
            ),
            decoration: BoxDecoration(
              color: green.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(Responsive.w(14)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Total payable',
                    style: customTextStyle(
                      fontSize: Responsive.sp(14),
                      fontWeight: FontWeight.bold,
                      color: context.primaryTextColor,
                    ),
                  ),
                ),
                Text(
                  _fmt(d.totalAmount),
                  style: customTextStyle(
                    fontSize: Responsive.sp(18),
                    fontWeight: FontWeight.bold,
                    color: green,
                  ),
                ),
              ],
            ),
          ),
          if (savings > 0) ...[
            height(Responsive.h(8)),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'You saved ${_fmt(savings.toString())} on this order',
                style: customTextStyle(
                  fontSize: Responsive.sp(10.5),
                  fontWeight: FontWeight.w600,
                  color: green,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color get _dotColor => Colors.grey.shade400;

  Widget _summaryRow(
    BuildContext context, {
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Responsive.h(11)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              softWrap: true,
              overflow: TextOverflow.visible,
              style: customTextStyle(
                fontSize: Responsive.sp(12),
                color: Colors.grey.shade600,
              ),
            ),
          ),
          width(Responsive.w(12)),
          Expanded(
            flex: 6,
            child: Text(
              value,
              softWrap: true,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.right,
              style: customTextStyle(
                fontSize: Responsive.sp(12),
                fontWeight: FontWeight.bold,
                color: valueColor ?? context.primaryTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardAndCoupon(
    BuildContext context,
    PaymentSummaryData d,
    EventsState s,
    bool busy,
  ) {
    final points = s.availableRewardPoints ?? d.availableRewardPoints;
    final rewardAmount = _amount(d.rewardDiscountAmount);

    final subtitle = points == 0
        ? 'No reward points available.'
        : (s.redeemPoints && rewardAmount > 0)
        ? 'Saved ${_fmt(d.rewardDiscountAmount)} using ${d.rewardPointsUsed} pts.'
        : 'You have $points pts available on this order.';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.w(16)),
      decoration: cardDecoration(context, radius: 18),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.star_rounded,
                color: Colors.amber.shade700,
                size: Responsive.sp(20),
              ),
              width(Responsive.w(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Redeem Reward Points',
                      style: customTextStyle(
                        fontSize: Responsive.sp(12.5),
                        fontWeight: FontWeight.bold,
                        color: context.primaryTextColor,
                      ),
                    ),
                    height(Responsive.h(2)),
                    Text(
                      subtitle,
                      style: customTextStyle(
                        fontSize: Responsive.sp(10.5),
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Switch.adaptive(
                value: s.redeemPoints,
                activeColor: AppColors.newPri,
                onChanged: (points == 0 || busy) ? null : _toggleRewards,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: Responsive.h(12)),
            child: Divider(height: 1, color: context.borderColor),
          ),
          if (s.appliedCoupon != null)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.w(12),
                vertical: Responsive.h(10),
              ),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(Responsive.w(12)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.local_offer_rounded,
                    size: Responsive.sp(16),
                    color: Colors.green.shade700,
                  ),
                  width(Responsive.w(8)),
                  Expanded(
                    child: Text(
                      '${s.appliedCoupon} applied · saved ${_fmt(d.couponDiscountAmount)}',
                      style: customTextStyle(
                        fontSize: Responsive.sp(11.5),
                        fontWeight: FontWeight.w600,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: busy ? null : _removeCoupon,
                    child: Icon(
                      Icons.close_rounded,
                      size: Responsive.sp(18),
                      color: Colors.green.shade700,
                    ),
                  ),
                ],
              ),
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    controller: _couponCtrl,
                    enabled: !busy,
                    textCapitalization: TextCapitalization.characters,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _applyCoupon(),
                    onChanged: (_) {
                      if (ref.read(eventsViewModelProvider).couponError !=
                          null) {
                        _vm.clearCouponError();
                      }
                    },
                    style: customTextStyle(
                      fontSize: Responsive.sp(12),
                      color: context.primaryTextColor,
                    ),
                    decoration: _inputDecoration(
                      context,
                      hint: 'Have a discount coupon? Enter code',
                      errorText: s.couponError,
                    ),
                  ),
                ),
                width(Responsive.w(10)),
                SizedBox(
                  height: Responsive.h(48),
                  child: OutlinedButton(
                    onPressed: busy ? null : _applyCoupon,
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Responsive.w(28)),
                      ),
                      side: BorderSide(color: context.borderColor),
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.w(22),
                      ),
                    ),
                    child: s.applyingCoupon
                        ? SizedBox(
                            width: Responsive.w(16),
                            height: Responsive.w(16),
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Apply',
                            style: customTextStyle(
                              fontSize: Responsive.sp(12.5),
                              fontWeight: FontWeight.bold,
                              color: context.primaryTextColor,
                            ),
                          ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(
    BuildContext context,
    PaymentSummaryData data,
    EventsState s,
    bool busy,
  ) {
    final isZero = _amount(data.totalAmount) <= 0;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(
          Responsive.w(16),
          Responsive.h(10),
          Responsive.w(16),
          Responsive.h(10),
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border(top: BorderSide(color: context.borderColor)),
        ),
        child: SizedBox(
          width: double.infinity,
          height: Responsive.h(50),
          child: ElevatedButton(
            onPressed: busy ? null : () => _pay(data),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.newPri,
              foregroundColor: Colors.white,
              disabledBackgroundColor: AppColors.newPri.withValues(alpha: 0.6),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Responsive.w(28)),
              ),
            ),
            child: s.paying
                ? SizedBox(
                    width: Responsive.w(20),
                    height: Responsive.w(20),
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock_rounded, size: Responsive.sp(16)),
                      width(Responsive.w(8)),
                      Text(
                        isZero
                            ? 'Confirm Registration'
                            : 'Pay ${_fmt(data.totalAmount)}',
                        style: customTextStyle(
                          fontSize: Responsive.sp(14),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(
    BuildContext context, {
    required String hint,
    String? errorText,
  }) {
    OutlineInputBorder border(Color c, [double w = 1]) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(Responsive.w(14)),
      borderSide: BorderSide(color: c, width: w),
    );

    return InputDecoration(
      hintText: hint,
      errorText: errorText,
      errorMaxLines: 2,
      isDense: true,
      filled: true,
      fillColor: Theme.of(context).scaffoldBackgroundColor,
      hintStyle: customTextStyle(
        fontSize: Responsive.sp(12),
        color: Colors.grey.shade500,
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: Responsive.w(16),
        vertical: Responsive.h(15),
      ),
      enabledBorder: border(context.borderColor),
      disabledBorder: border(context.borderColor),
      focusedBorder: border(AppColors.newPri, 1.4),
      errorBorder: border(Colors.red.shade400),
      focusedErrorBorder: border(Colors.red.shade400, 1.4),
    );
  }
}

class _DottedDivider extends StatelessWidget {
  final Color color;

  const _DottedDivider({required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 2,
      child: CustomPaint(painter: _DottedLinePainter(color: color)),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  final Color color;

  const _DottedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    const radius = 0.9;
    const step = 5.0;
    double x = radius;
    while (x < size.width) {
      canvas.drawCircle(Offset(x, size.height / 2), radius, paint);
      x += step;
    }
  }

  @override
  bool shouldRepaint(covariant _DottedLinePainter oldDelegate) =>
      oldDelegate.color != color;
}
