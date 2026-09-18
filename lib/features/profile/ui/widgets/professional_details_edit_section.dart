import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/custom_dropdown_field.dart';
import 'package:Doctors_App/core/widgets/custom_text_field.dart';
import 'package:Doctors_App/features/authentication/ui/state/authentication_state.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/profile/ui/state/profile_state.dart';
import 'package:Doctors_App/features/profile/ui/view_model/profile_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/custom_multi_select_dropdown.dart';

class ProfessionalDetailsEditSection extends ConsumerWidget {
  const ProfessionalDetailsEditSection({
    super.key,
    required this.isSaving,
    required this.medicalRegStateCtrl,
    required this.medicalRegNoCtrl,
    required this.medicalRegYearCtrl,
    required this.retroactiveDateCtrl,
    required this.retroactiveCtrl,
    required this.worldwideCtrl,
    required this.unqualifiedStaffCtrl,
    required this.unqualifiedStaffCountCtrl,
    required this.onCancel,
    required this.onSave,
  });

  final bool isSaving;
  final TextEditingController medicalRegStateCtrl;
  final TextEditingController medicalRegNoCtrl;
  final TextEditingController medicalRegYearCtrl;
  final TextEditingController retroactiveDateCtrl;
  final TextEditingController retroactiveCtrl;
  final TextEditingController worldwideCtrl;
  final TextEditingController unqualifiedStaffCtrl;
  final TextEditingController unqualifiedStaffCountCtrl;
  final VoidCallback onCancel;
  final VoidCallback onSave;

  Widget _referenceDropdown({
    required String label,
    required String emptyHint,
    required bool isLoading,
    required List<IdNameOption> items,
    required IdNameOption? selected,
    required ValueChanged<IdNameOption> onSelected,
    bool disabled = false,
  }) {
    final blocked = disabled || isLoading;
    final hint = disabled ? emptyHint : (isLoading ? 'Loading...' : emptyHint);

    return CustomDropdownField<IdNameOption>(
      label: label,
      hint: hint,
      items: blocked ? const <IdNameOption>[] : items,
      value: selected,
      itemBuilder: (item) => item.name,
      onChanged: blocked
          ? null
          : (val) {
              if (val == null) return;
              onSelected(val);
            },
    );
  }

