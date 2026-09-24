import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/common/ui/widgets/loading.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/product/ui/state/purchase_wizard_state.dart';
import 'package:Doctors_App/features/profile/model/doctor_profile_response.dart';
import 'package:Doctors_App/features/profile/ui/widgets/profile_address_form_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/values/app_text_style.dart';
import '../../../../theme/app_colors.dart';
import '../view_model/purchase_wizard_controller.dart';

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
        Expanded(child: _buildBody(context, state, notifier)),
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

  Widget _buildBody(
    BuildContext context,
    PurchaseWizardState state,
    PurchaseWizardController notifier,
  ) {
    if (state.isLoadingAddresses) {
      return const Center(child: Loading());
    }
    if (state.addresses.isEmpty) {
      return Center(
        child: Text(
          'No addresses added yet',
          style: customTextStyle(fontSize: 13, color: AppColors.grey),
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: state.addresses.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) {
        final a = state.addresses[i];
        return _AddressCard(
          address: a,
          onEdit: () => _openAddressSheet(context, notifier, existing: a),
          onDelete: () => _deleteAddress(context, notifier, a),
        );
      },
    );
  }

  Future<void> _openAddressSheet(
    BuildContext context,
    PurchaseWizardController notifier, {
    DoctorAddress? existing,
  }) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ProfileAddressFormSheet(
        existing: existing,
        onSave:
            ({
              required addressType,
              required ownVisiting,
              required address1,
              required address2,
              required landmark,
              required area,
              required stateId,
              required cityId,
              required pincode,
            }) async {
              try {
                await notifier.addOrEditAddress(
                  id: existing?.id,
                  addressType: addressType,
                  ownVisiting: ownVisiting,
                  address1: address1,
                  address2: address2,
                  landmark: landmark,
                  area: area,
                  stateName: stateId,
                  city: cityId,
                  pincode: pincode,
                );

                if (!context.mounted) return;
                context.showSuccessSnackBar(
                  existing == null
                      ? 'Address added successfully.'
                      : 'Address updated successfully.',
                );
              } catch (e) {
                if (!context.mounted) return;
                context.showErrorSnackBar(
                  e.toString().replaceFirst('Exception: ', ''),
                );
                rethrow;
              }
            },
      ),
    );
  }

  Future<void> _deleteAddress(
    BuildContext context,
    PurchaseWizardController notifier,
    DoctorAddress address,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete address'),
        content: const Text('Are you sure you want to delete this address?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    try {
      await notifier.deleteAddress(address.id);
      if (!context.mounted) return;
      context.showSuccessSnackBar('Address deleted successfully.');
    } catch (e) {
      if (!context.mounted) return;
      context.showErrorSnackBar(e.toString().replaceFirst('Exception: ', ''));
    }
  }
}

class _AddressCard extends StatelessWidget {
  final DoctorAddress address;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _AddressCard({
    required this.address,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final line1 = [
      address.address1,
      address.address2,
    ].where((e) => e != null && e.trim().isNotEmpty).join(', ');
    final line2 = [
      if (address.landmark != null && address.landmark!.trim().isNotEmpty)
        address.landmark,
      address.city,
      address.state,
    ].where((e) => e != null && e.toString().trim().isNotEmpty).join(', ');
    final pin = address.pincode?.trim() ?? '';

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
              address.addressType ?? 'Address',
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
                  line1.isEmpty ? '-' : line1,
                  style: customTextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                height(2),
                Text(
                  pin.isEmpty ? line2 : '$line2 - $pin',
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
