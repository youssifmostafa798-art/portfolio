import 'package:flutter/material.dart';

abstract class ProjectData {
  String get id;
  String get title;
  String get tagline;
  String get role;
  String get status;
  String get teamSize;
  String get timeline;
  String get demoUrl;
  String get screenshotsUrl;
  String get githubUrl;
  List<String> get techStack;
  List<String> get techStackTop;

  String get overviewWhat;
  String get overviewProblem;
  String get overviewTargetUsers;
  String get overviewWhyMatters;

  List<String> get contributions;

  List<FeatureItem> get features;
  List<ArchitectureLayer> get architecture;
  List<TechCategory> get techCategories;
  List<ChallengeItem> get challenges;
  List<PerformanceItem> get performanceItems;
  List<String> get results;
  List<String> get lessons;
  List<FutureItem> get futureItems;

  List<String> get screenshotLabels;
  List<Color> get screenshotColors;

  String get overviewSubtitle;
  String get contributionSubtitle;
  String get featuresSubtitle;
  String get architectureSubtitle;
  String get techStackSubtitle;
  String get challengesSubtitle;
  String get performanceSubtitle;
  String get gallerySubtitle;
  String get resultsSubtitle;
  String get lessonsSubtitle;
  String get futureSubtitle;
  String get bottomCtaTitle;
  String get bottomCtaSubtitle;
}

class FeatureItem {
  final String title;
  final String description;
  final IconData icon;
  const FeatureItem(this.title, this.description, this.icon);
}

class ArchitectureLayer {
  final String layer;
  final String detail;
  const ArchitectureLayer(this.layer, this.detail);
}

class TechCategory {
  final String category;
  final String items;
  const TechCategory(this.category, this.items);
}

class ChallengeItem {
  final String title;
  final String problem;
  final String solution;
  const ChallengeItem(this.title, this.problem, this.solution);
}

class PerformanceItem {
  final String title;
  final String description;
  const PerformanceItem(this.title, this.description);
}

class FutureItem {
  final String title;
  final String description;
  final IconData icon;
  const FutureItem(this.title, this.description, this.icon);
}
