import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/widgets/animated_section.dart';
import 'package:portfolio/core/widgets/app_drawer.dart';
import 'package:portfolio/core/widgets/app_nav_bar.dart';
import '../widgets/sections/ps_hero_section.dart';
import '../widgets/sections/ps_overview_section.dart';
import '../widgets/sections/ps_contribution_section.dart';
import '../widgets/sections/ps_features_section.dart';
import '../widgets/sections/ps_architecture_section.dart';
import '../widgets/sections/ps_tech_section.dart';
import '../widgets/sections/ps_challenges_section.dart';
import '../widgets/sections/ps_performance_section.dart';
import '../widgets/sections/ps_gallery_section.dart';
import '../widgets/sections/ps_results_section.dart';
import '../widgets/sections/ps_lessons_section.dart';
import '../widgets/sections/ps_future_section.dart';
import '../widgets/sections/ps_bottom_cta_section.dart';

class ProjectDetailPage extends StatefulWidget {
  const ProjectDetailPage({super.key});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    final scrolled = offset > 60;
    if (scrolled != _isScrolled) {
      setState(() => _isScrolled = scrolled);
    }
  }

  void _goBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final isDark = context.isDark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: isMobile ? _buildDrawer(isDark) : null,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            physics: const ClampingScrollPhysics(),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 1440.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedSection(
                      child: ProjectHeroSection(onBackTap: _goBack),
                    ),
                    const DividerWidget(),
                    AnimatedSection(
                      child: const ProjectOverviewSection(),
                    ),
                    const DividerWidget(),
                    AnimatedSection(
                      child: const ContributionSection(),
                    ),
                    const DividerWidget(),
                    AnimatedSection(
                      child: const FeaturesSection(),
                    ),
                    const DividerWidget(),
                    AnimatedSection(
                      child: const ArchitectureSection(),
                    ),
                    const DividerWidget(),
                    AnimatedSection(
                      child: const TechSection(),
                    ),
                    const DividerWidget(),
                    AnimatedSection(
                      child: const ChallengesSection(),
                    ),
                    const DividerWidget(),
                    AnimatedSection(
                      child: const PerformanceSection(),
                    ),
                    const DividerWidget(),
                    AnimatedSection(
                      child: const GallerySection(),
                    ),
                    const DividerWidget(),
                    AnimatedSection(
                      child: const ResultsSection(),
                    ),
                    const DividerWidget(),
                    AnimatedSection(
                      child: const LessonsSection(),
                    ),
                    const DividerWidget(),
                    AnimatedSection(
                      child: const FutureSection(),
                    ),
                    AnimatedSection(
                      child: BottomCTASection(onBackTap: _goBack),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0, left: 0, right: 0,
            child: AppNavBar(
              isScrolled: _isScrolled,
              activeSection: 3,
              onNavTap: (index) {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(bool isDark) {
    return AppDrawer(
      activeSection: 3,
      onNavTap: (index) {
        Navigator.pop(context);
        if (index == 0) _goBack();
      },
    );
  }
}

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    return Container(
      width: double.infinity,
      height: 1,
      color: isDark ? AppColors.darkDivider.withValues(alpha: 0.3) : AppColors.lightDivider.withValues(alpha: 0.3),
    );
  }
}
