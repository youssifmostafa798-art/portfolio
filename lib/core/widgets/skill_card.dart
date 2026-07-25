import 'package:flutter/material.dart';
import '../extensions/context_extensions.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_card.dart';
import '../../features/home/models/skill.dart';

class SkillCard extends StatefulWidget {
  final Skill skill;
  const SkillCard({super.key, required this.skill});

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final isMobile = context.isMobile;
    final iconSize = context.responsiveIconSize;
    final iconContainerSize = context.responsiveIconContainerSize;
    final cardPadding = context.responsiveCardPadding;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        transform: _isHovered
            ? Matrix4.translationValues(0, isMobile ? -2 : -4, 0)
            : Matrix4.identity(),
        child: GlassCard(
          padding: EdgeInsets.all(cardPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: iconContainerSize,
                height: iconContainerSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(isMobile ? 12 : 14),
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Icon(
                  widget.skill.icon,
                  color: Colors.white,
                  size: iconSize,
                ),
              ),
              SizedBox(height: isMobile ? 10 : 12),
              Text(
                widget.skill.name,
                style: TextStyle(
                  fontSize: isMobile ? 13 : 14,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isMobile ? 10 : 12),
              _ProficiencyDots(
                dotCount: widget.skill.proficiency.dotCount,
                isDark: isDark,
                isMobile: isMobile,
              ),
              SizedBox(height: isMobile ? 6 : 8),
              Text(
                widget.skill.category,
                style: TextStyle(
                  fontSize: isMobile ? 11 : 12,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProficiencyDots extends StatelessWidget {
  final int dotCount;
  final bool isDark;
  final bool isMobile;

  const _ProficiencyDots({
    required this.dotCount,
    required this.isDark,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final dotSize = isMobile ? 7.0 : 8.0;
    final dotSpacing = isMobile ? 2.5 : 3.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final filled = i < dotCount;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: dotSize,
          height: dotSize,
          margin: EdgeInsets.symmetric(horizontal: dotSpacing),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: filled ? AppColors.primary : Colors.transparent,
            border: Border.all(
              color: filled
                  ? AppColors.primary
                  : (isDark
                        ? AppColors.textTertiaryDark
                        : AppColors.textTertiaryLight),
              width: 1.5,
            ),
          ),
        );
      }),
    );
  }
}
