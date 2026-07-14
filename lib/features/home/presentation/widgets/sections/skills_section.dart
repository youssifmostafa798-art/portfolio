import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/widgets/section_label.dart';
import 'package:portfolio/core/widgets/skill_card.dart';
import 'package:portfolio/features/home/models/skill.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static const List<Skill> _skills = [
    Skill(
      name: 'Flutter',
      icon: Icons.flutter_dash,
      category: 'Flutter & Dart',
      proficiency: SkillProficiency.expert,
    ),
    Skill(
      name: 'Dart',
      icon: Icons.terminal_rounded,
      category: 'Flutter & Dart',
      proficiency: SkillProficiency.expert,
    ),
    Skill(
      name: 'Riverpod',
      icon: Icons.water_drop_rounded,
      category: 'State Management',
      proficiency: SkillProficiency.expert,
    ),
    Skill(
      name: 'State Management',
      icon: Icons.all_out_rounded,
      category: 'State Management',
      proficiency: SkillProficiency.expert,
    ),
    Skill(
      name: 'Firebase',
      icon: Icons.local_fire_department_rounded,
      category: 'Backend & Database',
      proficiency: SkillProficiency.advanced,
    ),
    Skill(
      name: 'Supabase',
      icon: Icons.cloud_rounded,
      category: 'Backend & Database',
      proficiency: SkillProficiency.advanced,
    ),
    Skill(
      name: 'REST API',
      icon: Icons.api_rounded,
      category: 'Backend & Database',
      proficiency: SkillProficiency.advanced,
    ),
    Skill(
      name: 'Clean Architecture',
      icon: Icons.account_tree_rounded,
      category: 'Architecture',
      proficiency: SkillProficiency.advanced,
    ),
    Skill(
      name: 'Clean UI',
      icon: Icons.palette_rounded,
      category: 'Architecture',
      proficiency: SkillProficiency.advanced,
    ),
    Skill(
      name: 'Reusable Components',
      icon: Icons.widgets_rounded,
      category: 'Architecture',
      proficiency: SkillProficiency.advanced,
    ),
    Skill(
      name: 'Git',
      icon: Icons.call_split_rounded,
      category: 'Tools',
      proficiency: SkillProficiency.proficient,
    ),
    Skill(
      name: 'GitHub',
      icon: Icons.merge_type_rounded,
      category: 'Tools',
      proficiency: SkillProficiency.proficient,
    ),
    Skill(
      name: 'Responsive UI',
      icon: Icons.phone_android_rounded,
      category: 'UI/UX',
      proficiency: SkillProficiency.advanced,
    ),
  ];

  static Map<String, List<Skill>> get _groupedSkills {
    final map = <String, List<Skill>>{};
    for (final skill in _skills) {
      map.putIfAbsent(skill.category, () => []);
      map[skill.category]!.add(skill);
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final isTablet = context.isTablet;
    final grouped = _groupedSkills;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.responsivePadding,
        vertical: 120.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionLabel(
            label: 'Skills',
            subtitle: 'Technologies and tools I work with.',
          ),
          SizedBox(height: isMobile ? 32.h : 48.h),
          ...grouped.entries.map((entry) {
            return _SkillCategory(
              category: entry.key,
              skills: entry.value,
              isMobile: isMobile,
              isTablet: isTablet,
            );
          }),
        ],
      ),
    );
  }
}

class _SkillCategory extends StatelessWidget {
  final String category;
  final List<Skill> skills;
  final bool isMobile;
  final bool isTablet;

  const _SkillCategory({
    required this.category,
    required this.skills,
    required this.isMobile,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);
    final spacing = 16.w;

    return Padding(
      padding: EdgeInsets.only(bottom: 48.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            style: context.textTheme.titleLarge?.copyWith(
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            ),
          ),
          SizedBox(height: 16.h),
          LayoutBuilder(
            builder: (context, constraints) {
              final availableWidth = constraints.maxWidth;
              final childWidth =
                  (availableWidth - (spacing * (crossAxisCount - 1))) /
                      crossAxisCount;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: skills.map((skill) {
                  return SizedBox(
                    width: childWidth,
                    child: SkillCard(skill: skill),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
