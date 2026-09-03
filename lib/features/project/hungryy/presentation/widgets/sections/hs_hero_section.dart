import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/utils/url_utils.dart';
import 'package:portfolio/features/project/hungryy/data/hungryy_data.dart';
import 'hungryy_colors.dart';

class HungryyHeroSection extends StatelessWidget {
  final HungryyData data;
  final VoidCallback? onBackTap;
  const HungryyHeroSection({super.key, required this.data, this.onBackTap});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final isMobile = responsive.isMobile;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: responsive.responsivePadding,
        vertical: isMobile ? 40 : 64,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: isMobile ? 20 : 32),
          if (onBackTap != null) _BackButton(onTap: onBackTap!),
          SizedBox(height: isMobile ? 28 : 48),
          _buildHeroContent(context, responsive),
        ],
      ),
    );
  }

  Widget _buildHeroContent(BuildContext context, ResponsiveData responsive) {
    final isDark = responsive.isDark;
    final isMobile = responsive.isMobile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StatusBadge(isDark: isDark, status: data.status),
        SizedBox(height: isMobile ? 14 : 24),
        Text(
          data.title,
          style: TextStyle(
            fontSize: isMobile ? 30 : 48,
            fontWeight: FontWeight.w700,
            height: 1.08,
            letterSpacing: -0.02,
            color:
                isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
          ),
        ),
        SizedBox(height: isMobile ? 6 : 12),
        Text(
          data.tagline,
          style: TextStyle(
            fontSize: isMobile ? 16 : 20,
            color: HungryyColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: isMobile ? 16 : 24),
        if (!isMobile)
          Row(
            children: [
              _MetaItem(label: 'Role', value: data.role, isDark: isDark),
              SizedBox(width: 32),
              _MetaItem(
                  label: 'Team',
                  value: '${data.teamSize} Members',
                  isDark: isDark),
              SizedBox(width: 32),
              _MetaItem(
                  label: 'Timeline', value: data.timeline, isDark: isDark),
            ],
          )
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _MetaItem(label: 'Role', value: data.role, isDark: isDark),
              SizedBox(height: 8),
              _MetaItem(
                  label: 'Team',
                  value: '${data.teamSize} Members',
                  isDark: isDark),
              SizedBox(height: 8),
              _MetaItem(
                  label: 'Timeline', value: data.timeline, isDark: isDark),
            ],
          ),
        SizedBox(height: isMobile ? 20 : 24),
        Text(
          data.heroDescription,
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
            height: 1.7,
          ),
        ),
        SizedBox(height: isMobile ? 20 : 24),
        Wrap(
          spacing: isMobile ? 6 : 8,
          runSpacing: isMobile ? 6 : 8,
          children: data.techStackTop
              .map((t) => _TechChip(
                  label: t, isDark: isDark, isMobile: isMobile))
              .toList(),
        ),
        SizedBox(height: isMobile ? 24 : 32),
        _ActionRow(data: data, isDark: isDark, isMobile: isMobile),
      ],
    );
  }
}

class _BackButton extends StatelessWidget {
  final VoidCallback onTap;
  const _BackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final isMobile = context.isMobile;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.arrow_back_rounded,
              size: isMobile ? 17 : 18,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
            SizedBox(width: isMobile ? 8 : 10),
            Text(
              'Back to Portfolio',
              style: TextStyle(
                fontSize: isMobile ? 13 : 15,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isDark;
  final String status;
  const _StatusBadge({required this.isDark, required this.status});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 10 : 12, vertical: isMobile ? 5 : 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppColors.success.withValues(alpha: 0.1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: isMobile ? 5 : 6,
            height: isMobile ? 5 : 6,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.success,
            ),
          ),
          SizedBox(width: isMobile ? 5 : 6),
          Text(
            status,
            style: TextStyle(
              fontSize: isMobile ? 11 : 12,
              color: AppColors.success,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaItem extends StatelessWidget {
  final String label, value;
  final bool isDark;
  const _MetaItem(
      {required this.label, required this.value, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isMobile ? 12 : 13,
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
        ),
        SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: isMobile ? 13 : 15,
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _TechChip extends StatelessWidget {
  final String label;
  final bool isDark;
  final bool isMobile;
  const _TechChip(
      {required this.label, required this.isDark, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 10 : 12, vertical: isMobile ? 5 : 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: HungryyColors.primary.withValues(alpha: 0.1),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: isMobile ? 11 : 12,
          color: HungryyColors.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  final HungryyData data;
  final bool isDark;
  final bool isMobile;
  const _ActionRow(
      {required this.data, required this.isDark, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: isMobile ? 6 : 8,
      runSpacing: isMobile ? 6 : 8,
      children: [
        _PButton(
          label: 'GitHub',
          icon: Icons.code_rounded,
          onPressed: () => UrlUtils.openUrl(data.githubUrl),
          isMobile: isMobile,
        ),
      ],
    );
  }
}

class _PButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isMobile;
  const _PButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    required this.isMobile,
  });

  @override
  State<_PButton> createState() => _PButtonState();
}

class _PButtonState extends State<_PButton> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _isHovered
            ? Matrix4.translationValues(0, -1, 0)
            : Matrix4.identity(),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: widget.isMobile ? 14 : 18,
                vertical: widget.isMobile ? 12 : 11,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: HungryyColors.primary,
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                          color: HungryyColors.primary.withValues(alpha: 0.3),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(widget.icon,
                      size: widget.isMobile ? 15 : 16, color: Colors.white),
                  SizedBox(width: widget.isMobile ? 5 : 6),
                  Text(
                    widget.label,
                    style: TextStyle(
                      fontSize: widget.isMobile ? 12 : 13,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
