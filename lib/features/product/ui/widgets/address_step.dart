import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/widgets/custom_dropdown_field.dart';
import 'package:Doctors_App/core/widgets/custom_text_field.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/product/ui/state/purchase_wizard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/values/app_text_style.dart';
import '../../../../theme/app_colors.dart';
import '../../model/purchase_model.dart';
import '../view_model/purchase_wizard_controller.dart';
import 'address_form_sheet.dart';

class AddressStep extends ConsumerWidget {
  final WizardArgs controllerArgs;

  const AddressStep({super.key, required this.controllerArgs});

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

    return Column(
      children: [
        Expanded(
          child: state.addresses.isEmpty
              ? Center(
                  child: Text(
                    'No addresses added yet',
                    style: customTextStyle(fontSize: 13, color: AppColors.grey),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.addresses.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (_, i) {
                    final a = state.addresses[i];
                    return _AddressCard(
                      address: a,
                      onEdit: () =>
                          _openAddressSheet(context, notifier, existing: a),
                      onDelete: () => notifier.removeAddress(a.id),
                    );
                  },
                ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            children: [
              OutlinedButton.icon(
                onPressed: () => _openAddressSheet(context, notifier),
                icon: const Icon(Icons.add_rounded, size: 18),
                label: const Text('Add more address'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 44),
                  foregroundColor: AppColors.newPri,
                  side: BorderSide(color: AppColors.newPri),
                ),
              ),
              height(10),
              PrimaryButton(
                height: 44,
                text: 'Continue',
                backgroundColor: AppColors.newPri,
                onPressed: state.addresses.isEmpty
                    ? null
                    : () => notifier.nextStep(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _openAddressSheet(
    BuildContext context,
    PurchaseWizardController notifier, {
    WizardAddress? existing,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddressFormSheet(
        existing: existing,
        onSave: (address) {
          if (existing == null) {
            notifier.addAddress(address);
          } else {
            notifier.updateAddress(address);
          }
        },
      ),
    );
  }
}

class _AddressCard extends StatelessWidget {
  final WizardAddress address;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _AddressCard({
    required this.address,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.orange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              address.type.label,
              style: customTextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: AppColors.orange,
              ),
            ),
          ),
          width(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${address.address1}, ${address.address2}',
                  style: customTextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                height(2),
                Text(
                  '${address.landmark}, ${address.city}, ${address.state} - ${address.pinCode}',
                  style: customTextStyle(fontSize: 11, color: AppColors.grey),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined, size: 18),
            onPressed: onEdit,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, size: 18, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}

