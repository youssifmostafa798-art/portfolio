import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../extensions/context_extensions.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../../features/home/presentation/providers/theme_provider.dart';

final class NavItem {
  final String label;
  final int index;
  const NavItem(this.label, this.index);
}

class AppNavBar extends ConsumerStatefulWidget {
  final bool isScrolled;
  final int activeSection;
  final Function(int) onNavTap;

  const AppNavBar({
    super.key,
    required this.isScrolled,
    required this.activeSection,
    required this.onNavTap,
  });

  @override
  ConsumerState<AppNavBar> createState() => _AppNavBarState();
}

class _AppNavBarState extends ConsumerState<AppNavBar> {
  static const List<NavItem> _navItems = [
    NavItem('Home', 0),
    NavItem('About', 1),
    NavItem('Skills', 2),
    NavItem('Projects', 3),
    NavItem('Contact', 4),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final isMobile = context.isMobile;
    final toggleTheme = ref.read(themeToggleProvider);

    return Container(
      height: isMobile ? 60.h : 72.h,
      decoration: BoxDecoration(
        color: widget.isScrolled
            ? (isDark
                ? AppColors.darkBackground.withValues(alpha: 0.82)
                : Colors.white.withValues(alpha: 0.82))
            : Colors.transparent,
        border: widget.isScrolled
            ? Border(
                bottom: BorderSide(
                  color: isDark
                      ? AppColors.darkDivider.withValues(alpha: 0.5)
                      : AppColors.lightDivider.withValues(alpha: 0.5),
                ),
              )
            : null,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.responsivePadding),
        child: Row(
          children: [
            _BrandName(
              isScrolled: widget.isScrolled,
              onTap: () => widget.onNavTap(0),
            ),
            if (!isMobile) ...[
              const Spacer(),
              ...List.generate(_navItems.length, (i) {
                final item = _navItems[i];
                final isActive = widget.activeSection == item.index;
                return _NavLink(
                  label: item.label,
                  isActive: isActive,
                  onTap: () => widget.onNavTap(item.index),
                );
              }),
              SizedBox(width: 16.w),
            ],
            SizedBox(width: 8.w),
            _ThemeToggleButton(
              isDark: isDark,
              onToggle: toggleTheme,
            ),
            if (isMobile) ...[
              SizedBox(width: 4.w),
              _MenuButton(
                onTap: () => Scaffold.of(context).openDrawer(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _BrandName extends StatelessWidget {
  final bool isScrolled;
  final VoidCallback? onTap;
  const _BrandName({required this.isScrolled, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final color = isScrolled
        ? (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)
        : AppColors.textPrimaryDark;

    return GestureDetector(
      onTap: onTap,
      child: Text(
        'YM',
        style: AppTypography.textTheme.titleLarge?.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavLink({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final baseColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final activeColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Semantics(
        button: true,
        label: 'Navigate to ${widget.label}',
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
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
          child: Text(
            widget.label,
            style: AppTypography.textTheme.labelLarge?.copyWith(
              color: widget.isActive ? activeColor : baseColor,
              fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
      ),
    );
  }
}

class _ThemeToggleButton extends StatelessWidget {
  final bool isDark;
  final VoidCallback onToggle;

  const _ThemeToggleButton({
    required this.isDark,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: isDark ? 'Switch to light mode' : 'Switch to dark mode',
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onToggle,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 36.r,
            height: 36.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.black.withValues(alpha: 0.05),
            ),
            child: Icon(
              isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
              size: 18.r,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final VoidCallback onTap;
  const _MenuButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    return Semantics(
      button: true,
      label: 'Open navigation menu',
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 36.r,
          height: 36.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.black.withValues(alpha: 0.05),
          ),
          child: Icon(
            Icons.menu_rounded,
            size: 20.r,
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
      ),
    );
  }
}
