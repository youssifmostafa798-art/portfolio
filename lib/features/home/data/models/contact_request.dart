class ContactRequest {
  final String name;
  final String email;
  final String? phone;
  final String message;

  const ContactRequest({
    required this.name,
    required this.email,
    this.phone,
    required this.message,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    if (phone != null && phone!.isNotEmpty) 'phone': phone,
    'message': message,
  };
}
