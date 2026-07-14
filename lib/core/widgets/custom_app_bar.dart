import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../constants/dimensions.dart';
import '../constants/responsive.dart';
import '../constants/values/app_text_style.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final String? subTitle;
  final Color? backgroundColor;
  final Gradient? gradient;
  final bool showBack;
  final bool showAdd;
  final bool showRefresh;
  final VoidCallback? onRefresh;
  final bool showFilter;
  final VoidCallback? onFilter;
  final VoidCallback? onBack;
  final VoidCallback? onAdd;
  final bool showSearch;
  final bool showCalendar;
  final bool showMenu;
  final bool showDrawer;
  final bool showView;
  final bool showNotification;
  final VoidCallback? onNotification;
  final VoidCallback? onSearch;
  final VoidCallback? onCalendar;
  final VoidCallback? onMenu;
  final VoidCallback? onDrawer;
  final VoidCallback? onView;
  final bool showEdit;
  final VoidCallback? onEdit;

  const CustomAppBar({
    super.key,
    required this.title,
    this.subTitle,
    this.backgroundColor,
    this.gradient,
    this.showBack = true,
    this.showAdd = true,
    this.showRefresh = false,
    this.onRefresh,
    this.showFilter = false,
    this.onFilter,
    this.onBack,
    this.onAdd,
    this.showSearch = true,
    this.showCalendar = true,
    this.showMenu = true,
    this.showDrawer = true,
    this.showView = true,
    this.showNotification = false,
    this.onNotification,
    this.onSearch,
    this.onCalendar,
    this.onMenu,
    this.onDrawer,
    this.onView,
    this.showEdit = false,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Responsive.init(context);
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor ?? AppColors.surfaceBackground(ref),
      elevation: 0,
      centerTitle: true,
      flexibleSpace: gradient != null
          ? Container(decoration: BoxDecoration(gradient: gradient))
          : null,
      leading: showBack
          ? AppBarAction(
              icon: Icons.arrow_back,
              onTap: onBack ?? () => context.pop(),
            )
          : showDrawer && onDrawer != null
          ? AppBarAction(icon: Icons.menu_rounded, onTap: onDrawer!)
          : null,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: customTextStyle(
              color: AppColors.newPri,
              fontSize: Responsive.sp(16),
              fontWeight: FontWeight.w700,
            ),
          ),
          if (subTitle != null) ...[
            height(2),
            Text(subTitle!, style: AppTheme.label12),
          ],
        ],
      ),
      actions: [
        if (showEdit && onEdit != null)
          AppBarAction(icon: Icons.edit_outlined, onTap: onEdit!),
        if (showSearch && onSearch != null)
          AppBarAction(icon: Icons.search, onTap: onSearch!),
        if (showAdd && onAdd != null)
          AppBarAction(icon: Icons.add, onTap: onAdd!),

        if (showCalendar && onCalendar != null)
          AppBarAction(icon: Icons.calendar_today, onTap: onCalendar!),
        if (showFilter && onFilter != null)
          AppBarAction(icon: Icons.filter_list, onTap: onFilter!),
        if (showRefresh && onRefresh != null)
          AppBarAction(icon: Icons.refresh, onTap: onRefresh!),
        if (showView && onView != null)
          AppBarAction(icon: Icons.view_headline_outlined, onTap: onView!),
        if (showMenu && onMenu != null)
          AppBarAction(icon: Icons.more_vert, onTap: onMenu!),
        if (showNotification && onNotification != null)
          AppBarAction(icon: Icons.notifications_none, onTap: onNotification!),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AppBarAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const AppBarAction({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: IconButton.outlined(
        onPressed: onTap,
        icon: Icon(icon, size: Responsive.sp(22), color: AppColors.iconPink),
        style: IconButton.styleFrom(
          shape: const CircleBorder(),
          side: const BorderSide(color: AppColors.borderGrey),
          padding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
