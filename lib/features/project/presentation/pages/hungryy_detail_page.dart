import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/widgets/animated_section.dart';
import 'package:portfolio/core/widgets/app_drawer.dart';
import 'package:portfolio/core/widgets/app_nav_bar.dart';
import 'package:portfolio/features/project/data/hungryy_data.dart';
import '../widgets/sections/hungryy/hs_hero_section.dart';
import '../widgets/sections/hungryy/hs_architecture_section.dart';
import '../widgets/sections/hungryy/hs_folder_structure_section.dart';
import '../widgets/sections/hungryy/hs_conclusion_section.dart';
import '../widgets/sections/hungryy/hungryy_section_builders.dart';

class HungryyDetailPage extends StatefulWidget {
  const HungryyDetailPage({super.key});

  @override
  State<HungryyDetailPage> createState() => _HungryyDetailPageState();
}

class _HungryyDetailPageState extends State<HungryyDetailPage> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _isScrolledNotifier = ValueNotifier<bool>(false);
  final HungryyData _data = const HungryyData();

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
  final HungryyData data;
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
    // 1. Hero
    (ctx) => _buildSection(HungryyHeroSection(data: data, onBackTap: goBack)),
    (ctx) => const _DividerWidget(),
    // 2. Project Overview
    (ctx) => _buildSection(
      HungryyTextSection(
        title: 'Project Overview',
        subtitle: 'What Hungryy is, the problem it solves, and why it matters.',
        body: data.overviewBody,
      ),
    ),
    (ctx) => const _DividerWidget(),
    // 3. Business Problem
    (ctx) => _buildSection(
      HungryyTextSection(
        title: 'Business Problem',
        subtitle:
            'Engineering challenges that food ordering applications must solve.',
        body: data.businessProblemBody,
        bulletPoints: data.businessProblemPoints,
      ),
    ),
    (ctx) => const _DividerWidget(),
    // 4. Solution
    (ctx) => _buildSection(
      HungryyTextSection(
        title: 'Solution',
        subtitle: 'A layered architecture with clear separation of concerns.',
        body: data.solutionBody,
      ),
    ),
    (ctx) => const _DividerWidget(),
    // 5. User Journey
    (ctx) => _buildSection(
      HungryyTextSection(
        title: 'User Journey',
        subtitle:
            'From splash screen to order confirmation — the complete user flow.',
        body:
            'Splash Screen (fade/scale logo animation, auto-login check) → '
            'Authentication Decision (valid token → Home, guest token → Home, no token → Login) → '
            'Login / Signup (email/password with validation, guest mode) → '
            'Home Screen (2-column product grid, search, category filtering) → '
            'Product Detail (hero image, spicy level, toppings, sides, quantity, add to cart) → '
            'Cart (item list, quantity controls, total, checkout) → '
            'Checkout (order summary, tax, delivery fee, payment selection) → '
            'Success (animated checkmark, delivery estimate) → Profile (edit, upload photo, logout).',
      ),
    ),
    (ctx) => const _DividerWidget(),
    // 6. Core Features
    (ctx) => _buildSection(
      HungryyCardGridSection(
        title: 'Core Features',
        subtitle:
            'Key capabilities that make Hungryy a production-quality application.',
        cards: data.coreFeatureItems,
        crossAxisCount: 2,
      ),
    ),
    (ctx) => const _DividerWidget(),
    // 7. Image Placeholders
    (ctx) => _buildSection(
      HungryyImagePlaceholdersSection(
        title: 'Screenshots',
        subtitle:
            'Replace these placeholders with actual application screenshots.',
        items: data.screenshotPlaceholders,
      ),
    ),
    (ctx) => const _DividerWidget(),
    // 8. Technical Architecture
    (ctx) => _buildSection(HungryyArchitectureSection(data: data)),
    (ctx) => const _DividerWidget(),
    // 9. Folder Structure
    (ctx) => _buildSection(HungryyFolderStructureSection(data: data)),
    (ctx) => const _DividerWidget(),
    // 10. State Management
    (ctx) => _buildSection(
      HungryyTextSection(
        title: 'State Management',
        subtitle: 'Provider-based reactive state using ChangeNotifier.',
        body: data.stateManagementBody,
      ),
    ),
    (ctx) => const _DividerWidget(),
    // 11. Repository Pattern
    (ctx) => _buildSection(
      HungryyTextSection(
        title: 'Repository Pattern',
        subtitle: 'Abstracting API calls from the UI layer.',
        body: data.repositoryBody,
      ),
    ),
    (ctx) => const _DividerWidget(),
    // 12. Networking
    (ctx) => _buildSection(
      HungryyTextSection(
        title: 'Networking Layer',
        subtitle:
            'Dio with interceptors, generic CRUD, and comprehensive error handling.',
        body: data.networkingBody,
      ),
    ),
    (ctx) => const _DividerWidget(),
    // 13. Authentication
    (ctx) => _buildSection(
      HungryyTextSection(
        title: 'Authentication Flow',
        subtitle:
            'JWT token management with persistent sessions and guest mode.',
        body: data.authenticationBody,
      ),
    ),
    (ctx) => const _DividerWidget(),
    // 14. SharedPreferences
    (ctx) => _buildSection(
      HungryyTextSection(
        title: 'SharedPreferences',
        subtitle: 'Token persistence with a minimal wrapper.',
        body: data.sharedPreferencesBody,
      ),
    ),
    (ctx) => const _DividerWidget(),
    // 15. Product Customization
    (ctx) => _buildSection(
      HungryyTextSection(
        title: 'Product Customization',
        subtitle:
            'Comprehensive customization with spicy level, toppings, and side options.',
        body: data.productCustomizationBody,
      ),
    ),
    (ctx) => const _DividerWidget(),
    // 16. Cart Management
    (ctx) => _buildSection(
      HungryyTextSection(
        title: 'Cart Management',
        subtitle: 'Real-time price calculations with tax and delivery fees.',
        body: data.cartManagementBody,
      ),
    ),
    (ctx) => const _DividerWidget(),
    // 17. Checkout Process
    (ctx) => _buildSection(
      HungryyTextSection(
        title: 'Checkout Process',
        subtitle: 'From order summary to animated success confirmation.',
        body: data.checkoutBody,
      ),
    ),
    (ctx) => const _DividerWidget(),
    // 18. Navigation Architecture
    (ctx) => _buildSection(
      HungryyTextSection(
        title: 'Navigation Architecture',
        subtitle:
            'PageView with glassmorphism bottom navigation and animated transitions.',
        body: data.navigationBody,
      ),
    ),
    (ctx) => const _DividerWidget(),
    // 19. Responsive UI
    (ctx) => _buildSection(
      HungryyTextSection(
        title: 'Responsive UI',
        subtitle: 'Adaptive layouts across mobile, tablet, and desktop.',
        body: data.responsiveUIBody,
      ),
    ),
    (ctx) => const _DividerWidget(),
    // 20. Glassmorphism Design
    (ctx) => _buildSection(
      HungryyTextSection(
        title: 'Glassmorphism Design',
        subtitle:
            'Frosted glass effects using BackdropFilter and animated navigation.',
        body: data.glassmorphismBody,
      ),
    ),
    (ctx) => const _DividerWidget(),
    // 21. Reusable Components
    (ctx) => _buildSection(
      HungryyCardGridSection(
        title: 'Reusable Components',
        subtitle: 'A library of widgets shared across the application.',
        cards: data.reusableComponentItems,
        crossAxisCount: 2,
      ),
    ),
    (ctx) => const _DividerWidget(),
    // 22. Models
    (ctx) => _buildSection(
      HungryyCardGridSection(
        title: 'Models',
        subtitle:
            'Data models with computed properties and immutable update patterns.',
        cards: data.modelItems,
        crossAxisCount: 2,
      ),
    ),
    (ctx) => const _DividerWidget(),
    // 23. Validation
    (ctx) => _buildSection(
      HungryyTextSection(
        title: 'Validation',
        subtitle: 'Form validation with regex and minimum length requirements.',
        body: data.validationBody,
      ),
    ),
    (ctx) => const _DividerWidget(),
    // 24. Image Loading Strategy
    (ctx) => _buildSection(
      HungryyTextSection(
        title: 'Image Loading Strategy',
        subtitle:
            'Network images with loading/error builders and emoji fallbacks.',
        body: data.imageLoadingBody,
      ),
    ),
    (ctx) => const _DividerWidget(),
    // 25. Skeleton Loading
    (ctx) => _buildSection(
      HungryyTextSection(
        title: 'Skeleton Loading',
        subtitle: 'Shimmer placeholder effects using the skeletonizer package.',
        body: data.skeletonLoadingBody,
      ),
    ),
    (ctx) => const _DividerWidget(),
    // 26. Loading States
    (ctx) => _buildSection(
      HungryyTextSection(
        title: 'Loading States',
        subtitle:
            'Loading, error, and empty states for every data-driven screen.',
        body: data.loadingStatesBody,
      ),
    ),
    (ctx) => const _DividerWidget(),
    // 27. Error Handling
    (ctx) => _buildSection(
      HungryyTextSection(
        title: 'Error Handling',
        subtitle: 'Comprehensive error handling from network to screen level.',
        body: data.errorHandlingBody,
      ),
    ),
    (ctx) => const _DividerWidget(),
    // 28. Performance Considerations
    (ctx) => _buildSection(
      HungryyTextSection(
        title: 'Performance Considerations',
        subtitle: 'Techniques for efficient, responsive, and smooth operation.',
        body: data.performanceBody,
      ),
    ),
    (ctx) => const _DividerWidget(),
    // 29. Technical Decisions
    (ctx) => _buildSection(
      HungryyTextSection(
        title: 'Technical Decisions',
        subtitle: 'Why each technology and pattern was chosen.',
        body: data.technicalDecisionsBody,
      ),
    ),
    (ctx) => const _DividerWidget(),
    // 30. Challenges
    (ctx) => _buildSection(
      HungryyProblemSolutionSection(
        title: 'Challenges',
        subtitle: 'Major technical challenges and how they were solved.',
        items: data.challenges,
      ),
    ),
    (ctx) => const _DividerWidget(),
    // 31. Problems Faced
    (ctx) => _buildSection(
      HungryyProblemSolutionSection(
        title: 'Problems Faced',
        subtitle:
            'Known issues identified during development and their resolutions.',
        items: data.problemsFaced,
      ),
    ),
    (ctx) => const _DividerWidget(),
    // 32. Lessons Learned
    (ctx) => _buildSection(
      HungryyBulletListSection(
        title: 'Lessons Learned',
        subtitle: 'Key takeaways from building Hungryy.',
        items: data.lessonsLearned,
      ),
    ),
    (ctx) => const _DividerWidget(),
    // 33. Skills Demonstrated
    (ctx) => _buildSection(
      HungryyBulletListSection(
        title: 'Skills Demonstrated',
        subtitle: 'Technical capabilities showcased through this project.',
        items: data.skillsDemonstrated,
      ),
    ),
    (ctx) => const _DividerWidget(),
    // 34. Responsibilities
    (ctx) => _buildSection(
      HungryyBulletListSection(
        title: 'Responsibilities',
        subtitle: 'What I built and owned in this project.',
        items: data.responsibilities,
      ),
    ),
    (ctx) => const _DividerWidget(),
    // 35. Key Achievements
    (ctx) => _buildSection(
      HungryyBulletListSection(
        title: 'Key Achievements',
        subtitle: 'Notable outcomes and technical accomplishments.',
        items: data.keyAchievements,
      ),
    ),
    (ctx) => const _DividerWidget(),
    // 36. Future Improvements
    (ctx) => _buildSection(
      HungryyCardGridSection(
        title: 'Future Improvements',
        subtitle: 'Planned enhancements and roadmap for the project.',
        cards: data.futureImprovements,
        crossAxisCount: 2,
      ),
    ),
    // 37. Conclusion
    (ctx) =>
        _buildSection(HungryyConclusionSection(data: data, onBackTap: goBack)),
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
