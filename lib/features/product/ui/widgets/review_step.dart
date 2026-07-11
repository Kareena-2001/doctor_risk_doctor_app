import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/values/app_text_style.dart';
import '../../../../theme/app_colors.dart';
import '../../model/purchase_model.dart';
import '../state/purchase_wizard_state.dart';
import '../view_model/purchase_wizard_controller.dart';

class ReviewStep extends ConsumerWidget {
  final WizardArgs controllerArgs;
  const ReviewStep({super.key, required this.controllerArgs});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = purchaseWizardControllerProvider(
      controllerArgs.$1,
      controllerArgs.$2,
      controllerArgs.$3,
      controllerArgs.$4,
      controllerArgs.$5,
    );
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);
    final personal = state.personalDetails;
    final hospital = state.hospitalDetails;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionCard(
                  title: 'Plan',
                  rows: {
                    'Product': state.product.productNames.join(' / '),
                    'Tier': state.tier.name,
                    'Duration': state.duration,
                    'Sum assured': '₹${state.sumAssured.toStringAsFixed(0)}',
                    'Premium': '₹${state.premium.toStringAsFixed(0)}',
                  },
                ),
                height(14),
                if (personal != null)
                  _SectionCard(
                    title: 'Personal details',
                    rows: {
                      'Name': personal.fullName,
                      'Degree': personal.degree,
                      'Email': personal.emailId,
                      'Mobile': personal.mobileNumber,
                      'Gender': personal.gender.label,
                    },
                  ),
                height(14),
                if (hospital != null)
                  _SectionCard(
                    title: 'Hospital/clinic details',
                    rows: {
                      'Reg. state': hospital.medicalRegState,
                      'Reg. no.': hospital.medicalRegNo,
                      'Reg. year': hospital.medicalRegYear,
                      'Worldwide': hospital.worldwide ? 'Yes' : 'No',
                      'Unqualified staff': hospital.hasUnqualifiedStaff
                          ? '${hospital.unqualifiedStaffCount}'
                          : 'No',
                    },
                  ),
                height(14),
                _SectionCard(
                  title: 'Addresses (${state.addresses.length})',
                  rows: {
                    for (final a in state.addresses)
                      a.type.label: '${a.address1}, ${a.city} - ${a.pinCode}',
                  },
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: PrimaryButton(
            height: 46,
            text: state.isSubmitting ? 'Submitting...' : 'Submit',
            backgroundColor: AppColors.orange,
            onPressed: state.isSubmitting ? null : () => notifier.submit(),
          ),
        ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Map<String, String> rows;

  const _SectionCard({required this.title, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: customTextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
          height(10),
          ...rows.entries.map(
                (e) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120,
                    child: Text(e.key, style: customTextStyle(fontSize: 11.5, color: AppColors.grey)),
                  ),
                  Expanded(
                    child: Text(
                      e.value,
                      style: customTextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}