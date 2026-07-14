import 'package:flutter/material.dart';
import '../extensions/context_extensions.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
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

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        transform: _isHovered
            ? Matrix4.translationValues(0, -4, 0)
            : Matrix4.identity(),
        child: GlassCard(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Icon(
                  widget.skill.icon,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                widget.skill.name,
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color:
                      isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              _ProficiencyDots(
                dotCount: widget.skill.proficiency.dotCount,
                isDark: isDark,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                widget.skill.category,
                style: context.textTheme.bodySmall?.copyWith(
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

  const _ProficiencyDots({
    required this.dotCount,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final filled = i < dotCount;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: filled
                ? AppColors.primary
                : Colors.transparent,
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
