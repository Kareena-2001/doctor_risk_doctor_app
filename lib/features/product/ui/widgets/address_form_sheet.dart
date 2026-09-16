
import 'package:Doctors_App/features/product/model/purchase_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/values/app_text_style.dart';
import '../../../../core/widgets/custom_dropdown_field.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../theme/app_colors.dart';
import '../../../common/ui/widgets/primary_button.dart';

class AddressFormSheet extends StatefulWidget {
  final WizardAddress? existing;
  final ValueChanged<WizardAddress> onSave;

  const AddressFormSheet({required this.existing, required this.onSave});

  @override
  State<AddressFormSheet> createState() => AddressFormSheetState();
}

class AddressFormSheetState extends State<AddressFormSheet> {
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

  AddressType _type = AddressType.home;
  OwnOrVisiting _ownOrVisiting = OwnOrVisiting.own;

  @override
  void initState() {
    super.initState();
    _type = widget.existing?.type ?? AddressType.home;
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
                        label: 'Own/visiting',
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
                CustomTextField(label: 'Landmark', controller: _landmarkCtrl),
                height(10),
                CustomTextField(label: 'Area', controller: _landmarkCtrl),
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