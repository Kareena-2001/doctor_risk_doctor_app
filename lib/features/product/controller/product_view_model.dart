import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/product/ui/state/product_state.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/product_model.dart';
import '../model/product_tier.dart';
import '../widgets/tier_helper.dart';

part 'product_view_model.g.dart';

@Riverpod(keepAlive: true)
class ProductViewModel extends _$ProductViewModel {
  final formKey = GlobalKey<FormState>();
  final pageController = PageController();

  final selectedPolicy = TextEditingController();
  final selectedYear = TextEditingController();
  final selectedSumAssured = TextEditingController();
  final selectedPremium = TextEditingController();
  final startDateController = TextEditingController();
  final retroDateController = TextEditingController();
  final previousPolicyController = TextEditingController();
  final worldwideController = TextEditingController();
  final unqualifiedStaffController = TextEditingController();
  final couponController = TextEditingController();

  final policyOptions = const [
    ' Error And Ommission',
    'Policy and Services',
    'Complete Medico Legal Support',
  ];
  final yearOptions = const ['1', '2', '3'];
  final sumAssuredOptions = const ['₹1 Crore', '₹2 Crore', '₹5 Crore'];

  final List<Product> sampleProducts = [
    Product(
      id: 3,
      type: ProductType.individual,
      productNames: ['Basic Medico Legal Services'],
      shortDescription: 'Entry level legal medical services at low cost',
      fullDescription:
          'Basic Medico Legal Services provides affordable entry-level legal and medical advisory for individuals. Ideal for those seeking essential coverage without breaking the bank. Includes basic legal consultation and document assistance.',
      createdDate: DateTime(2025, 6, 20),
      tiers: [
        TierPlan(
          name: 'Basic',
          tagline: 'Essential entry-level individual coverage',
          premiumPerYear: 999,
          sumInsured: 100000,
          maxMembers: 1,
          validityYears: 1,
          style: TierStyles.basic,
          features: [
            const TierFeatureItem('Legal consultation'),
            const TierFeatureItem('Document assistance'),
            const TierFeatureItem('Medical report review', included: false),
            const TierFeatureItem('Court representation', included: false),
            const TierFeatureItem('Expert witness', included: false),
          ],
        ),
      ],
    ),
    Product(
      id: 2,
      type: ProductType.medicalEstablishment,
      productNames: ['Medico Legal Service'],
      shortDescription: 'Comprehensive medico-legal cover for hospitals',
      fullDescription:
          'Designed for hospitals and clinics, this plan offers comprehensive medico-legal risk coverage. Protects medical establishments from legal liabilities, supports compliance, and provides expert witness services for complex cases.',
      createdDate: DateTime(2025, 6, 15),
      tiers: [
        TierPlan(
          name: 'Platinum',
          tagline: 'Full enterprise-grade medico-legal protection',
          premiumPerYear: 25000,
          sumInsured: 2000000,
          maxMembers: 50,
          validityYears: 1,
          style: TierStyles.platinum,
          isBestValue: true,
          features: [
            const TierFeatureItem('Full legal coverage'),
            const TierFeatureItem('Expert witness'),
            const TierFeatureItem('Court representation'),
            const TierFeatureItem('Compliance audit'),
            const TierFeatureItem('Dedicated case manager'),
          ],
        ),
        TierPlan(
          name: 'Standard',
          tagline: 'Standard coverage for small clinics',
          premiumPerYear: 8000,
          sumInsured: 500000,
          maxMembers: 10,
          validityYears: 1,
          style: TierStyles.standard,
          features: [
            const TierFeatureItem('Legal consultation'),
            const TierFeatureItem('Document assistance'),
            const TierFeatureItem('Medical report review'),
            const TierFeatureItem('Court representation', included: false),
            const TierFeatureItem('Dedicated case manager', included: false),
          ],
        ),
      ],
    ),
    Product(
      id: 1,
      type: ProductType.individual,
      productNames: ['Comprehensive Medico Legal', 'Basic Medico Legal'],
      shortDescription:
          'Covers full legal and medical advisory for individuals',
      fullDescription:
          'Our flagship individual plan offering complete peace of mind. From legal consultation to courtroom representation, this plan ensures you\'re never alone in a medico-legal dispute. Multiple tiers let you choose the exact level of coverage you need.',
      createdDate: DateTime(2025, 6, 1),
      tiers: [
        TierPlan(
          name: 'Gold',
          tagline: 'Full coverage with court & expert support',
          premiumPerYear: 5000,
          sumInsured: 1000000,
          maxMembers: 5,
          validityYears: 1,
          style: TierStyles.gold,
          isBestValue: true,
          features: [
            const TierFeatureItem('Legal consultation'),
            const TierFeatureItem('Document assistance'),
            const TierFeatureItem('Medical report review'),
            const TierFeatureItem('Court representation'),
            const TierFeatureItem('Expert witness'),
          ],
        ),
        TierPlan(
          name: 'Silver',
          tagline: 'Standard coverage with consultation support',
          premiumPerYear: 3000,
          sumInsured: 500000,
          maxMembers: 3,
          validityYears: 1,
          style: TierStyles.silver,
          features: [
            const TierFeatureItem('Legal consultation'),
            const TierFeatureItem('Document assistance'),
            const TierFeatureItem('Medical report review'),
            const TierFeatureItem('Court representation', included: false),
            const TierFeatureItem('Expert witness', included: false),
          ],
        ),
        TierPlan(
          name: 'Bronze',
          tagline: 'Essential entry-level coverage',
          premiumPerYear: 1500,
          sumInsured: 200000,
          maxMembers: 2,
          validityYears: 1,
          style: TierStyles.bronze,
          features: [
            const TierFeatureItem('Legal consultation'),
            const TierFeatureItem('Document assistance'),
            const TierFeatureItem('Medical report review', included: false),
            const TierFeatureItem('Court representation', included: false),
            const TierFeatureItem('Expert witness', included: false),
          ],
        ),
      ],
    ),
  ];

