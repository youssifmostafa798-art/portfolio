import '../../domain/repositories/contact_repository.dart';
import '../models/contact_request.dart';
import '../models/contact_response.dart';
import '../services/contact_remote_service.dart';

class ContactRepositoryImpl implements ContactRepository {
  final ContactRemoteService _remoteService;

  const ContactRepositoryImpl({ContactRemoteService? remoteService})
      : _remoteService = remoteService ?? const ContactRemoteService();

  @override
  Future<ContactResponse> submitContactForm(ContactRequest request) {
    return _remoteService.sendMessage(request);
  }
}
