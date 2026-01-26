import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'base_exception.dart';

class FirebaseExceptionHandler implements BaseException {
  @override
  String handleError(error, [StackTrace? stackTrace]) {
    if (error is FirebaseAuthException) {
      final message = _handleFirebaseAuthException(error);
      return message;
    } else if (error is FirebaseException) {
      final message = _handleFirebaseException(error);
      return message;
    }
    return 'errors.unknown'.tr();
  }

  String _handleFirebaseAuthException(FirebaseAuthException error) {
    switch (error.code) {
    // Login errors
      case 'user-not-found':
        return 'errors.auth.user_not_found'.tr();
      case 'wrong-password':
        return 'errors.auth.wrong_password'.tr();
      case 'invalid-credential':
        return 'errors.auth.invalid_credential'.tr();
      case 'invalid-email':
        return 'errors.auth.invalid_email'.tr();
      case 'user-disabled':
        return 'errors.auth.user_disabled'.tr();

    // Registration errors
      case 'email-already-in-use':
        return 'errors.auth.email_in_use'.tr();
      case 'weak-password':
        return 'errors.auth.weak_password'.tr();
      case 'operation-not-allowed':
        return 'errors.auth.operation_not_allowed'.tr();

    // Rate limiting / security
      case 'too-many-requests':
        return 'errors.auth.too_many_requests'.tr();
      case 'network-request-failed':
        return 'errors.auth.network_error'.tr();

    // Token / session errors
      case 'expired-action-code':
        return 'errors.auth.expired_code'.tr();
      case 'invalid-action-code':
        return 'errors.auth.invalid_code'.tr();
      case 'session-expired':
        return 'errors.auth.session_expired'.tr();

    // Account linking
      case 'account-exists-with-different-credential':
        return 'errors.auth.account_exists_different_credential'.tr();
      case 'credential-already-in-use':
        return 'errors.auth.credential_in_use'.tr();

    // Reauthentication
      case 'requires-recent-login':
        return 'errors.auth.requires_recent_login'.tr();

      default:
        return 'errors.auth.generic'.tr();
    }
  }

  String _handleFirebaseException(FirebaseException error) {
    switch (error.code) {
      case 'permission-denied':
        return 'errors.firebase.permission_denied'.tr();
      case 'unavailable':
        return 'errors.firebase.unavailable'.tr();
      case 'cancelled':
        return 'errors.firebase.cancelled'.tr();
      case 'not-found':
        return 'errors.firebase.not_found'.tr();
      default:
        return 'errors.firebase.generic'.tr();
    }
  }
}