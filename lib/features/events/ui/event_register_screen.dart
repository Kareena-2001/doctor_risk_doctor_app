import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/common/ui/widgets/loading.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/events/model/event_list_response.dart';
import 'package:Doctors_App/features/events/ui/view_model/events_view_model.dart';
import 'package:Doctors_App/features/events/ui/widget/event_payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/dimensions.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../theme/app_colors.dart';

class EventRegisterScreen extends ConsumerStatefulWidget {
  final EventModel event;

  const EventRegisterScreen({super.key, required this.event});

  @override
  ConsumerState<EventRegisterScreen> createState() =>
      _EventRegisterScreenState();
}

class _EventRegisterScreenState extends ConsumerState<EventRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _memberIdController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _prefilled = false;
  String _membershipStatus = '';
  int? _doctorId;
  bool _isProcessing = false;

  String? _registrationId;
  double get _eventPrice =>
      double.tryParse(
        widget.event.price?.replaceAll(',', '').trim() ?? '',
      ) ??
          0;
  // double get _eventPrice => widget.event.price.toDouble();

  bool get _isPaidEvent => _eventPrice > 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(eventsViewModelProvider.notifier).fetchDoctorDetails(),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _memberIdController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _prefillFromDoctorDetails() {
    final doctorDetails = ref.read(eventsViewModelProvider).doctorDetails;

    doctorDetails.whenData((response) {
      final data = response?.data;
      if (data == null || _prefilled) return;

      _nameController.text = data.fullName;
      _memberIdController.text = data.doctorNo;
      _emailController.text = data.email;
      _phoneController.text = data.mobileNo;
      _membershipStatus = data.doctorStatus;
      _doctorId = data.id;
      _prefilled = true;
    });
  }

  Future<bool> _callRegisterApi() {
    return ref
        .read(eventsViewModelProvider.notifier)
        .submitEventRegistration(
          eventId: widget.event.id,
          doctorId: _doctorId!,
          fullName: _nameController.text.trim(),
          emailId: _emailController.text.trim(),
          mobileNo: _phoneController.text.trim(),
          membershipStatus: _membershipStatus,
        );
  }

  String _registerErrorMessage() {
    final registerState = ref.read(eventsViewModelProvider).registerEvent;
    String message = 'Registration failed. Please try again.';
    registerState.whenOrNull(
      error: (error, _) =>
          message = error.toString().replaceFirst('Exception: ', ''),
    );
    return message;
  }

  String? _extractRegistrationId() {
    final response = ref
        .read(eventsViewModelProvider)
        .registerEvent
        .valueOrNull;
    return response?.data.registrationId.toString();
  }

  Future<void> _submitRegistration() async {
    if (!_formKey.currentState!.validate()) return;

    if (_doctorId == null) {
      context.showWarningSnackBar('Unable to load your profile. Please retry.');
      return;
    }

    if (_isPaidEvent) {
      await _startPaidFlow();
    } else {
      await _startFreeFlow();
    }
  }

  // ---------- FREE: unchanged ----------
  Future<void> _startFreeFlow() async {
    final success = await _callRegisterApi();
    if (!mounted) return;

    if (success) {
      context.showSuccessSnackBar(
        'Successfully registered for ${widget.event.title}!',
      );
      Navigator.pop(context, true);
    } else {
      context.showErrorSnackBar(_registerErrorMessage());
    }
  }

  // ---------- PAID: register -> payment summary screen ----------
  Future<void> _startPaidFlow() async {
    setState(() => _isProcessing = true);

    try {
      // 1) create registration (only once)
      if (_registrationId == null) {
        final registered = await _callRegisterApi();
        if (!mounted) return;

        if (!registered) {
          context.showErrorSnackBar(_registerErrorMessage());
          return;
        }

        _registrationId = _extractRegistrationId();
        if (_registrationId == null) {
          context.showErrorSnackBar(
            'Could not start payment. Please try again.',
          );
          return;
        }
      }

      // 2) payment screen (calls payment summary API itself)
      final paid = await Navigator.of(context).push<bool>(
        MaterialPageRoute(
          builder: (_) => PaymentScreen(
            eventRegistrationId: _registrationId!,
            feeLabel: 'Event registration fee',
            // onPay: (summary) async { /* TODO: payment gateway */ },
          ),
        ),
      );

      if (!mounted) return;

      if (paid == true) {
        context.showSuccessSnackBar(
          'Payment successful. Registered for ${widget.event.title}!',
        );
        Navigator.pop(context, true);
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final doctorDetails = ref.watch(eventsViewModelProvider).doctorDetails;
    final registerState = ref.watch(eventsViewModelProvider).registerEvent;

    _prefillFromDoctorDetails();

    final isLoadingProfile = doctorDetails.isLoading && !_prefilled;
    final isSubmitting = registerState.isLoading || _isProcessing;

    return Scaffold(
      backgroundColor: context.primaryBackgroundColor,
      appBar: CustomAppBar(title: "Event Registration"),
      body: isLoadingProfile
          ? const Center(child: Loading())
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(Responsive.w(16)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildEventSummaryCard(),
                      height(Responsive.h(24)),
                      CustomTextField(
                        label: "Member Id",
                        controller: _memberIdController,
                        icon: Icons.person_outline_rounded,
                        readOnly: true,
                      ),
                      height(Responsive.h(16)),
                      CustomTextField(
                        label: "Full Name",
                        controller: _nameController,
                        icon: Icons.person_outline_rounded,
                        validator: (val) =>
                            val!.isEmpty ? 'Please enter your name' : null,
                      ),
                      height(Responsive.h(16)),
                      CustomTextField(
                        label: "Email Address",
                        controller: _emailController,
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val!.isEmpty) return 'Please enter your email';
                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(val)) {
                            return 'Please enter a valid  email address';
                          }
                          return null;
                        },
                      ),
                      height(Responsive.h(16)),
                      CustomTextField(
                        label: "Mobile Number",
                        controller: _phoneController,
                        icon: Icons.phone_android_outlined,
                        keyboardType: TextInputType.phone,
                        validator: (val) =>
                            val!.isEmpty ? 'Please enter mobile number' : null,
                      ),
                      height(Responsive.h(32)),
                      PrimaryButton(
                        borderRadius: 25,
                        gradient: LinearGradient(
                          colors: [AppColors.primary, AppColors.newPri],
                        ),
                        fontSize: 14,
                        height: 48,
                        text: isSubmitting
                            ? "Please wait..."
                            : (_isPaidEvent
                                  ? "Proceed to Payment"
                                  : "Confirm Registration"),
                        backgroundColor: AppColors.newPri,
                        onPressed: isSubmitting ? null : _submitRegistration,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildEventSummaryCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.w(16)),
      decoration: BoxDecoration(
        color: context.secondaryWidgetColor,
        borderRadius: BorderRadius.circular(Responsive.w(16)),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.event.title,
            style: customTextStyle(
              fontSize: Responsive.sp(14),
              fontWeight: FontWeight.bold,
              color: context.primaryTextColor,
            ),
          ),
          height(Responsive.h(12)),
          Wrap(
            spacing: Responsive.w(12),
            runSpacing: Responsive.h(6),
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    size: Responsive.sp(14),
                    color: AppColors.homeTextMuted,
                  ),
                  width(Responsive.w(4)),
                  Text(
                    widget.event.date,
                    style: customTextStyle(
                      fontSize: Responsive.sp(11),
                      color: AppColors.homeTextMuted,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    size: Responsive.sp(14),
                    color: AppColors.homeTextMuted,
                  ),
                  width(Responsive.w(4)),
                  Text(
                    widget.event.time,
                    style: customTextStyle(
                      fontSize: Responsive.sp(11),
                      color: AppColors.homeTextMuted,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.event.eventType == 'Online'
                        ? Icons.videocam_outlined
                        : Icons.location_on_outlined,
                    size: Responsive.sp(14),
                    color: AppColors.homeTextMuted,
                  ),
                  width(Responsive.w(4)),
                  Text(
                    widget.event.eventType,
                    style: customTextStyle(
                      fontSize: Responsive.sp(11),
                      color: AppColors.homeTextMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
          height(Responsive.h(8)),
          Text(
              (widget.event.priceDescription?.isNotEmpty ?? false)
                  ? widget.event.priceDescription!
                  : (_isPaidEvent ? '₹${widget.event.price}' : 'Free'),
            style: customTextStyle(fontSize: Responsive.sp(11)),
          ),
        ],
      ),
    );
  }
}