  // ── Rebuild-driving state ──
  @override
  ProductState build() {
    ref.onDispose(() {
      pageController.dispose();
      selectedPolicy.dispose();
      selectedYear.dispose();
      selectedSumAssured.dispose();
      selectedPremium.dispose();
      startDateController.dispose();
      retroDateController.dispose();
      previousPolicyController.dispose();
      worldwideController.dispose();
      unqualifiedStaffController.dispose();
      couponController.dispose();
    });
    calculatePremium();
    return const ProductState();
  }

  void calculatePremium() {
    final sum = selectedSumAssured.text;
    List<String> options = state.premiumOptions;
    double original = state.originalPremium;

    if (sum == '₹1 Crore') {
      options = ['₹45,000', '₹52,000', '₹60,000'];
      original = 45000;
    } else if (sum == '₹2 Crore') {
      options = ['₹80,000', '₹95,000', '₹1,10,000'];
      original = 80000;
    } else if (sum == '₹5 Crore') {
      options = ['₹1,80,000', '₹2,10,000', '₹2,40,000'];
      original = 180000;
    }

    state = state.copyWith(
      premiumOptions: options,
      originalPremium: original,
      payableAmount: original,
    );
  }

  void onPremiumSelected(String? premium) {
    if (premium != null) {
      final value = double.parse(
        premium.replaceAll('₹', '').replaceAll(',', ''),
      );
      state = state.copyWith(originalPremium: value);
      applyDiscount();
    }
  }

  void onPolicyChanged(String? policy) {}

  String get buttonText {
    if (state.currentStep == 0) return "Continue";
    if (state.currentStep == 1) return "Verify OTP";
    return "Submit";
  }

  void nextStep() {
    if (state.currentStep == 1) {
      if (selectedPremium.text.isEmpty || state.originalPremium == 0) {
        // SnackbarHelper.showError("Please select a premium amount");
        return;
      }
    }
    if (state.currentStep < 2) {
      state = state.copyWith(currentStep: state.currentStep + 1);
    }
  }

  void previousStep() {
    if (state.currentStep > 1) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  Future<void> applyCoupon() async {
    final code = couponController.text.trim().toUpperCase();
    if (code.isEmpty) {
      state = state.copyWith(
        couponMessage: "Please enter a coupon code",
        couponSuccess: false,
      );
      return;
    }

    state = state.copyWith(isApplyingCoupon: true);
    await Future.delayed(const Duration(seconds: 1));

    double discount;
    String message;
    bool success;

    if (code == "DOCTOR50") {
      discount = state.originalPremium * 0.50;
      message = "50% Discount Applied Successfully!";
      success = true;
    } else if (code == "SAVE20") {
      discount = state.originalPremium * 0.20;
      message = "20% Discount Applied!";
      success = true;
    } else {
      discount = 0;
      message = "Invalid or expired coupon code";
      success = false;
    }

    state = state.copyWith(
      discountAmount: discount,
      couponMessage: message,
      couponSuccess: success,
      isApplyingCoupon: false,
    );
    applyDiscount();
  }

  void applyDiscount() {
    state = state.copyWith(
      payableAmount: state.originalPremium - state.discountAmount,
    );
  }

  Future<void> selectDate(
    BuildContext context, {
    required bool isStartDate,
  }) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      final formatted = "${picked.day}/${picked.month}/${picked.year}";
      if (isStartDate) {
        startDateController.text = formatted;
      } else {
        retroDateController.text = formatted;
      }
    }
  }

  void pickPreviousPolicy() {
    previousPolicyController.text = "previous_policy_2024.pdf";
    // SnackbarHelper.showSuccess("File selected");
  }

  Future<void> submitPolicy(BuildContext context) async {
    if (state.payableAmount <= 0) {
      context.showErrorSnackBar("Invalid amount");
      return;
    }

    await Future.delayed(const Duration(seconds: 2));

    Navigator.of(context).pop();
    // SnackbarHelper.showSuccess(
    //   "Policy added successfully! Payable: ₹${state.payableAmount}",
    // );
  }
}
