import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
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
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppConstants.appName,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      AppConstants.title,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Divider(
                color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
                height: 1,
              ),
              SizedBox(height: 8),
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
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    Icon(
                      isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                      size: 20,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
                    SizedBox(width: 12),
                    Text(
                      '${isDark ? 'Dark' : 'Light'} Mode',
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: toggleTheme,
                      child: Container(
                        width: 48,
                        height: 28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: isDark
                              ? AppColors.primary
                              : AppColors.textTertiaryLight,
                        ),
                        padding: const EdgeInsets.all(2),
                        child: AnimatedAlign(
                          duration: const Duration(milliseconds: 200),
                          alignment: isDark
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            width: 24,
                            height: 24,
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
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
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
                  size: 22,
                  color: widget.isActive
                      ? AppColors.primary
                      : (isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight),
                ),
                SizedBox(width: 12),
                Text(
                  widget.item.label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w400,
                    color: widget.isActive
                        ? (isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight)
                        : (isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight),
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
