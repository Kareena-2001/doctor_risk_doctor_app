import 'package:Doctors_App/core/exceptions/app_exception.dart';
import 'package:Doctors_App/core/widgets/custom_date_picker.dart';
import 'package:Doctors_App/core/widgets/custom_dropdown_field.dart';
import 'package:Doctors_App/core/widgets/custom_text_field.dart';
import 'package:Doctors_App/core/widgets/custom_time_picker.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/events/ui/view_model/events_view_model.dart';
import 'package:Doctors_App/features/profile/ui/view_model/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/dimensions.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../theme/app_colors.dart';
import '../../authentication/ui/state/authentication_state.dart';

class EventCollaborateScreen extends ConsumerStatefulWidget {
  const EventCollaborateScreen({super.key});

  @override
  ConsumerState<EventCollaborateScreen> createState() =>
      _EventCollaborateScreenState();
}

class _EventCollaborateScreenState
    extends ConsumerState<EventCollaborateScreen> {
  final _formKey = GlobalKey<FormState>();

  final _targetController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _organisationController = TextEditingController();
  final _modeOfEventController = TextEditingController();
  final _preferredDateController = TextEditingController();
  final _preferredTimeController = TextEditingController();
  final _areaController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _purposeController = TextEditingController();

  final Map<String, IdNameOption> _stateByLabel = {};
  final Map<String, IdNameOption> _cityByLabel = {};

  IdNameOption? _selectedState;
  IdNameOption? _selectedCity;

  @override
  void dispose() {
    _targetController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _organisationController.dispose();
    _modeOfEventController.dispose();
    _preferredDateController.dispose();
    _preferredTimeController.dispose();
    _areaController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _purposeController.dispose();
    super.dispose();
  }

  List<String> _uniqueLabels(
    List<IdNameOption> options,
    Map<String, IdNameOption> targetMap,
  ) {
    targetMap.clear();
    final counts = <String, int>{};
    final labels = <String>[];
    for (final o in options) {
      final base = o.name;
      final occurrence = (counts[base] ?? 0) + 1;
      counts[base] = occurrence;
      final label = occurrence == 1 ? base : '$base ($occurrence)';
      targetMap[label] = o;
      labels.add(label);
    }
    return labels;
  }

  String? _dateToApiFormat(String display) {
    final trimmed = display.trim();
    if (trimmed.isEmpty) return null;
    final parts = trimmed.split('/');
    if (parts.length != 3) return trimmed;
    final day = parts[0].padLeft(2, '0');
    final month = parts[1].padLeft(2, '0');
    final year = parts[2];
    return '$year-$month-$day';
  }

  Future<void> _submitCollaboration() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final success = await ref
        .read(eventsViewModelProvider.notifier)
        .addCollaboration(
          collaborationTarget: _targetController.text.trim(),
          fullName: _nameController.text.trim(),
          emailId: _emailController.text.trim().isEmpty
              ? null
              : _emailController.text.trim(),
          mobileNo: _mobileController.text.trim(),
          organisation: _organisationController.text.trim(),
          modeOfEvent: _modeOfEventController.text.trim().isEmpty
              ? null
              : _modeOfEventController.text.trim(),
          preferredDate: _dateToApiFormat(_preferredDateController.text),
          preferredTime: _preferredTimeController.text.trim().isEmpty
              ? null
              : _preferredTimeController.text.trim(),
          stateId: _selectedState?.id.toString(),
          cityId: _selectedCity?.id.toString(),
          area: _areaController.text.trim().isEmpty
              ? null
              : _areaController.text.trim(),
          purpose: _purposeController.text.trim().isEmpty
              ? null
              : _purposeController.text.trim(),
        );
    if (!mounted) return;

    if (success) {
      context.showSuccessSnackBar(
        'Collaboration proposal submitted successfully!',
      );
      context.pop();
      return;
    }

    final error = ref.read(eventsViewModelProvider).addCollaboration.error;
    final message = error is ApiException
        ? error.message
        : (error?.toString() ?? 'Failed to submit collaboration proposal.');
    context.showErrorSnackBar(message);
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileViewModelProvider).valueOrNull;
    final states = profileState?.states ?? const <IdNameOption>[];
    final cities = profileState?.cities ?? const <IdNameOption>[];
    final isCityLoading = profileState?.isCityLoading ?? false;

    final stateLabels = _uniqueLabels(states, _stateByLabel);
    final cityLabels = _uniqueLabels(cities, _cityByLabel);

    if (_stateController.text.isNotEmpty &&
        !stateLabels.contains(_stateController.text)) {
      _stateController.clear();
      _selectedState = null;
    }
    if (_cityController.text.isNotEmpty &&
        !cityLabels.contains(_cityController.text)) {
      _cityController.clear();
      _selectedCity = null;
    }

    return Scaffold(
      backgroundColor:context.primaryBackgroundColor,
      appBar: CustomAppBar(title: 'Collaborate Proposal'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Responsive.w(16)),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildContextSummaryCard(),
              height(Responsive.h(24)),
              CustomDropdownField(
                hint: 'Select Option',
                label: 'Collaboration Target',
                controller: _targetController,
                items: const [
                  'Host a Joint Webinar / CME',
                  'Sponsor an Event',
                  'Speaker Exchange',
                  'Workshop Partnership',
                  'Other',
                ],
              ),
              height(Responsive.h(16)),
              CustomTextField(
                label: 'Full Name',
                controller: _nameController,
                icon: Icons.person_outline_rounded,
                hint: 'Your full name',
              ),
              height(Responsive.h(16)),
              CustomTextField(
                isRequired: false,
                label: 'Email',
                controller: _emailController,
                icon: Icons.email_outlined,
                hint: 'Your email address',
                keyboardType: TextInputType.emailAddress,
              ),
              height(Responsive.h(16)),
              CustomTextField(
                label: 'Mobile Number',
                controller: _mobileController,
                icon: Icons.phone_outlined,
                hint: 'Your mobile number',
                keyboardType: TextInputType.phone,
              ),
              height(Responsive.h(16)),
              CustomTextField(
                label: 'Organisation',
                controller: _organisationController,
                icon: Icons.business_outlined,
                hint: 'Hospital / association / institute',
              ),
              height(Responsive.h(16)),
              CustomDropdownField(
                isRequired: false,
                label: 'Mode of Event',
                controller: _modeOfEventController,
                icon: Icons.event_available_outlined,
                hint: 'Select mode',
                items: const ['Online', 'Offline'],
              ),
              height(Responsive.h(16)),
              CustomDatePicker(
                isRequired: false,
                label: 'Preferred Date',
                controller: _preferredDateController,
                hint: 'Preferred date',
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 3650)),
                    initialDate: DateTime.now(),
                  );

                  if (date != null) {
                    _preferredDateController.text =
                        '${date.day.toString().padLeft(2, '0')}/'
                        '${date.month.toString().padLeft(2, '0')}/'
                        '${date.year}';
                  }
                },
              ),
              height(Responsive.h(16)),
              CustomTimePicker(
                label: 'Preferred Time',
                controller: _preferredTimeController,
                hint: 'Preferred time',
                isRequired: false,
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          dialogTheme: const DialogThemeData(
                            backgroundColor: Colors.white,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );

                  if (time != null) {
                    _preferredTimeController.text = time.format(context);
                  }
                },
              ),
              height(Responsive.h(16)),
              CustomTextField(
                isRequired: false,
                label: 'Area',
                controller: _areaController,
                icon: Icons.location_on_outlined,
                hint: 'Locality',
              ),
              height(Responsive.h(16)),
              CustomDropdownField(
                isRequired: false,
                label: 'State',
                controller: _stateController,
                // icon: Icons.map_outlined,
                hint: 'Select state',
                items: stateLabels,
                value: _stateController.text.isEmpty
                    ? null
                    : _stateController.text,
                onChanged: (label) {
                  final option = label == null ? null : _stateByLabel[label];
                  if (option == null) return;
                  setState(() {
                    _selectedState = option;
                    _selectedCity = null;
                    _cityController.clear();
                  });
                  ref
                      .read(profileViewModelProvider.notifier)
                      .selectState(option);
                },
              ),
              height(Responsive.h(16)),
              CustomDropdownField(
                isRequired: false,
                label: isCityLoading ? 'City (loading...)' : 'City',
                controller: _cityController,
                // icon: Icons.location_city_outlined,
                hint: _selectedState == null
                    ? 'Select state first'
                    : 'Select city',
                items: cityLabels,
                value: _cityController.text.isEmpty
                    ? null
                    : _cityController.text,
                isEnabled: _selectedState != null,
                onChanged: (label) {
                  final option = label == null ? null : _cityByLabel[label];
                  if (option == null) return;
                  setState(() => _selectedCity = option);
                },
              ),
              height(Responsive.h(16)),
              CustomTextField(
                isRequired: false,
                label: 'Purpose of Collaboration',
                controller: _purposeController,
                icon: Icons.handshake_outlined,
                hint: 'What would you like to organise, and why?',
                maxLines: 4,
              ),
              height(Responsive.h(32)),
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      text: 'Cancel',
                      backgroundColor: AppColors.white,
                      textColor: AppColors.textColor,
                      borderColor: AppColors.border,
                      onPressed: () => context.pop(),
                      borderRadius: 25,
                      fontSize: 14,
                      height: 48,
                    ),
                  ),
                  width(Responsive.w(12)),
                  Expanded(
                    child: PrimaryButton(
                      text: 'Submit Proposal',
                      gradient: LinearGradient(
                        colors: [AppColors.primary, AppColors.newPri],
                      ),
                      onPressed: _submitCollaboration,
                      textColor: AppColors.white,
                      borderColor: AppColors.border,
                      borderRadius: 25,
                      fontSize: 14,
                      height: 48,
                    ),
                  ),
                ],
              ),

              height(Responsive.h(16)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContextSummaryCard() {
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
            'Propose a Collaboration',
            style: customTextStyle(
              fontSize: Responsive.sp(13),
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          height(Responsive.h(8)),
          Text(
            'Tell us what you have in mind — our events team will reach out to confirm details.',
            style: customTextStyle(
              fontSize: Responsive.sp(11),
              fontWeight: FontWeight.w600,
              color: AppColors.homeTextMuted,
            ),
          ),
        ],
      ),
    );
  }
}
