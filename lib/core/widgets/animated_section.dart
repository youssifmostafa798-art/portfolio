import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnimatedSection extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final double slideOffset;
  final Curve curve;

  const AnimatedSection({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 600),
    this.slideOffset = 0.08,
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<AnimatedSection> createState() => _AnimatedSectionState();
}

class _AnimatedSectionState extends State<AnimatedSection> {
  bool _isVisible = false;
  late final Key _visibilityKey;
  static int _keyCounter = 0;

  @override
  void initState() {
    super.initState();
    _keyCounter++;
    _visibilityKey = ValueKey('animated_section_$_keyCounter');
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _visibilityKey,
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.05 && !_isVisible) {
          setState(() => _isVisible = true);
        }
      },
      child: _isVisible
          ? widget.child.animate().fadeIn(
                duration: widget.duration,
                delay: widget.delay,
                curve: widget.curve,
              ).slideY(
                begin: widget.slideOffset,
                end: 0,
                duration: widget.duration,
                delay: widget.delay,
                curve: widget.curve,
              )
          : Opacity(
              opacity: 0,
              child: widget.child,
            ),
    );
  }
}
