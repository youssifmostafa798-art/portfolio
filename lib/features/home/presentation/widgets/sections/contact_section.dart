import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/theme/app_typography.dart';
import 'package:portfolio/core/widgets/glass_card.dart';
import 'package:portfolio/core/widgets/section_label.dart';
import 'package:portfolio/core/constants/app_constants.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../providers/contact_provider.dart';

class ContactSection extends ConsumerStatefulWidget {
  const ContactSection({super.key});

  @override
  ConsumerState<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends ConsumerState<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ref
          .read(contactFormProvider.notifier)
          .submit(
            name: _nameController.text,
            email: _emailController.text,
            phone: _phoneController.text,
            message: _messageController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<ContactFormState>(contactFormProvider, (previous, next) {
      if (next.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message ?? 'Message sent successfully!'),
            backgroundColor:
                Colors.green, // Fallback if AppColors.success is missing
          ),
        );
        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _messageController.clear();
        ref.read(contactFormProvider.notifier).reset();
      } else if (next.isError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message ?? 'Failed to send message.'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    });

    final formState = ref.watch(contactFormProvider);
    final isSending = formState.isSending;
    final isDark = context.isDark;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsivePadding,
        vertical: 120.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionLabel(
            label: 'Get In Touch',
            subtitle:
                'Have a project in mind or want to discuss opportunities? I\'d love to hear from you.',
          ),
          SizedBox(height: 60.h),
          if (context.isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _buildContactInfo(isDark)),
                SizedBox(width: 80.w),
                Expanded(flex: 3, child: _buildForm(isSending, isDark)),
              ],
            )
          else
            Column(
              children: [
                _buildContactInfo(isDark),
                SizedBox(height: 40.h),
                _buildForm(isSending, isDark),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(bool isDark) {
    return Column(
      children: [
        ContactInfoCard(
          icon: Icons.email_outlined,
          label: 'Email',
          value: 'youssifmostafa798@gmail.com',
          destination: 'mailto:youssifmostafa798@gmail.com',
        ),
        SizedBox(height: 16.h),
        ContactInfoCard(
          icon: Icons.code, // GitHub icon fallback
          label: 'GitHub',
          value: AppConstants.github,
          destination: AppConstants.github,
        ),
        SizedBox(height: 16.h),
        ContactInfoCard(
          icon: Icons.work_outline, // LinkedIn icon fallback
          label: 'LinkedIn',
          value: AppConstants.linkedin,
          destination: AppConstants.linkedin,
        ),
      ],
    );
  }

  Widget _buildForm(bool isSending, bool isDark) {
    final inputStyle = AppTypography.textTheme.bodyLarge?.copyWith(
      color: isDark ? Colors.white : Colors.black87,
    );

    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: isDark
          ? Colors.white.withValues(alpha: 0.05)
          : Colors.black.withValues(alpha: 0.03),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(
          color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: AppColors.error, width: 1),
      ),
      labelStyle: AppTypography.textTheme.bodyMedium?.copyWith(
        color: isDark ? Colors.white70 : Colors.black87,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: AppTypography.textTheme.bodyMedium?.copyWith(
        color: isDark ? Colors.white38 : Colors.black38,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
    );

    return GlassCard(
      child: Padding(
        padding: EdgeInsets.all(40.r),
        child: Theme(
          data: Theme.of(context).copyWith(
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: AppColors.primary,
              selectionColor: AppColors.primary.withValues(alpha: 0.3),
              selectionHandleColor: AppColors.primary,
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  enabled: !isSending,
                  style: inputStyle,
                  cursorColor: AppColors.primary,
                  decoration: inputDecoration.copyWith(
                    labelText: 'Name',
                    hintText: 'Ali Ahmed',
                  ),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Please enter your name'
                      : null,
                ),
                SizedBox(height: 24.h),
                TextFormField(
                  controller: _emailController,
                  enabled: !isSending,
                  style: inputStyle,
                  cursorColor: AppColors.primary,
                  keyboardType: TextInputType.emailAddress,
                  decoration: inputDecoration.copyWith(
                    labelText: 'Email',
                    hintText: 'ali@example.com',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please Enter Your Email';
                    }
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please Enter a Valid Email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24.h),
                TextFormField(
                  controller: _phoneController,
                  enabled: !isSending,
                  style: inputStyle,
                  cursorColor: AppColors.primary,
                  keyboardType: TextInputType.phone,
                  decoration: inputDecoration.copyWith(
                    labelText: 'Phone (Optional)',
                    hintText: '+20 234 567 890',
                  ),
                ),
                SizedBox(height: 24.h),
                TextFormField(
                  controller: _messageController,
                  enabled: !isSending,
                  style: inputStyle,
                  cursorColor: AppColors.primary,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  decoration: inputDecoration.copyWith(
                    labelText: 'Message',
                    hintText: 'Tell me about your project...',
                  ),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Please enter a message'
                      : null,
                ),
                SizedBox(height: 32.h),
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: isSending ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: isSending
                        ? SizedBox(
                            height: 24.r,
                            width: 24.r,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : Text(
                            'Send Message',
                            style: AppTypography.textTheme.labelLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ContactInfoCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final String destination;

  const ContactInfoCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.destination,
  });

  @override
  State<ContactInfoCard> createState() => _ContactInfoCardState();
}

class _ContactInfoCardState extends State<ContactInfoCard> {
  bool _isHovered = false;
  bool _isFocused = false;

  Future<void> _launchUrl() async {
    final uri = Uri.parse(widget.destination);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final isHoveredOrFocused = _isHovered || _isFocused;

    return Semantics(
      button: true,
      label: 'Open ${widget.label}',
      child: Tooltip(
        message: 'Open ${widget.label}',
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: Focus(
            onFocusChange: (hasFocus) => setState(() => _isFocused = hasFocus),
            child: AnimatedScale(
              scale: isHoveredOrFocused ? 1.02 : 1.0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isHoveredOrFocused
                        ? AppColors.primary.withValues(alpha: 0.5)
                        : Colors.transparent,
                    width: 1.5,
                  ),
                  boxShadow: [
                    if (isHoveredOrFocused)
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.15),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                  ],
                ),
                child: GlassCard(
                  padding: EdgeInsets.all(24.r),
                  onTap: _launchUrl,
                  child: Row(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOutCubic,
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: isHoveredOrFocused
                              ? AppColors.primary
                              : AppColors.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          widget.icon,
                          color: isHoveredOrFocused
                              ? Colors.white
                              : AppColors.primary,
                          size: 24.sp,
                        ),
                      ),
                      SizedBox(width: 24.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.label,
                              style: AppTypography.textTheme.bodyMedium
                                  ?.copyWith(
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.black54,
                                  ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              widget.value,
                              style: AppTypography.textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
