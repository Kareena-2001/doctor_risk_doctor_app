import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../constants/values/app_text_style.dart';
import '../constants/dimensions.dart';

class CustomRadioGroup<T> extends FormField<T> {
  CustomRadioGroup({
    super.key,
    required String label,
    required List<T> options,
    List<String>? optionLabels,
    super.initialValue,
    required ValueChanged<T?> onChanged,
    bool isRequired = true,
    String? Function(T?)? validator,
    final T? selectedValue,
  }) : super(
         validator: (value) {
           if (!isRequired) return null;
           if (value == null) return '$label is required';
           return null;
         },
         builder: (FormFieldState<T> state) {
           final hasError = state.hasError;

           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(
                 label,
                 style: AppTheme.label12.copyWith(color: AppColors.labelColor,fontWeight: FontWeight.w700),
               ),
               height(8),
               Wrap(
                 spacing: 12,
                 runSpacing: 10,
                 children: List.generate(options.length, (index) {
                   final value = options[index];
                   final title = optionLabels != null
                       ? optionLabels[index]
                       : value.toString();

                   final isSelected = state.value == value;

                   return InkWell(
                     onTap: () {
                       state.didChange(value);
                       onChanged(value);
                     },
                     child: Container(
                       padding: const EdgeInsets.only(
                         top: 6,
                         bottom: 6,
                         left: 16,
                         right: 18,
                       ),
                       decoration: BoxDecoration(
                         border: Border.all(
                           color: isSelected
                               ? AppColors.newPri
                               : AppColors.mono60,
                         ),
                         borderRadius: BorderRadius.circular(10),
                       ),
                       child: Row(
                         mainAxisSize: MainAxisSize.min,
                         children: [
                           Radio<T>(
                             value: value,
                             groupValue: state.value,
                             activeColor: AppColors.newPri,
                             materialTapTargetSize:
                                 MaterialTapTargetSize.shrinkWrap,
                             visualDensity: VisualDensity.compact,
                             onChanged: (val) {
                               state.didChange(val);
                               onChanged(val);
                             },
                           ),
                           Text(
                             title,
                             style: customTextStyle(
                               fontSize: 12,
                               fontWeight: FontWeight.w700,
                               color: AppColors.textHint,
                             ),
                           ),
                         ],
                       ),
                     ),
                   );
                 }),
               ),
               if (hasError) ...[
                 height(6),
                 Text(
                   state.errorText!,
                   style: customTextStyle(
                     color: Colors.red,
                     fontSize: 12,
                     fontWeight: FontWeight.w400,
                   ),
                 ),
               ],
             ],
           );
         },
       );
}
