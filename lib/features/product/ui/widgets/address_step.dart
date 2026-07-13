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
      builder: (_) => _AddressFormSheet(
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

class _AddressFormSheet extends StatefulWidget {
  final WizardAddress? existing;
  final ValueChanged<WizardAddress> onSave;

  const _AddressFormSheet({required this.existing, required this.onSave});

  @override
  State<_AddressFormSheet> createState() => _AddressFormSheetState();
}

class _AddressFormSheetState extends State<_AddressFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final _address1Ctrl = TextEditingController(
    text: widget.existing?.address1,
  );
  late final _address2Ctrl = TextEditingController(
    text: widget.existing?.address2,
  );
  late final _landmarkCtrl = TextEditingController(
    text: widget.existing?.landmark,
  );
  late final _pinCodeCtrl = TextEditingController(
    text: widget.existing?.pinCode,
  );
  late final _cityCtrl = TextEditingController(text: widget.existing?.city);
  late final _stateCtrl = TextEditingController(text: widget.existing?.state);

  AddressType _type = AddressType.clinic;
  OwnOrVisiting _ownOrVisiting = OwnOrVisiting.own;

  @override
  void initState() {
    super.initState();
    _type = widget.existing?.type ?? AddressType.clinic;
    _ownOrVisiting = widget.existing?.ownOrVisiting ?? OwnOrVisiting.own;
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    widget.onSave(
      WizardAddress(
        id: widget.existing?.id ?? const Uuid().v4(),
        type: _type,
        ownOrVisiting: _ownOrVisiting,
        address1: _address1Ctrl.text.trim(),
        address2: _address2Ctrl.text.trim(),
        landmark: _landmarkCtrl.text.trim(),
        pinCode: _pinCodeCtrl.text.trim(),
        city: _cityCtrl.text.trim(),
        state: _stateCtrl.text.trim(),
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                height(16),
                Text(
                  widget.existing == null ? 'Add address' : 'Edit address',
                  style: customTextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                height(16),
                Row(
                  children: [
                    Expanded(
                      child: CustomDropdownField<AddressType>(
                        label: 'Address type',
                        items: AddressType.values,
                        value: _type,
                        itemBuilder: (t) => t.label,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _type = value);
                          }
                        },
                      ),
                    ),
                    width(10),

                    Expanded(
                      child: CustomDropdownField<OwnOrVisiting>(
                        label:  'Own/visiting',
                        items: OwnOrVisiting.values,
                        value: _ownOrVisiting,
                        itemBuilder: (t) => t.label,
                        onChanged: (v) => setState(
                              () => _ownOrVisiting = v ?? _ownOrVisiting,
                        ),
                      ),
                    ),
                  ],
                ),
                height(10),
                CustomTextField(
                  label: 'Address 1',
                  controller: _address1Ctrl,
                  isRequired: true,
                ),
                height(10),
                CustomTextField(label: 'Address 2', controller: _address2Ctrl),
                height(10),
                CustomTextField(
                  label: 'Landmark/locality/area',
                  controller: _landmarkCtrl,
                ),
                height(10),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: 'Pin code',
                        controller: _pinCodeCtrl,
                        isRequired: true,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    width(10),
                    Expanded(
                      child: CustomTextField(
                        label: 'City',
                        controller: _cityCtrl,
                        isRequired: true,
                      ),
                    ),
                  ],
                ),
                height(10),
                CustomTextField(
                  label: 'State',
                  controller: _stateCtrl,
                  isRequired: true,
                ),
                height(20),
                PrimaryButton(
                  height: 50,
                  text: 'Save your address',
                  backgroundColor: AppColors.newPri,
                  onPressed: _save,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
