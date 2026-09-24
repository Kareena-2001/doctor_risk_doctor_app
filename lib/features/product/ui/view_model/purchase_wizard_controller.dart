import 'package:Doctors_App/features/product/model/product_tier.dart';
import 'package:Doctors_App/features/profile/ui/view_model/profile_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/product_model.dart';
import '../../model/purchase_model.dart';
import '../state/purchase_wizard_state.dart';

part 'purchase_wizard_controller.g.dart';

@riverpod
class PurchaseWizardController extends _$PurchaseWizardController {
  @override
  PurchaseWizardState build(
    Product product,
    TierPlan tier,
    String duration,
    double sumAssured,
    double premium,
  ) {
    Future.microtask(loadAddresses);
    return PurchaseWizardState(
      product: product,
      tier: tier,
      duration: duration,
      sumAssured: sumAssured,
      premium: premium,
      isLoadingAddresses: true,
    );
  }

  void goToStep(WizardStep step) {
    state = state.copyWith(currentStep: step, errorMessage: null);
  }

  void nextStep() {
    final idx = state.currentStepIndex;
    if (idx < wizardStepOrder.length - 1) {
      state = state.copyWith(
        currentStep: wizardStepOrder[idx + 1],
        errorMessage: null,
      );
    }
  }

  void previousStep() {
    final idx = state.currentStepIndex;
    if (idx > 0) {
      state = state.copyWith(
        currentStep: wizardStepOrder[idx - 1],
        errorMessage: null,
      );
    }
  }

  void savePersonalDetails(PersonalDetails details) {
    state = state.copyWith(personalDetails: details);
    nextStep();
  }

  void saveHospitalDetails(HospitalDetails details) {
    state = state.copyWith(hospitalDetails: details);
    nextStep();
  }

  Future<void> loadAddresses() async {
    state = state.copyWith(isLoadingAddresses: true, errorMessage: null);
    try {
      var data = ref.read(profileViewModelProvider).valueOrNull?.profileData;
      if (data == null) {
        await ref
            .read(profileViewModelProvider.notifier)
            .getProfile(silent: true);
        data = ref.read(profileViewModelProvider).valueOrNull?.profileData;
      }
      state = state.copyWith(
        addresses: data?.addresses ?? const [],
        isLoadingAddresses: false,
      );
    } catch (_) {
      state = state.copyWith(
        isLoadingAddresses: false,
        errorMessage: 'Failed to load addresses. Please try again.',
      );
    }
  }

  void _syncAddressesFromProfile() {
    final addresses =
        ref
            .read(profileViewModelProvider)
            .valueOrNull
            ?.profileData
            ?.addresses ??
        const [];
    state = state.copyWith(addresses: addresses, isLoadingAddresses: false);
  }

  Future<void> addOrEditAddress({
    int? id,
    required String addressType,
    required String ownVisiting,
    required String address1,
    required String address2,
    required String landmark,
    required String area,
    required String stateName,
    required String city,
    required String pincode,
  }) async {
    await ref
        .read(profileViewModelProvider.notifier)
        .addOrEditAddress(
          id: id,
          addressType: addressType,
          ownVisiting: ownVisiting,
          address1: address1,
          address2: address2,
          landmark: landmark,
          area: area,
          stateId: stateName,
          cityId: city,
          pincode: pincode,
        );
    _syncAddressesFromProfile();
  }

  Future<void> deleteAddress(int id) async {
    await ref.read(profileViewModelProvider.notifier).deleteAddress(id);
    _syncAddressesFromProfile();
  }

  Future<bool> submit() async {
    if (!state.canSubmit) {
      state = state.copyWith(
        errorMessage: 'Please complete all steps before submitting.',
      );
      return false;
    }

    state = state.copyWith(isSubmitting: true, errorMessage: null);
    try {
      // await ref.read(planRepositoryProvider).purchasePlan(state);
      await Future.delayed(const Duration(milliseconds: 900));
      state = state.copyWith(isSubmitting: false, isSubmitted: true);
      return true;
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: 'Submission failed. Please try again.',
      );
      return false;
    }
  }
}
