import 'package:firebase_auth/firebase_auth.dart';

import '../../../bootstrap/providers.dart';
import '../../../core/services/service.dart';

class AuthService extends Service {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthService(super.ref);

  Future<bool> checkIfAuthenticated() async {
    final user = _firebaseAuth.currentUser;
    return user != null;
  }

  Future<void> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } catch (e, stackTrace) {
      final String message = ref.read(errorHandlerProvider).map(e, stackTrace);
      ref.read(globalErrorProvider.notifier).show(message, e);
    }
  }

  Future<void> register({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
    } catch (e, stackTrace) {
      final String message = ref.read(errorHandlerProvider).map(e, stackTrace);
      ref.read(globalErrorProvider.notifier).show(message, e);
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
