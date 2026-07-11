import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/values/app_text_style.dart';
class OrderStatusCard extends ConsumerStatefulWidget {
  final String title;
  final int count;
  final Color accentColor;
  final IconData icons;
  final VoidCallback onTap;

  const OrderStatusCard({
    super.key,
    required this.title,
    required this.count,
    required this.accentColor,
    required this.icons,
    required this.onTap,
  });

  @override
  ConsumerState<OrderStatusCard> createState() => _OrderStatusCardState();
}

class _OrderStatusCardState extends ConsumerState<OrderStatusCard>
    with SingleTickerProviderStateMixin {

  bool _isPressed = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.97,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        _controller.forward();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
        _controller.reverse();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          decoration: BoxDecoration(
            // Glassmorphism effect - transparent with blur
            color: isDark
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.black.withValues(alpha: 0.02),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.black.withValues(alpha: 0.08),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.3)
                    : Colors.black.withValues(alpha: 0.04),
                blurRadius: _isPressed ? 8 : 12,
                offset: _isPressed ? const Offset(0, 2) : const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(20),
              splashColor: widget.accentColor.withValues(alpha: 0.1),
              highlightColor: widget.accentColor.withValues(alpha: 0.05),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon with accent color
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: widget.accentColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: widget.accentColor.withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        widget.icons,
                        color: widget.accentColor,
                        size: 24,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      widget.title,
                      style: customTextStyle(
                        color: isDark ? Colors.white : Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'View',
                          style: customTextStyle(
                            color: widget.accentColor,
                            // color: isDark ? Colors.grey : Colors.black87,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        width(4),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: widget.accentColor,
                          size: 14,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
