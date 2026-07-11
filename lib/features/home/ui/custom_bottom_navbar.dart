import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NavBarItemData {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const NavBarItemData({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<NavBarItemData> items;
  final Color? backgroundColor;
  final EdgeInsetsGeometry margin;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.backgroundColor,
    this.margin = const EdgeInsets.fromLTRB(16, 0, 16, 16),
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final barColor =
        backgroundColor ?? (isDark ? const Color(0xFF1C1C1E) : Colors.white);

    return SafeArea(
      top: false,
      child: Padding(
        padding: margin,
        child: Container(
          height: 68,
          decoration: BoxDecoration(
            color: barColor,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.10),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth = constraints.maxWidth / items.length;

              return Stack(
                alignment: Alignment.centerLeft,
                children: [
                  // Sliding pill indicator behind the active icon.
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 320),
                    curve: Curves.easeOutCubic,
                    left: itemWidth * currentIndex + (itemWidth - 52) / 2,
                    top: 8,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 320),
                      curve: Curves.easeOutCubic,
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppColors.newPri.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(items.length, (index) {
                      final item = items[index];
                      final selected = index == currentIndex;

                      return Expanded(
                        child: InkWell(
                          onTap: () {
                            if (!selected) {
                              HapticFeedback.selectionClick();
                              onTap(index);
                            }
                          },
                          customBorder: const CircleBorder(),
                          child: SizedBox(
                            height: 68,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedScale(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeOutBack,
                                  scale: selected ? 1.08 : 1.0,
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 200),
                                    transitionBuilder: (child, anim) =>
                                        FadeTransition(
                                          opacity: anim,
                                          child: ScaleTransition(
                                            scale: anim,
                                            child: child,
                                          ),
                                        ),
                                    child: Icon(
                                      selected ? item.activeIcon : item.icon,
                                      key: ValueKey(selected),
                                      size: 24,
                                      color: selected
                                          ? AppColors.newPri
                                          : (isDark
                                                ? AppColors.mono40
                                                : AppColors.mono60),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 200),
                                  style: customTextStyle(
                                    fontSize: 10,
                                    fontWeight: selected
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                    color: selected
                                        ? AppColors.newPri
                                        : (isDark
                                              ? AppColors.mono40
                                              : AppColors.mono60),
                                  ),
                                  child: Text(item.label),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