  Widget _degreeEditorField(
    BuildContext context,
    WidgetRef ref,
    ProfileState state,
  ) {
    return GestureDetector(
      onTap: state.isDegreeLoading
          ? null
          : () => _openDegreePicker(context, ref, state),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'DEGREE',
          suffixIcon: const Icon(Icons.arrow_drop_down),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: state.isDegreeLoading
            ? Text(
                'Loading...',
                style: customTextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade500,
                ),
              )
            : state.selectedDegrees.isEmpty
            ? Text(
                state.degrees.isEmpty
                    ? 'No degrees available'
                    : 'Select Degree(s)',
                style: customTextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade500,
                ),
              )
            : Wrap(
                spacing: 6,
                runSpacing: 6,
                children: state.selectedDegrees
                    .map(
                      (d) => Chip(
                        label: Text(d.name),
                        onDeleted: () {
                          ref
                              .read(profileViewModelProvider.notifier)
                              .setSelectedDegrees(
                                state.selectedDegrees
                                    .where((e) => e.id != d.id)
                                    .toList(),
                              );
                        },
                      ),
                    )
                    .toList(),
              ),
      ),
    );
  }

  Future<void> _openDegreePicker(
    BuildContext context,
    WidgetRef ref,
    ProfileState state,
  ) async {
    final notifier = ref.read(profileViewModelProvider.notifier);
    final tempSelected = [...state.selectedDegrees];

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Degree(s)',
                    style: customTextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  height(12),
                  if (state.degrees.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Center(
                        child: Text(
                          'No degrees available',
                          style: customTextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                    )
                  else
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.degrees.length,
                        itemBuilder: (context, index) {
                          final degree = state.degrees[index];
                          final isChecked = tempSelected.any(
                            (item) => item.id == degree.id,
                          );

                          return CheckboxListTile(
                            value: isChecked,
                            title: Text(
                              degree.name,
                              style: customTextStyle(fontSize: 13),
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsets.zero,
                            onChanged: (checked) {
                              setSheetState(() {
                                if (checked == true) {
                                  if (!tempSelected.any(
                                    (item) => item.id == degree.id,
                                  )) {
                                    tempSelected.add(degree);
                                  }
                                } else {
                                  tempSelected.removeWhere(
                                    (item) => item.id == degree.id,
                                  );
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),
                  height(12),
                  PrimaryButton(
                    height: 46,
                    fontSize: 14,
                    text: 'Done',
                    onPressed: state.degrees.isEmpty
                        ? null
                        : () {
                            notifier.setSelectedDegrees(tempSelected);
                            Navigator.of(sheetContext).pop();
                          },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state =
        ref.watch(profileViewModelProvider).valueOrNull ?? const ProfileState();
    final notifier = ref.read(profileViewModelProvider.notifier);
    final showRetroactiveDate = retroactiveCtrl.text.toLowerCase() == 'yes';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _referenceDropdown(
          label: 'CATEGORY',
          emptyHint: 'Select Category',
          isLoading: state.isCategoryLoading,
          items: state.categories,
          selected: state.selectedCategory,
          onSelected: notifier.selectCategory,
        ),
        height(12),
        _referenceDropdown(
          label: 'SPECIALITY',
          emptyHint: state.selectedCategory == null
              ? 'Select a category first'
              : 'Select Speciality',
          disabled: state.selectedCategory == null,
          isLoading: state.isSpecialityLoading,
          items: state.specialities,
          selected: state.selectedSpeciality,
          onSelected: notifier.selectSpeciality,
        ),
        height(20),
        CustomMultiSelectDropdownField<IdNameOption>(
          label: 'Degree',
          hint: state.degrees.isEmpty
              ? 'No degrees available'
              : 'Select Degree(s)',
          items: state.degrees,
          selectedItems: state.selectedDegrees,
          itemLabel: (d) => d.name,
          isEqual: (a, b) => a.id == b.id,
          isLoading: state.isDegreeLoading,
          allowCustomEntry: true,
          customEntryLabel: 'Other',
          onCreateCustomItem: (value) => IdNameOption(
            id: -DateTime.now().millisecondsSinceEpoch,
            name: value,
          ),
          onChanged: notifier.setSelectedDegrees,
        ),
        // _degreeEditorField(context, ref, state),
        height(12),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                isRequired: false,
                label: 'MEDICAL REG. STATE',
                controller: medicalRegStateCtrl,
              ),
            ),
            width(10),
            Expanded(
              child: CustomTextField(
                isRequired: false,
                label: 'MEDICAL REG. NO.',
                controller: medicalRegNoCtrl,
              ),
            ),
          ],
        ),
        height(12),
        CustomTextField(
          isRequired: false,
          label: 'MEDICAL REG. YEAR',
          controller: medicalRegYearCtrl,
        ),
        height(12),
        Row(
          children: [
            Expanded(
              child: CustomDropdownField(
                isRequired: false,
                label: 'RETROACTIVE',
                controller: retroactiveCtrl,
                value: retroactiveCtrl.text.isEmpty
                    ? null
                    : retroactiveCtrl.text,
                items: const ['Yes', 'No'],
                onChanged: (_) {},
              ),
            ),
            width(10),
            Expanded(
              child: CustomDropdownField(
                isRequired: false,
                value: worldwideCtrl.text.isEmpty ? null : worldwideCtrl.text,
                label: 'WORLDWIDE COVER',
                controller: worldwideCtrl,
                items: const ['Yes', 'No'],
              ),
            ),
          ],
        ),
        if (showRetroactiveDate) ...[
          height(12),
          CustomTextField(
            isRequired: false,
            label: 'RETROACTIVE DATE',
            controller: retroactiveDateCtrl,
          ),
        ],
        height(12),
        CustomDropdownField(
          isRequired: false,
          label: 'UNQUALIFIED STAFF',
          value: unqualifiedStaffCtrl.text.isEmpty
              ? null
              : unqualifiedStaffCtrl.text,
          controller: unqualifiedStaffCtrl,
          items: const ['Yes', 'No'],
        ),
        if (unqualifiedStaffCtrl.text.toLowerCase() == 'yes') ...[
          height(12),
          CustomTextField(
            label: 'UNQUALIFIED STAFF COUNT',
            controller: unqualifiedStaffCountCtrl,
          ),
        ],
        height(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            OutlinedButton(
              onPressed: isSaving ? null : onCancel,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text('Cancel'),
            ),
            width(12),
            ElevatedButton(
              onPressed: isSaving ? null : onSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16A34A),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: isSaving
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      'Save Changes',
                      style: customTextStyle(color: Colors.white),
                    ),
            ),
          ],
        ),
      ],
    );
  }
}
