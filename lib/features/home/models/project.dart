import 'dart:ui';

class Project {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String role;
  final List<String> technologies;
  final List<String> highlights;
  final String? imageUrl;
  final List<String> galleryUrls;
  final String? githubUrl;
  final String? demoUrl;
  final String? caseStudyRoute;
  final String? googleDriveScreenshotsUrl;
  final String? logoAsset;
  final String? cardSubtitle;
  final List<Color>? cardGradientColors;
  final Color? cardGlowColor;
  final List<Color>? cardLogoGradientColors;

  const Project({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.role,
    required this.technologies,
    required this.highlights,
    this.imageUrl,
    this.galleryUrls = const [],
    this.githubUrl,
    this.demoUrl,
    this.caseStudyRoute,
    this.googleDriveScreenshotsUrl,
    this.logoAsset,
    this.cardSubtitle,
    this.cardGradientColors,
    this.cardGlowColor,
    this.cardLogoGradientColors,
  });
}
