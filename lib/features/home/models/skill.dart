import 'package:flutter/material.dart';

enum SkillProficiency { proficient, advanced, expert }

extension SkillProficiencyX on SkillProficiency {
  int get dotCount {
    switch (this) {
      case SkillProficiency.proficient:
        return 3;
      case SkillProficiency.advanced:
        return 4;
      case SkillProficiency.expert:
        return 5;
    }
  }
}

class Skill {
  final String name;
  final IconData icon;
  final String category;
  final SkillProficiency proficiency;

  const Skill({
    required this.name,
    required this.icon,
    required this.category,
    required this.proficiency,
  });
}
