import 'package:Doctors_App/core/widgets/app_dialog.dart';
import 'package:Doctors_App/core/widgets/custom_dropdown_field.dart';
import 'package:Doctors_App/core/widgets/custom_text_field.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/authentication/ui/state/authentication_state.dart'
    show IdNameOption;
import 'package:Doctors_App/features/community/ui/state/community_state.dart';
import 'package:Doctors_App/features/community/ui/view_model/community_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/responsive.dart';
import '../../../../core/constants/values/app_text_style.dart';
import '../../../../theme/app_colors.dart';
import '../../../common/ui/widgets/primary_button.dart';

class ReferDoctorForm extends ConsumerStatefulWidget {
  const ReferDoctorForm({super.key});

  @override
  ConsumerState<ReferDoctorForm> createState() => _ReferDoctorFormState();
}

class _ReferDoctorFormState extends ConsumerState<ReferDoctorForm> {
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _remarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(communityViewModelProvider.notifier);
      final state = ref.read(communityViewModelProvider);

      if (state.categories.isEmpty && !state.isCategoryLoading) {
        notifier.categoryList();
      }
      if (state.degrees.isEmpty && !state.isDegreeLoading) {
        notifier.degreeList();
      }
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _remarkController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final communityState = ref.read(communityViewModelProvider);

    if (_firstNameController.text.trim().isEmpty ||
        _lastNameController.text.trim().isEmpty ||
        _mobileController.text.trim().isEmpty) {
      context.showWarningSnackBar('Please fill in all required fields');
      return;
    }

