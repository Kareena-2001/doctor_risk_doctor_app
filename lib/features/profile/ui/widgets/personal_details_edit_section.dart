import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/widgets/custom_dropdown_field.dart';
import 'package:Doctors_App/core/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../profile_screen.dart';

class PersonalDetailsEditSection extends StatelessWidget {
  const PersonalDetailsEditSection({
    super.key,
    required this.prefixCtrl,
    required this.firstNameCtrl,
    required this.middleNameCtrl,
    required this.lastNameCtrl,
    required this.emailCtrl,
    required this.mobileCtrl,
    required this.alternateMobileCtrl,
    required this.dobCtrl,
    required this.genderCtrl,
    required this.organisationCtrl,
    required this.genders,
    required this.onPickDob,
  });

  final TextEditingController prefixCtrl;
  final TextEditingController firstNameCtrl;
  final TextEditingController middleNameCtrl;
  final TextEditingController lastNameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController mobileCtrl;
  final TextEditingController alternateMobileCtrl;
  final TextEditingController dobCtrl;
  final TextEditingController genderCtrl;
  final TextEditingController organisationCtrl;
  final List<String> genders;
  final VoidCallback onPickDob;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: CustomDropdownField(
                isRequired: false,
                label: 'PREFIX',
                controller: prefixCtrl,
                value: prefixCtrl.text.isEmpty ? null : prefixCtrl.text,
                items: const ['Dr.', 'Mr.', 'Ms.', 'Mrs.'],
              ),
            ),
            width(10),
            Expanded(
              flex: 3,
              child: CustomTextField(
                label: 'FIRST NAME',
                controller: firstNameCtrl,
                isRequired: false,
              ),
            ),
          ],
        ),
        height(12),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                isRequired: false,
                label: 'MIDDLE NAME',
                controller: middleNameCtrl,
              ),
            ),
            width(10),
            Expanded(
              child: CustomTextField(
                label: 'LAST NAME',
                controller: lastNameCtrl,
                isRequired: false,
              ),
            ),
          ],
        ),
        height(12),
        CustomTextField(
          label: 'EMAIL ADDRESS',
          controller: emailCtrl,
          isRequired: false,
        ),
        height(12),
        CustomTextField(
          label: 'MOBILE NUMBER',
          controller: mobileCtrl,
          isRequired: true,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
          validator: (v) =>
              validateMobile(v, label: 'Mobile Number', required: true),
        ),
        height(12),
        CustomTextField(
          isRequired: false,
          label: 'ALTERNATE MOBILE NUMBER',
          controller: alternateMobileCtrl,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
          validator: (v) => validateMobile(
            v,
            label: 'Alternate Mobile Number',
            required: false,
          ),
        ),
        height(12),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: onPickDob,
                child: AbsorbPointer(
                  child: CustomTextField(
                    isRequired: false,
                    label: 'DATE OF BIRTH',
                    controller: dobCtrl,
                    readOnly: true,
                  ),
                ),
              ),
            ),
            width(10),
            Expanded(
              child: CustomDropdownField(
                isRequired: false,
                label: 'GENDER',
                controller: genderCtrl,
                value: genderCtrl.text.isEmpty ? null : genderCtrl.text,
                items: genders,
              ),
            ),
          ],
        ),
        height(12),
        Opacity(
          opacity: 0.55,
          child: IgnorePointer(
            child: CustomTextField(
              isRequired: false,
              label: 'ORGANISATION / ASSOCIATION',
              controller: organisationCtrl,
            ),
          ),
        ),
      ],
    );
  }
}
