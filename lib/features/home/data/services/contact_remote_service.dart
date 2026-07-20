import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/services/supabase_service.dart';
import '../models/contact_request.dart';
import '../models/contact_response.dart';

class ContactRemoteService {
  const ContactRemoteService();

  Future<ContactResponse> sendMessage(ContactRequest request) async {
    try {
      final response = await SupabaseService.client.functions
          .invoke(
            'contact',
            body: request.toJson(),
          )
          .timeout(const Duration(seconds: 15));

      final data = response.data as Map<String, dynamic>?;

      if (data != null) {
        return ContactResponse.fromJson(data);
      }

      return ContactResponse.unexpected();
    } on FunctionException catch (e) {
      debugPrint('[ContactRemoteService] FunctionException: ${e.status}');
      if (e.details is Map<String, dynamic>) {
        return ContactResponse.fromJson(e.details as Map<String, dynamic>);
      }
      return ContactResponse(
        success: false,
        message: 'Server error (${e.status}). Please try again.',
      );
    } on TimeoutException {
      debugPrint('[ContactRemoteService] Request timed out');
      return ContactResponse.timeout();
    } catch (e) {
      debugPrint('[ContactRemoteService] Unexpected error: $e');
      return ContactResponse.networkError();
    }
  }
}
