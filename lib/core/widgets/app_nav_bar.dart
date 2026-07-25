import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
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
    final navHeight = isMobile ? 56.0 : 72.0;

    return Container(
      height: navHeight,
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
              isMobile: isMobile,
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
              SizedBox(width: 16),
            ],
            SizedBox(width: 8),
            _ThemeToggleButton(
              isDark: isDark,
              onToggle: toggleTheme,
              isMobile: isMobile,
            ),
            if (isMobile) ...[
              SizedBox(width: 4),
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
  final bool isMobile;
  const _BrandName({required this.isScrolled, this.onTap, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final size = isMobile ? 36.0 : 44.0;
    return GestureDetector(
      onTap: onTap,
      child: ClipOval(
        child: Image.asset(
          'assets/images/5.jpeg',
          width: size,
          height: size,
          fit: BoxFit.cover,
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
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
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
            style: TextStyle(
              fontSize: 14,
              fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w400,
              color: widget.isActive ? activeColor : baseColor,
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
  final bool isMobile;

  const _ThemeToggleButton({
    required this.isDark,
    required this.onToggle,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final size = isMobile ? 36.0 : 36.0;
    return Semantics(
      button: true,
      label: isDark ? 'Switch to light mode' : 'Switch to dark mode',
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onToggle,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.black.withValues(alpha: 0.05),
            ),
            child: Icon(
              isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
              size: isMobile ? 17 : 18,
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
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.black.withValues(alpha: 0.05),
          ),
          child: Icon(
            Icons.menu_rounded,
            size: 20,
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
      ),
    );
  }
}
