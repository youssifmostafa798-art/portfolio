import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/features/project/hungryy/data/hungryy_data.dart';
import 'hungryy_colors.dart';

class HungryyConclusionSection extends StatelessWidget {
  final HungryyData data;
  const HungryyConclusionSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final isMobile = responsive.isMobile;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: responsive.responsivePadding,
        vertical: isMobile ? 48 : 80,
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            constraints:
                BoxConstraints(maxWidth: isMobile ? double.infinity : 700),
            padding: EdgeInsets.all(isMobile ? 24 : 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(context.responsiveBorderRadius),
              gradient: const LinearGradient(
                colors: [HungryyColors.primary, HungryyColors.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Conclusion',
                  style: TextStyle(
                    fontSize: isMobile ? 22 : 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: isMobile ? 16 : 20),
                Text(
                  data.conclusionBody,
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 15,
                    color: Colors.white.withValues(alpha: 0.9),
                    height: 1.7,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
