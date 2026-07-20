import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/widgets/animated_section.dart';
import 'package:portfolio/core/widgets/app_drawer.dart';
import 'package:portfolio/core/widgets/app_nav_bar.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/about_section.dart';
import '../widgets/sections/skills_section.dart';
import '../widgets/sections/projects_section.dart';
import '../widgets/sections/contact_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(5, (_) => GlobalKey());
  bool _isScrolled = false;
  int _activeSection = 0;

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
    _updateActiveSection();
  }

  void _updateActiveSection() {
    for (int i = 0; i < _sectionKeys.length; i++) {
      final ctx = _sectionKeys[i].currentContext;
      if (ctx != null) {
        final box = ctx.findRenderObject() as RenderBox?;
        if (box != null && box.hasSize) {
          final position = box.localToGlobal(Offset.zero);
          final height = box.size.height;
          if (position.dy > -height * 0.3 && position.dy < 300) {
            if (_activeSection != i) {
              setState(() => _activeSection = i);
            }
            break;
          }
        }
      }
    }
  }

  void _scrollToSection(int index) {
    final ctx = _sectionKeys[index].currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
        alignment: 0.08,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: isMobile
          ? AppDrawer(
              activeSection: _activeSection,
              onNavTap: (index) {
                context.pop();
                _scrollToSection(index);
              },
            )
          : null,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            physics: const ClampingScrollPhysics(),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 1440.w),
                child: Column(
                  children: [
                    SizedBox(
                      key: _sectionKeys[0],
                      child: const HeroSection(),
                    ),
                    AnimatedSection(
                      child: SizedBox(
                        key: _sectionKeys[1],
                        child: const AboutSection(),
                      ),
                    ),
                    AnimatedSection(
                      child: SizedBox(
                        key: _sectionKeys[2],
                        child: const SkillsSection(),
                      ),
                    ),
                    AnimatedSection(
                      child: SizedBox(
                        key: _sectionKeys[3],
                        child: ProjectsSection(
                          onCaseStudyTap: (projectId) {
                            context.pushNamed('project', pathParameters: {'projectId': projectId});
                          },
                        ),
                      ),
                    ),
                    AnimatedSection(
                      child: SizedBox(
                        key: _sectionKeys[4],
                        child: const ContactSection(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppNavBar(
              isScrolled: _isScrolled,
              activeSection: _activeSection,
              onNavTap: _scrollToSection,
            ),
          ),
        ],
      ),
    );
  }
}
