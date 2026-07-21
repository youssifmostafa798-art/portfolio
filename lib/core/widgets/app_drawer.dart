import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../extensions/context_extensions.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../../features/home/presentation/providers/theme_provider.dart';
import '../constants/app_constants.dart';

final class NavDrawerItem {
  final String label;
  final int index;
  final IconData icon;
  const NavDrawerItem(this.label, this.index, this.icon);
}

class AppDrawer extends ConsumerWidget {
  final int activeSection;
  final Function(int) onNavTap;

  const AppDrawer({
    super.key,
    required this.activeSection,
    required this.onNavTap,
  });

  static const List<NavDrawerItem> _items = [
    NavDrawerItem('Home', 0, Icons.home_outlined),
    NavDrawerItem('About', 1, Icons.person_outline),
    NavDrawerItem('Skills', 2, Icons.code_outlined),
    NavDrawerItem('Projects', 3, Icons.folder_outlined),
    NavDrawerItem('Contact', 4, Icons.mail_outline),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = context.isDark;
    final toggleTheme = ref.read(themeToggleProvider);

    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        color: isDark
            ? AppColors.darkBackground.withValues(alpha: 0.95)
            : AppColors.lightBackground.withValues(alpha: 0.95),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppConstants.appName,
                      style: AppTypography.textTheme.headlineMedium?.copyWith(
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      AppConstants.title,
                      style: AppTypography.textTheme.bodyMedium?.copyWith(
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              Divider(
                color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
                height: 1,
              ),
              SizedBox(height: 8.h),
              ...List.generate(_items.length, (i) {
                final item = _items[i];
                final isActive = activeSection == item.index;
                return _DrawerNavItem(
                  item: item,
                  isActive: isActive,
                  onTap: () => onNavTap(item.index),
                );
              }),
              const Spacer(),
              Divider(
                color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
                height: 1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 16.h,
                ),
                child: Row(
                  children: [
                    Icon(
                      isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                      size: 20.r,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      '${isDark ? 'Dark' : 'Light'} Mode',
                      style: AppTypography.textTheme.bodyMedium?.copyWith(
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: toggleTheme,
                      child: Container(
                        width: 48.w,
                        height: 28.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.r),
                          color: isDark
                              ? AppColors.primary
                              : AppColors.textTertiaryLight,
                        ),
                        padding: EdgeInsets.all(2.r),
                        child: AnimatedAlign(
                          duration: const Duration(milliseconds: 200),
                          alignment: isDark
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            width: 24.r,
                            height: 24.r,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerNavItem extends StatefulWidget {
  final NavDrawerItem item;
  final bool isActive;
  final VoidCallback onTap;

  const _DrawerNavItem({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_DrawerNavItem> createState() => _DrawerNavItemState();
}

class _DrawerNavItemState extends State<_DrawerNavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Semantics(
        button: true,
        label: 'Navigate to ${widget.item.label}',
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: widget.isActive
                  ? (isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : Colors.black.withValues(alpha: 0.05))
                  : (_isHovered
                      ? (isDark
                          ? Colors.white.withValues(alpha: 0.04)
                          : Colors.black.withValues(alpha: 0.03))
                      : Colors.transparent),
            ),
            child: Row(
              children: [
                Icon(
                  widget.item.icon,
                  size: 20.r,
                  color: widget.isActive
                      ? AppColors.primary
                      : (isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight),
                ),
                SizedBox(width: 12.w),
                Text(
                  widget.item.label,
                  style: AppTypography.textTheme.titleMedium?.copyWith(
                    color: widget.isActive
                        ? (isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight)
                        : (isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight),
                    fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
