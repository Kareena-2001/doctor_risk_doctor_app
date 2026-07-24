import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/product/model/product_tier.dart';
import 'package:Doctors_App/features/product/ui/state/purchase_wizard_state.dart';
import 'package:Doctors_App/features/product/ui/view_model/purchase_wizard_controller.dart';
import 'package:Doctors_App/features/product/ui/widgets/address_step.dart';
import 'package:Doctors_App/features/product/ui/widgets/hospital_details_step.dart';
import 'package:Doctors_App/features/product/ui/widgets/personal_details_step.dart';
import 'package:Doctors_App/features/product/ui/widgets/review_step.dart';
import 'package:Doctors_App/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/values/app_text_style.dart';
import '../../../theme/app_colors.dart';
import '../model/product_model.dart';

class PurchaseWizardScreen extends ConsumerStatefulWidget {
  final Product product;
  final TierPlan tier;
  final String duration;
  final double sumAssured;
  final double premium;

  const PurchaseWizardScreen({
    super.key,
    required this.product,
    required this.tier,
    required this.duration,
    required this.sumAssured,
    required this.premium,
  });

  @override
  ConsumerState<PurchaseWizardScreen> createState() =>
      _PurchaseWizardScreenState();
}

class _PurchaseWizardScreenState extends ConsumerState<PurchaseWizardScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final WizardArgs args = (
      widget.product,
      widget.tier,
      widget.duration,
      widget.sumAssured,
      widget.premium,
    );

    final provider = purchaseWizardControllerProvider(
      widget.product,
      widget.tier,
      widget.duration,
      widget.sumAssured,
      widget.premium,
    );
    final isEstab = widget.product.type == ProductType.medicalEstablishment;
    // Animate the PageView whenever the controller's step changes
    // (e.g. after a step widget calls nextStep()/previousStep()).
    ref.listen(provider, (prev, next) {
      if (prev?.currentStepIndex != next.currentStepIndex &&
          _pageController.hasClients) {
        _pageController.animateToPage(
          next.currentStepIndex,
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeInOut,
        );
      }
      if (next.isSubmitted && prev?.isSubmitted != true) {
        _showSuccessDialog(context);
      }
    });

    final state = ref.watch(provider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: CustomAppBar(
        title: widget.product.productNames.join(' / '),
        showBack: true,
        onBack: () => _handleBack(context, state),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _WizardStepIndicator(
              currentIndex: state.currentStepIndex,
              isEstablishment: isEstab,
            ),
            if (state.errorMessage != null)
              _ErrorBanner(message: state.errorMessage!),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  PersonalDetailsStep(
                    product: widget.product,
                    tier: widget.tier,
                    duration: widget.duration,
                    sumAssured: widget.sumAssured,
                    premium: widget.premium,
                    controllerArgs: args,
                  ),
                  // if (isEstab)
                  HospitalDetailsStep(
                    product: widget.product,
                    controllerArgs: args,
                  ),
                  AddressStep(controllerArgs: args),
                  ReviewStep(controllerArgs: args),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleBack(BuildContext context, PurchaseWizardState state) {
    final notifier = ref.read(
      purchaseWizardControllerProvider(
        widget.product,
        widget.tier,
        widget.duration,
        widget.sumAssured,
        widget.premium,
      ).notifier,
    );
    if (state.currentStepIndex == 0) {
      context.pop();
    } else {
      notifier.previousStep();
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: Color(0xFF10B981),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 34,
                ),
              ),
              height(16),
              Text(
                'Updated!',
                style: customTextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              height(6),
              Text(
                'Your data has been successfully updated!',
                textAlign: TextAlign.center,
                style: customTextStyle(fontSize: 13, color: AppColors.grey),
              ),
              height(20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.pop();
                      },
                      child: Text('Go Back'),
                    ),
                  ),
                  width(12),
                  Expanded(
                    child: PrimaryButton(
                      height: 44,
                      text: 'Proceed to Payment',
                      fontSize: 13,
                      backgroundColor: AppColors.orange,
                      // padding: EdgeInsets.all(5),
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await Future.delayed(Duration.zero);
                        if (context.mounted) {
                          context.push(Routes.productList);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WizardStepIndicator extends StatelessWidget {
  final int currentIndex;
  final bool isEstablishment;

  const _WizardStepIndicator({
    required this.currentIndex,
    required this.isEstablishment,
  });

  static const _labels = ['Personal', 'Hospital', 'Address', 'Review'];

  @override
  Widget build(BuildContext context) {
    // final labels = isEstablishment
    //     ? ['Personal', 'Hospital', 'Address', 'Review']
    //     : ['Personal', 'Address', 'Review'];
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
      child: Row(
        children: List.generate(_labels.length, (i) {
          final isDone = i < currentIndex;
          final isActive = i == currentIndex;
          final color = isDone || isActive
              ? AppColors.newPri
              : const Color(0xFFE2E8F0);

          return Expanded(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: color,
                  child: isDone
                      ? Icon(Icons.check, size: 14, color: Colors.white)
                      : Text(
                          '${i + 1}',
                          style: customTextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: isActive
                                ? Colors.white
                                : const Color(0xFF94A3B8),
                          ),
                        ),
                ),
                if (i != _labels.length - 1)
                  Expanded(
                    child: Container(
                      height: 2,
                      color: isDone
                          ? AppColors.orange
                          : const Color(0xFFE2E8F0),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  final String message;

  const _ErrorBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFFEE2E2),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Text(
        message,
        style: customTextStyle(fontSize: 12, color: AppColors.cardRed),
      ),
    );
  }
}
