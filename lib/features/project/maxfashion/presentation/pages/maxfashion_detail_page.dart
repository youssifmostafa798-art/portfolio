import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/widgets/animated_section.dart';
import 'package:portfolio/core/widgets/app_drawer.dart';
import 'package:portfolio/core/widgets/app_nav_bar.dart';
import 'package:portfolio/features/project/maxfashion/data/maxfashion_data.dart';
import '../widgets/sections/ms_hero_section.dart';
import '../widgets/sections/ms_architecture_section.dart';
import '../widgets/sections/ms_conclusion_section.dart';
import '../widgets/sections/maxfashion_section_builders.dart';

class MaxfashionDetailPage extends StatefulWidget {
  const MaxfashionDetailPage({super.key});

  @override
  State<MaxfashionDetailPage> createState() => _MaxfashionDetailPageState();
}

class _MaxfashionDetailPageState extends State<MaxfashionDetailPage> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _isScrolledNotifier = ValueNotifier<bool>(false);
  final MaxfashionData _data = const MaxfashionData();

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
    final isMobile = context.isMobile;
    final isDark = context.isDark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: isMobile ? _buildDrawer(isDark) : null,
      body: Stack(
        children: [
          _ProjectContentBody(
            scrollController: _scrollController,
            data: _data,
            goBack: _goBack,
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
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
  final MaxfashionData data;
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
        return RepaintBoundary(child: _sections[index](context));
      },
    );
  }

  List<Widget Function(BuildContext)> get _sections => [
    (ctx) => _buildSection(MaxfashionHeroSection(data: data, onBackTap: goBack)),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionTextSection(
      title: 'Project Overview',
      subtitle: 'What MaxFashion is, the problem it solves, and why it matters.',
      body: data.overviewBody,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionTextSection(
      title: 'Business Problem',
      subtitle: 'Engineering challenges that e-commerce applications must solve.',
      body: data.overviewProblemBody,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionTextSection(
      title: 'Solution',
      subtitle: 'A comprehensive Supabase-backed e-commerce solution.',
      body: data.overviewSolutionBody,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionTextSection(
      title: 'Product Value',
      subtitle: 'The core value delivered to users.',
      body: data.overviewValueBody,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionTextSection(
      title: 'Target Users',
      subtitle: 'Who this application is built for.',
      body: data.targetUsersBody,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionTextSection(
      title: 'User Journey',
      subtitle: 'From splash screen to order tracking — the complete user flow.',
      body: data.userJourneyBody,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionCardGridSection(
      title: 'Authentication Features',
      subtitle: 'Secure auth with OTP password reset and guest mode.',
      items: data.authFeatures,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionCardGridSection(
      title: 'Discovery Features',
      subtitle: 'Browse, filter, and explore products.',
      items: data.discoveryFeatures,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionCardGridSection(
      title: 'Search Features',
      subtitle: 'Full-text search with pagination and recent searches.',
      items: data.searchFeatures,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionCardGridSection(
      title: 'Shopping Features',
      subtitle: 'Cart, wishlist, addresses, and payment management.',
      items: data.shoppingFeatures,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionCardGridSection(
      title: 'Checkout Features',
      subtitle: 'Complete checkout flow with order history.',
      items: data.checkoutFeatures,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionCardGridSection(
      title: 'Profile Features',
      subtitle: 'Profile management, theme, and language settings.',
      items: data.profileFeatures,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionTextSection(
      title: 'Bilingual RTL Support',
      subtitle: 'Full English/Arabic support with proper RTL layout.',
      body: data.rtlBody,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionTextSection(
      title: 'RTL Implementation',
      subtitle: 'How RTL layout is achieved across the application.',
      body: data.rtlImplementationBody,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionTextSection(
      title: 'Theme System',
      subtitle: 'Light, Dark, and System theme with runtime switching.',
      body: data.themeBody,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionTextSection(
      title: 'Theme Colors',
      subtitle: 'Color system and design tokens.',
      body: data.themeColorsBody,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionTextSection(
      title: 'Authentication',
      subtitle: 'Supabase Auth with email/password and session management.',
      body: data.authBody,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionTextSection(
      title: 'Security',
      subtitle: 'SHA-256 hashed OTPs, rate limiting, and session invalidation.',
      body: data.securityBody,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionArchitectureSection(data: data)),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionTextSection(
      title: 'Database Design',
      subtitle: 'PostgreSQL with Row Level Security and 25 migrations.',
      body: data.databaseBody,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionMetricsSection(
      title: 'Database Metrics',
      items: data.databaseMetrics,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionTextSection(
      title: 'State Management',
      subtitle: 'Riverpod with StateNotifier pattern.',
      body: data.stateManagementBody,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionCardGridSection(
      title: 'Provider Patterns',
      subtitle: 'Different Riverpod provider types used.',
      items: data.providerItems,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionTextSection(
      title: 'Search Implementation',
      subtitle: 'PostgreSQL full-text search with trigram matching.',
      body: data.searchBody,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionTextSection(
      title: 'Shopping Flow',
      subtitle: 'Complete purchase journey from browsing to order tracking.',
      body: data.shoppingFlowBody,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionTextSection(
      title: 'Custom Shimmer Loading',
      subtitle: 'Built from scratch without third-party loading packages.',
      body: data.shimmerBody,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionCardGridSection(
      title: 'Skeleton System',
      subtitle: 'Reusable skeleton components and feature-specific variants.',
      items: data.skeletonItems,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionTextSection(
      title: 'Guest Mode',
      subtitle: 'Browse without an account with progressive enhancement.',
      body: data.guestModeBody,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionTextSection(
      title: 'Optimistic UI Updates',
      subtitle: 'Instant feedback with automatic rollback on failure.',
      body: data.optimisticBody,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionTextSection(
      title: 'Data Migration',
      subtitle: 'Local-to-Supabase order migration with deduplication.',
      body: data.migrationBody,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionProblemSolutionSection(
      title: 'Engineering Challenges',
      subtitle: 'Major technical challenges and how they were solved.',
      items: data.challenges,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionMetricsSection(
      title: 'Results',
      items: data.resultsMetrics,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionBulletListSection(
      title: 'Key Highlights',
      items: data.resultsHighlights,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionProblemSolutionSection(
      title: 'Lessons Learned',
      subtitle: 'Key takeaways and technical decisions.',
      items: data.lessons,
    )),
    (ctx) => const _DividerWidget(),
    (ctx) => _buildSection(MaxfashionCardGridSection(
      title: 'Future Improvements',
      subtitle: 'Planned enhancements and roadmap.',
      items: data.futureItems,
    )),
    (ctx) => _buildSection(MaxfashionConclusionSection(data: data, onBackTap: goBack)),
  ];

  Widget _buildSection(Widget child) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1440),
        child: AnimatedSection(child: child),
      ),
    );
  }
}

class _DividerWidget extends StatelessWidget {
  const _DividerWidget();

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    return Container(
      width: double.infinity,
      height: 1,
      color: isDark
          ? AppColors.darkDivider.withValues(alpha: 0.3)
          : AppColors.lightDivider.withValues(alpha: 0.3),
    );
  }
}
