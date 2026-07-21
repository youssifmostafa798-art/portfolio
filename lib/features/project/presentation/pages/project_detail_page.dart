import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/widgets/animated_section.dart';
import 'package:portfolio/core/widgets/app_drawer.dart';
import 'package:portfolio/core/widgets/app_nav_bar.dart';
import 'package:portfolio/features/project/data/project_data.dart';
import 'package:portfolio/features/project/data/project_data_registry.dart';
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
  final String projectId;
  const ProjectDetailPage({super.key, required this.projectId});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _isScrolledNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _isScrolledNotifier.dispose();
    super.dispose();
  }

  void _onScroll() {
    final scrolled = _scrollController.offset > 60;
    if (scrolled != _isScrolledNotifier.value) {
      _isScrolledNotifier.value = scrolled;
    }
  }

  void _goBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.goNamed('home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final projectData = ProjectDataRegistry.get(widget.projectId);
    if (projectData == null) {
      return Scaffold(
        body: Center(
          child: Text('Project "${widget.projectId}" not found.'),
        ),
      );
    }

    final data = projectData;
    final isMobile = context.isMobile;
    final isDark = context.isDark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: isMobile ? _buildDrawer(isDark) : null,
      body: Stack(
        children: [
          _ProjectContentBody(
            scrollController: _scrollController,
            data: data,
            goBack: _goBack,
          ),
          Positioned(
            top: 0, left: 0, right: 0,
            child: ValueListenableBuilder<bool>(
              valueListenable: _isScrolledNotifier,
              builder: (context, isScrolled, _) {
                return AppNavBar(
                  isScrolled: isScrolled,
                  activeSection: 3,
                  onNavTap: (index) => context.goNamed('home'),
                );
              },
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
        context.pop();
        if (index == 0) _goBack();
      },
    );
  }
}

class _ProjectContentBody extends StatelessWidget {
  final ScrollController scrollController;
  final ProjectData data;
  final VoidCallback goBack;

  const _ProjectContentBody({
    required this.scrollController,
    required this.data,
    required this.goBack,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      physics: const ClampingScrollPhysics(),
      itemCount: _sections.length,
      itemBuilder: (context, index) {
        return RepaintBoundary(
          child: _sections[index](context),
        );
      },
    );
  }

  List<Widget Function(BuildContext)> get _sections => [
    (ctx) => _buildSection(ProjectHeroSection(data: data, onBackTap: goBack)),
    (ctx) => const DividerWidget(),
    (ctx) => _buildSection(ProjectOverviewSection(data: data)),
    (ctx) => const DividerWidget(),
    (ctx) => _buildSection(ContributionSection(data: data)),
    (ctx) => const DividerWidget(),
    (ctx) => _buildSection(FeaturesSection(data: data)),
    (ctx) => const DividerWidget(),
    (ctx) => _buildSection(ArchitectureSection(data: data)),
    (ctx) => const DividerWidget(),
    (ctx) => _buildSection(TechSection(data: data)),
    (ctx) => const DividerWidget(),
    (ctx) => _buildSection(ChallengesSection(data: data)),
    (ctx) => const DividerWidget(),
    (ctx) => _buildSection(PerformanceSection(data: data)),
    (ctx) => const DividerWidget(),
    (ctx) => _buildSection(GallerySection(data: data)),
    (ctx) => const DividerWidget(),
    (ctx) => _buildSection(ResultsSection(data: data)),
    (ctx) => const DividerWidget(),
    (ctx) => _buildSection(LessonsSection(data: data)),
    (ctx) => const DividerWidget(),
    (ctx) => _buildSection(FutureSection(data: data)),
    (ctx) => _buildSection(BottomCTASection(data: data, onBackTap: goBack)),
  ];

  Widget _buildSection(Widget child) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 1440.w),
        child: AnimatedSection(child: child),
      ),
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
