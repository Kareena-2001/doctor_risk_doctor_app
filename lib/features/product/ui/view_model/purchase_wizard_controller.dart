import 'package:Doctors_App/features/product/model/product_tier.dart';
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
    return PurchaseWizardState(
      product: product,
      tier: tier,
      duration: duration,
      sumAssured: sumAssured,
      premium: premium,
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

  void addAddress(WizardAddress address) {
    state = state.copyWith(addresses: [...state.addresses, address]);
  }

  void updateAddress(WizardAddress address) {
    final updated = state.addresses
        .map((a) => a.id == address.id ? address : a)
        .toList();
    state = state.copyWith(addresses: updated);
  }

  void removeAddress(String addressId) {
    final updated = state.addresses.where((a) => a.id != addressId).toList();
    state = state.copyWith(addresses: updated);
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
