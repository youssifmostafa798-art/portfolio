class ContactResponse {
  final bool success;
  final String message;

  const ContactResponse({
    required this.success,
    required this.message,
  });

  factory ContactResponse.fromJson(Map<String, dynamic> json) =>
      ContactResponse(
        success: json['success'] as bool? ?? false,
        message: json['message'] as String? ?? 'Unknown response.',
      );

  factory ContactResponse.networkError() => const ContactResponse(
    success: false,
    message: 'Unable to connect. Please check your internet and try again.',
  );

  factory ContactResponse.timeout() => const ContactResponse(
    success: false,
    message: 'The request timed out. Please try again.',
  );

  factory ContactResponse.unexpected() => const ContactResponse(
    success: false,
    message: 'An unexpected error occurred. Please try again later.',
  );
}
