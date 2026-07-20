import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/contact_request.dart';

import '../../data/repositories/contact_repository_impl.dart';
import '../../domain/repositories/contact_repository.dart';

enum ContactFormStatus { idle, sending, success, error }

class ContactFormState {
  final ContactFormStatus status;
  final String? message;

  const ContactFormState({
    this.status = ContactFormStatus.idle,
    this.message,
  });

  ContactFormState copyWith({
    ContactFormStatus? status,
    String? message,
  }) => ContactFormState(
    status: status ?? this.status,
    message: message ?? this.message,
  );

  bool get isIdle => status == ContactFormStatus.idle;
  bool get isSending => status == ContactFormStatus.sending;
  bool get isSuccess => status == ContactFormStatus.success;
  bool get isError => status == ContactFormStatus.error;
}

class ContactFormNotifier extends StateNotifier<ContactFormState> {
  final ContactRepository _repository;

  ContactFormNotifier(this._repository) : super(const ContactFormState());

  Future<void> submit({
    required String name,
    required String email,
    String? phone,
    required String message,
  }) async {
    state = state.copyWith(status: ContactFormStatus.sending, message: null);

    final request = ContactRequest(
      name: name.trim(),
      email: email.trim(),
      phone: phone?.trim(),
      message: message.trim(),
    );

    final response = await _repository.submitContactForm(request);

    if (response.success) {
      state = state.copyWith(
        status: ContactFormStatus.success,
        message: response.message,
      );
    } else {
      state = state.copyWith(
        status: ContactFormStatus.error,
        message: response.message,
      );
    }
  }

  void reset() {
    state = const ContactFormState();
  }
}

final contactRepositoryProvider = Provider<ContactRepository>((ref) {
  return const ContactRepositoryImpl();
});

final contactFormProvider =
    StateNotifierProvider<ContactFormNotifier, ContactFormState>((ref) {
  final repository = ref.watch(contactRepositoryProvider);
  return ContactFormNotifier(repository);
});
