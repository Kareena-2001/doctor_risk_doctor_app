import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/custom_dropdown_field.dart';
import 'package:Doctors_App/core/widgets/custom_text_field.dart';
import 'package:Doctors_App/features/authentication/ui/state/authentication_state.dart'; // IdNameOption (same import the collaborate screen uses)
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/product/model/purchase_model.dart';
import 'package:Doctors_App/features/profile/model/doctor_profile_response.dart';
import 'package:Doctors_App/features/profile/ui/view_model/profile_view_model.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileAddressFormSheet extends ConsumerStatefulWidget {
  final DoctorAddress? existing;
  final Future<void> Function({
    required String addressType,
    required String ownVisiting,
    required String address1,
    required String address2,
    required String landmark,
    required String area,
    required String stateId,
    required String cityId,
    required String pincode,
  })
  onSave;

  const ProfileAddressFormSheet({
    super.key,
    this.existing,
    required this.onSave,
  });

  @override
  ConsumerState<ProfileAddressFormSheet> createState() =>
      _ProfileAddressFormSheetState();
}

class _ProfileAddressFormSheetState
    extends ConsumerState<ProfileAddressFormSheet> {
  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;

  late final TextEditingController _address1Ctrl;
  late final TextEditingController _address2Ctrl;
  late final TextEditingController _landmarkCtrl;
  late final TextEditingController _areaCtrl;
  late final TextEditingController _pinCodeCtrl;
  final _cityCtrl = TextEditingController();
  final _stateCtrl = TextEditingController();

  late AddressType _type;
  late OwnOrVisiting _ownOrVisiting;

  // label -> option (same approach as the collaborate form)
  final Map<String, IdNameOption> _stateByLabel = {};
  final Map<String, IdNameOption> _cityByLabel = {};
  IdNameOption? _selectedState;
  IdNameOption? _selectedCity;

  // Edit mode: existing address only has names, so we match them to
  // options once the lists are loaded.
  String? _pendingStateName;
  String? _pendingCityName;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _address1Ctrl = TextEditingController(text: existing?.address1 ?? '');
    _address2Ctrl = TextEditingController(text: existing?.address2 ?? '');
    _landmarkCtrl = TextEditingController(text: existing?.landmark ?? '');
    _areaCtrl = TextEditingController(text: existing?.area ?? '');
    _pinCodeCtrl = TextEditingController(text: existing?.pincode ?? '');
    _type = _addressTypeFromApi(existing?.addressType);
    _ownOrVisiting = _ownOrVisitingFromApi(existing?.ownVisiting);

    final st = existing?.state?.trim();
    final ct = existing?.city?.trim();
    _pendingStateName = (st == null || st.isEmpty) ? null : st;
    _pendingCityName = (ct == null || ct.isEmpty) ? null : ct;
  }

  @override
  void dispose() {
    _address1Ctrl.dispose();
    _address2Ctrl.dispose();
    _landmarkCtrl.dispose();
    _areaCtrl.dispose();
    _pinCodeCtrl.dispose();
    _cityCtrl.dispose();
    _stateCtrl.dispose();
    super.dispose();
  }

  AddressType _addressTypeFromApi(String? raw) {
    final v = (raw ?? '').trim().toLowerCase();
    for (final type in AddressType.values) {
      if (type.label.toLowerCase() == v || type.name.toLowerCase() == v) {
        return type;
      }
    }
    if (v.contains('hospital')) return AddressType.hospital;
    if (v.contains('clinic')) return AddressType.clinic;
    if (v.contains('office')) return AddressType.office;
    return AddressType.home;
  }

  OwnOrVisiting _ownOrVisitingFromApi(String? raw) {
    final v = (raw ?? '').trim().toLowerCase();
    if (v.contains('visit')) return OwnOrVisiting.visiting;
    return OwnOrVisiting.own;
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

  String? _matchLabel(String name, Map<String, IdNameOption> map) {
    final n = name.trim().toLowerCase();
    for (final e in map.entries) {
      if (e.value.name.trim().toLowerCase() == n) return e.key;
    }
    return null;
  }

  /// Edit mode: fill state, then city, from the existing address names.
  void _applyPrefill(List<String> stateLabels, List<String> cityLabels) {
    if (_pendingStateName != null && stateLabels.isNotEmpty) {
      final label = _matchLabel(_pendingStateName!, _stateByLabel);
      _pendingStateName = null;
      if (label != null) {
        final option = _stateByLabel[label]!;
        _stateCtrl.text = label;
        _selectedState = option;
        // loads the cities for this state
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            ref.read(profileViewModelProvider.notifier).selectState(option);
          }
        });
      } else {
        _pendingCityName = null; // state not found, skip city
      }
      return;
    }

    if (_pendingStateName == null &&
        _pendingCityName != null &&
        _selectedState != null &&
        cityLabels.isNotEmpty) {
      final label = _matchLabel(_pendingCityName!, _cityByLabel);
      _pendingCityName = null;
      if (label != null) {
        _cityCtrl.text = label;
        _selectedCity = _cityByLabel[label];
      }
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate() || _isSaving) return;

    final state = _selectedState;
    final city = _selectedCity;
    if (state == null || city == null) return;

    setState(() => _isSaving = true);
    try {
      await widget.onSave(
        addressType: _type.label,
        ownVisiting: _ownOrVisiting.label,
        address1: _address1Ctrl.text.trim(),
        address2: _address2Ctrl.text.trim(),
        landmark: _landmarkCtrl.text.trim(),
        area: _areaCtrl.text.trim(),
        stateId: state.id.toString(),
        cityId: city.id.toString(),
        pincode: _pinCodeCtrl.text.trim(),
      );
      if (mounted) Navigator.of(context).pop();
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;

    final profileState = ref.watch(profileViewModelProvider).valueOrNull;
    final states = profileState?.states ?? const <IdNameOption>[];
    final cities = profileState?.cities ?? const <IdNameOption>[];
    final isCityLoading = profileState?.isCityLoading ?? false;

    final stateLabels = _uniqueLabels(states, _stateByLabel);
    final cityLabels = _uniqueLabels(cities, _cityByLabel);

    _applyPrefill(stateLabels, cityLabels);

    // Drop stale selections if the lists changed under us.
    if (_stateCtrl.text.isNotEmpty && !stateLabels.contains(_stateCtrl.text)) {
      if (_pendingStateName == null && stateLabels.isNotEmpty) {
        _stateCtrl.clear();
        _selectedState = null;
      }
    }
    if (_cityCtrl.text.isNotEmpty && !cityLabels.contains(_cityCtrl.text)) {
      if (!isCityLoading) {
        _cityCtrl.clear();
        _selectedCity = null;
      }
    }

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                height(16),
                Text(
                  isEdit ? 'Edit address' : 'Add address',
                  style: customTextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                height(16),
                Row(
                  children: [
                    Expanded(
                      child: CustomDropdownField<AddressType>(
                        label: 'Address type',
                        items: AddressType.values,
                        value: _type,
                        itemBuilder: (t) => t.label,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _type = value);
                          }
                        },
                      ),
                    ),
                    width(10),
                    Expanded(
                      child: CustomDropdownField<OwnOrVisiting>(
                        label: 'Own/visiting',
                        items: OwnOrVisiting.values,
                        value: _ownOrVisiting,
                        itemBuilder: (t) => t.label,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _ownOrVisiting = value);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                height(10),
                CustomTextField(
                  label: 'Address 1',
                  controller: _address1Ctrl,
                  isRequired: true,
                ),
                height(10),
                CustomTextField(label: 'Address 2', controller: _address2Ctrl),
                height(10),
                CustomTextField(label: 'Landmark', controller: _landmarkCtrl),
                height(10),
                CustomTextField(label: 'Area', controller: _areaCtrl),
                height(10),
                CustomDropdownField(
                  label: 'State',
                  controller: _stateCtrl,
                  hint: 'Select state',
                  items: stateLabels,
                  value: _stateCtrl.text.isEmpty ? null : _stateCtrl.text,
                  onChanged: (label) {
                    final option = label == null ? null : _stateByLabel[label];
                    if (option == null) return;
                    setState(() {
                      _selectedState = option;
                      _selectedCity = null;
                      _cityCtrl.clear();
                    });
                    ref
                        .read(profileViewModelProvider.notifier)
                        .selectState(option);
                  },
                ),
                height(10),
                CustomDropdownField(
                  label: isCityLoading ? 'City (loading...)' : 'City',
                  controller: _cityCtrl,
                  hint: _selectedState == null
                      ? 'Select state first'
                      : 'Select city',
                  items: cityLabels,
                  value: _cityCtrl.text.isEmpty ? null : _cityCtrl.text,
                  isEnabled: _selectedState != null,
                  onChanged: (label) {
                    final option = label == null ? null : _cityByLabel[label];
                    if (option == null) return;
                    setState(() => _selectedCity = option);
                  },
                ),
                height(10),
                CustomTextField(
                  label: 'Pin code',
                  controller: _pinCodeCtrl,
                  isRequired: true,
                  keyboardType: TextInputType.number,
                ),
                height(20),
                PrimaryButton(
                  height: 50,
                  text: isEdit ? 'Update address' : 'Save address',
                  backgroundColor: AppColors.newPri,
                  isLoading: _isSaving,
                  onPressed: _isSaving ? null : _save,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
