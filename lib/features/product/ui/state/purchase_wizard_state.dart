import 'package:Doctors_App/features/product/model/product_tier.dart';

import '../../model/product_model.dart';
import '../../model/purchase_model.dart';

/// Positional args used to look up the family provider instance:
/// (product, tier, duration, sumAssured, premium)
typedef WizardArgs = (Product, TierPlan, String, double, double);

enum WizardStep { personal, hospital, address, review }

const wizardStepOrder = [
  WizardStep.personal,
  WizardStep.hospital,
  WizardStep.address,
  WizardStep.review,
];

class PurchaseWizardState {
  final Product product;
  final TierPlan tier;
  final String duration;
  final double sumAssured;
  final double premium;

  final WizardStep currentStep;
  final PersonalDetails? personalDetails;
  final HospitalDetails? hospitalDetails;
  final List<WizardAddress> addresses;

  final bool isSubmitting;
  final bool isSubmitted;
  final String? errorMessage;

  const PurchaseWizardState({
    required this.product,
    required this.tier,
    required this.duration,
    required this.sumAssured,
    required this.premium,
    this.currentStep = WizardStep.personal,
    this.personalDetails,
    this.hospitalDetails,
    this.addresses = const [],
    this.isSubmitting = false,
    this.isSubmitted = false,
    this.errorMessage,
  });

  int get currentStepIndex => wizardStepOrder.indexOf(currentStep);

  bool get canSubmit =>
      personalDetails != null &&
      hospitalDetails != null &&
      addresses.isNotEmpty;

  PurchaseWizardState copyWith({
    WizardStep? currentStep,
    PersonalDetails? personalDetails,
    HospitalDetails? hospitalDetails,
    List<WizardAddress>? addresses,
    bool? isSubmitting,
    bool? isSubmitted,
    String? errorMessage,
  }) {
    return PurchaseWizardState(
      product: product,
      tier: tier,
      duration: duration,
      sumAssured: sumAssured,
      premium: premium,
      currentStep: currentStep ?? this.currentStep,
      personalDetails: personalDetails ?? this.personalDetails,
      hospitalDetails: hospitalDetails ?? this.hospitalDetails,
      addresses: addresses ?? this.addresses,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      errorMessage: errorMessage,
    );
  }
}