    await ref
        .read(communityViewModelProvider.notifier)
        .addReferral(
          firstName: _firstNameController.text.trim(),
          middleName: _middleNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          mobileNo: _mobileController.text.trim(),
          email: _emailController.text.trim(),

          categoryId: communityState.selectedCategory?.id,
          specialityId: communityState.selectedSpeciality?.id,

          degree: communityState.selectedDegrees.isEmpty
              ? null
              : communityState.selectedDegrees.map((d) => d.name).join(', '),

          remark: _remarkController.text.trim(),
        );
  }

  Future<void> _openDegreePicker(CommunityState state) async {
    final notifier = ref.read(communityViewModelProvider.notifier);
    final tempSelected = [...state.selectedDegrees];

    await AppDialog.customBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return Container(
          color: Colors.white,
          child: StatefulBuilder(
            builder: (context, setSheetState) {
              return Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Degree(s)',
                      style: customTextStyle(
                        fontSize: Responsive.sp(15),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    height(Responsive.h(12)),
                    if (state.degrees.isEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Center(
                          child: Text(
                            'No degrees available',
                            style: customTextStyle(
                              fontSize: Responsive.sp(12),
                              color: Color(0xFF94A3B8),
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
                              tileColor: Colors.white,
                              value: isChecked,
                              title: Text(
                                degree.name,
                                style: customTextStyle(
                                  fontSize: Responsive.sp(13),
                                ),
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
                    height(Responsive.h(12)),
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
                      gradient: LinearGradient(
                        colors: [AppColors.newPri, AppColors.primary],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildReferenceDropdown({
    required String label,
    required String emptyHint,
    required bool isLoading,
    required String? error,
    required List<IdNameOption> items,
    required IdNameOption? selected,
    required ValueChanged<IdNameOption> onSelected,
    required VoidCallback onRetry,
    bool disabled = false,
    bool isRequired = false,
  }) {
    final blocked = disabled || isLoading || error != null;
    final hint = disabled
        ? emptyHint
        : isLoading
        ? 'Loading...'
        : error != null
        ? 'Failed to load — tap to retry'
        : emptyHint;

    final field = CustomDropdownField(
      isRequired: isRequired,
      label: label,
      hint: hint,
      items: blocked ? const <String>[] : items.map((e) => e.name).toList(),
      value: selected?.name,
      onChanged: blocked
          ? null
          : (val) {
              if (val == null) return;
              final match = items.firstWhere((e) => e.name == val);
              onSelected(match);
            },
    );

    return error != null
        ? GestureDetector(onTap: onRetry, child: field)
        : field;
  }

  Widget _buildDegreeField(CommunityState state) {
    final hasError = state.degreeError != null;
    final notifier = ref.read(communityViewModelProvider.notifier);

    return GestureDetector(
      onTap: () {
        if (hasError) {
          notifier.degreeList();
          return;
        }
        _openDegreePicker(state);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Degree',
          suffixIcon: hasError
              ? const Icon(Icons.refresh, size: 20)
              : const Icon(Icons.arrow_drop_down),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: state.isDegreeLoading
            ? Text(
                'Loading...',
                style: customTextStyle(
                  fontSize: Responsive.sp(13),
                  color: const Color(0xFF94A3B8),
                ),
              )
            : hasError
            ? Text(
                'Failed to load — tap to retry',
                style: customTextStyle(
                  fontSize: Responsive.sp(12),
                  color: Colors.red,
                ),
              )
            : state.selectedDegrees.isEmpty
            ? Text(
                state.degrees.isEmpty
                    ? 'No degrees available'
                    : 'Select Degree(s)',
                style: customTextStyle(
                  fontSize: Responsive.sp(13),
                  color: const Color(0xFF94A3B8),
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
                          notifier.setSelectedDegrees(
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

  @override
  Widget build(BuildContext context) {
    final communityNotifier = ref.read(communityViewModelProvider.notifier);
    final communityState = ref.watch(communityViewModelProvider);

    ref.listen(
      communityViewModelProvider.select((state) => state.addReferral),
      (previous, next) {
        next?.whenOrNull(
          data: (response) {
            if (!mounted) return;
            if (response.status) {
              _clearForm();
              context.showSuccessSnackBar(response.msg);
              ref
                  .read(communityViewModelProvider.notifier)
                  .refreshReferDoctorList();
            }
          },
          error: (error, stackTrace) {
            if (!mounted) return;
            context.showWarningSnackBar(error.toString());
          },
        );
      },
    );

    final referralState = ref.watch(
      communityViewModelProvider.select((state) => state.addReferral),
    );

    final isSubmitting = referralState?.isLoading ?? false;

    return Container(
      padding: EdgeInsets.all(Responsive.w(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Responsive.w(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Refer a colleague directly',
            style: customTextStyle(
              fontSize: Responsive.sp(14),
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          height(Responsive.h(4)),
          Text(
            "A form is required even if you've already shared your link.",
            style: customTextStyle(
              fontSize: Responsive.sp(11),
              color: Colors.grey.shade600,
            ),
          ),
          height(Responsive.h(14)),
          CustomTextField(
            label: 'First Name',
            controller: _firstNameController,
          ),
          height(Responsive.h(14)),
          CustomTextField(
            isRequired: false,
            label: 'Middle Name',
            controller: _middleNameController,
          ),
          height(Responsive.h(14)),
          CustomTextField(label: 'Last Name', controller: _lastNameController),
          height(Responsive.h(14)),
          CustomTextField(
            label: 'Mobile Number',
            controller: _mobileController,
            keyboardType: TextInputType.phone,
          ),
          height(Responsive.h(14)),
          CustomTextField(
            isRequired: false,
            label: 'Email',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          height(Responsive.h(14)),
          _buildReferenceDropdown(
            isRequired: false,
            label: 'Category',
            emptyHint: 'Select Category',
            isLoading: communityState.isCategoryLoading,
            error: communityState.categoryError,
            items: communityState.categories,
            selected: communityState.selectedCategory,
            onRetry: communityNotifier.categoryList,
            onSelected: communityNotifier.selectCategory,
          ),
          height(Responsive.h(14)),
          _buildReferenceDropdown(
            isRequired: false,
            label: 'Speciality',
            emptyHint: communityState.selectedCategory == null
                ? 'Select a category first'
                : 'Select Speciality',
            disabled: communityState.selectedCategory == null,
            isLoading: communityState.isSpecialityLoading,
            error: communityState.specialityError,
            items: communityState.specialities,
            selected: communityState.selectedSpeciality,
            onRetry: () {
              if (communityState.selectedCategory != null) {
                communityNotifier.specialityList(
                  categoryId: communityState.selectedCategory!.id.toString(),
                );
              }
            },
            onSelected: communityNotifier.selectSpeciality,
          ),
          height(Responsive.h(20)),
          _buildDegreeField(communityState),
          height(Responsive.h(14)),
          CustomTextField(
            isRequired: false,
            label: 'Remark',
            controller: _remarkController,
            maxLines: 2,
          ),
          height(Responsive.h(18)),
          SizedBox(
            width: double.infinity,
            height: Responsive.h(46),
            child: ElevatedButton(
              onPressed: isSubmitting ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.newPri,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Responsive.w(12)),
                ),
              ),
              child: isSubmitting
                  ? SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      'Submit Referral',
                      style: customTextStyle(
                        fontSize: Responsive.sp(13.5),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void _clearForm() {
    _firstNameController.clear();
    _middleNameController.clear();
    _lastNameController.clear();
    _mobileController.clear();
    _emailController.clear();
    _remarkController.clear();
    ref
        .read(communityViewModelProvider.notifier)
        .clearCategorySpecialityDegree();
  }
}
