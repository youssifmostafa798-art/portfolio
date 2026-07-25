import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/core/extensions/context_extensions.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/widgets/glass_card.dart';
import 'package:portfolio/core/widgets/section_label.dart';
import 'package:portfolio/core/constants/app_constants.dart';
import 'package:portfolio/core/widgets/app_feedback_dialog.dart';
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
        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _messageController.clear();
        ref.read(contactFormProvider.notifier).reset();
        AppFeedbackDialog.show(
          context: context,
          isSuccess: true,
          title: 'Message Sent!',
          message: next.message ?? 'Message sent successfully!',
        );
      } else if (next.isError) {
        AppFeedbackDialog.show(
          context: context,
          isSuccess: false,
          title: 'Oops!',
          message: next.message ?? 'Failed to send message.',
        );
      }
    });

    final formState = ref.watch(contactFormProvider);
    final isSending = formState.isSending;
    final isDark = context.isDark;
    final isMobile = context.isMobile;
    final sectionVertical = context.responsiveSectionVertical;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsivePadding,
        vertical: sectionVertical,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionLabel(
            label: 'Get In Touch',
            subtitle:
                'Have a project in mind or want to discuss opportunities? I\'d love to hear from you.',
          ),
          SizedBox(height: isMobile ? 32 : 60),
          if (context.isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _buildContactInfo(isDark, isMobile)),
                SizedBox(width: 80),
                Expanded(flex: 3, child: _buildForm(isSending, isDark, isMobile)),
              ],
            )
          else
            Column(
              children: [
                _buildContactInfo(isDark, isMobile),
                SizedBox(height: isMobile ? 24 : 40),
                _buildForm(isSending, isDark, isMobile),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(bool isDark, bool isMobile) {
    return Column(
      children: [
        ContactInfoCard(
          icon: Icons.email_outlined,
          label: 'Email',
          value: 'youssifmostafa798@gmail.com',
          destination: 'mailto:youssifmostafa798@gmail.com',
          isMobile: isMobile,
        ),
        SizedBox(height: isMobile ? 12 : 16),
        ContactInfoCard(
          icon: Icons.code,
          label: 'GitHub',
          value: AppConstants.github,
          destination: AppConstants.github,
          isMobile: isMobile,
        ),
        SizedBox(height: isMobile ? 12 : 16),
        ContactInfoCard(
          icon: Icons.work_outline,
          label: 'LinkedIn',
          value: AppConstants.linkedin,
          destination: AppConstants.linkedin,
          isMobile: isMobile,
        ),
      ],
    );
  }

  Widget _buildForm(bool isSending, bool isDark, bool isMobile) {
    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: isDark
          ? Colors.white.withValues(alpha: 0.05)
          : Colors.black.withValues(alpha: 0.03),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error, width: 1),
      ),
      labelStyle: TextStyle(
        fontSize: isMobile ? 14 : 15,
        color: isDark ? Colors.white70 : Colors.black87,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: TextStyle(
        fontSize: isMobile ? 14 : 15,
        color: isDark ? Colors.white38 : Colors.black38,
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: isMobile ? 14 : 16,
        vertical: isMobile ? 16 : 14,
      ),
    );

    final inputStyle = TextStyle(
      fontSize: isMobile ? 15 : 16,
      color: isDark ? Colors.white : Colors.black87,
    );

    return GlassCard(
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 24 : 40),
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
                SizedBox(height: isMobile ? 16 : 24),
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
                SizedBox(height: isMobile ? 16 : 24),
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
                SizedBox(height: isMobile ? 16 : 24),
                TextFormField(
                  controller: _messageController,
                  enabled: !isSending,
                  style: inputStyle,
                  cursorColor: AppColors.primary,
                  keyboardType: TextInputType.multiline,
                  maxLines: isMobile ? 4 : 5,
                  decoration: inputDecoration.copyWith(
                    labelText: 'Message',
                    hintText: 'Tell me about your project...',
                  ),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Please enter a message'
                      : null,
                ),
                SizedBox(height: isMobile ? 20 : 32),
                SizedBox(
                  width: double.infinity,
                  height: context.responsiveButtonMinHeight,
                  child: ElevatedButton(
                    onPressed: isSending ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: isSending
                        ? SizedBox(
                            height: 24,
                            width: 24,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : Text(
                            'Send Message',
                            style: TextStyle(
                              fontSize: 15,
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
  final bool isMobile;

  const ContactInfoCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.destination,
    required this.isMobile,
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
    final iconContainerSize = widget.isMobile ? 44.0 : 48.0;
    final iconSize = widget.isMobile ? 20.0 : 24.0;
    final cardPadding = widget.isMobile ? 16.0 : 24.0;

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
                  borderRadius: BorderRadius.circular(context.responsiveBorderRadius),
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
                  padding: EdgeInsets.all(cardPadding),
                  onTap: _launchUrl,
                  child: Row(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOutCubic,
                        width: iconContainerSize,
                        height: iconContainerSize,
                        padding: const EdgeInsets.all(12),
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
                          size: iconSize,
                        ),
                      ),
                      SizedBox(width: widget.isMobile ? 16 : 24),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.label,
                              style: TextStyle(
                                fontSize: widget.isMobile ? 12 : 14,
                                color: isDark ? Colors.white70 : Colors.black54,
                              ),
                            ),
                            SizedBox(height: widget.isMobile ? 2 : 4),
                            Text(
                              widget.value,
                              style: TextStyle(
                                fontSize: widget.isMobile ? 13 : 16,
                                fontWeight: FontWeight.w600,
                              ),
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
