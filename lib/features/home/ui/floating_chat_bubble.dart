import 'package:flutter/material.dart';

import '../../../../core/constants/responsive.dart';
import '../../../../theme/app_colors.dart';
import 'chat_panel.dart';

class FloatingChatBubble extends StatefulWidget {
  const FloatingChatBubble({super.key});

  @override
  State<FloatingChatBubble> createState() => _FloatingChatBubbleState();
}

class _FloatingChatBubbleState extends State<FloatingChatBubble> {
  bool _isOpen = false;

  static const double _bubbleSize = 58;

  @override
  Widget build(BuildContext context) {
    if (_isOpen) {
      return Positioned(
        right: Responsive.w(16),
        bottom: Responsive.h(100),
        child: ChatPanel(onClose: () => setState(() => _isOpen = false)),
      );
    }

    return Positioned(
      right: Responsive.w(16),
      bottom: Responsive.h(110),
      child: GestureDetector(
        onTap: () => setState(() => _isOpen = true),
        child: Container(
          width: Responsive.w(_bubbleSize),
          height: Responsive.w(_bubbleSize),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [AppColors.newPri, AppColors.primary],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.newPri.withValues(alpha: 0.4),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Icon(
            Icons.chat_bubble_outline_rounded,
            color: Colors.white,
            size: Responsive.sp(26),
          ),
        ),
      ),
    );
  }
}
