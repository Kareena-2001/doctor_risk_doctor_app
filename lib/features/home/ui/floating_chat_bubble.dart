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
  Offset? _bubblePosition;

  static const double _bubbleSize = 58;

  Offset _defaultPosition(Size screenSize) {
    return Offset(
      screenSize.width - _bubbleSize - Responsive.w(16),
      screenSize.height - _bubbleSize - Responsive.h(110),
    );
  }

  void _clampToScreen(Size screenSize) {
    if (_bubblePosition == null) return;
    final dx = _bubblePosition!.dx.clamp(0.0, screenSize.width - _bubbleSize);
    final dy = _bubblePosition!.dy.clamp(0.0, screenSize.height - _bubbleSize);
    _bubblePosition = Offset(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    _bubblePosition ??= _defaultPosition(screenSize);
    _clampToScreen(screenSize);

    if (_isOpen) {
      return Positioned(
        right: Responsive.w(16),
        bottom: Responsive.h(100),
        child: ChatPanel(onClose: () => setState(() => _isOpen = false)),
      );
    }

    return Positioned(
      left: _bubblePosition!.dx,
      top: _bubblePosition!.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _bubblePosition = _bubblePosition! + details.delta;
          });
        },
        onPanEnd: (_) => setState(() {}),
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
