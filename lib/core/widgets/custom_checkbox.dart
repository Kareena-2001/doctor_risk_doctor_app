import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final Color? activeColor;
  final Color? checkColor;

  const CustomCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.activeColor,
    this.checkColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged?.call(!value),
      child: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          border: Border.all(
            color: value
                ? (activeColor ?? const Color(0xFF345FB4))
                : Colors.grey[400]!,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(3),
          color: value
              ? (activeColor ?? const Color(0xFF345FB4))
              : Colors.transparent,
        ),
        child: value
            ? Icon(
          Icons.check,
          size: 14,
          color: checkColor ?? Colors.white,
        )
            : null,
      ),
    );
  }
}
