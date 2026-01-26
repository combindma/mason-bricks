import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../user/models/user_model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseStore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<bool> checkIfAuthenticated() async {
    final user = _firebaseAuth.currentUser;
    return user != null;
  }

  User? getCurrentUserData() {
    return _firebaseAuth.currentUser;
  }

  Future<UserCredential> signInWithEmailAndPassword({required String email, required String password}) async {
    return await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> signInWithGoogle({bool isReauthenticate = false}) async {
    await _googleSignIn.initialize();
    final googleUser = await _googleSignIn.authenticate();
    final googleAuth = googleUser.authentication;
    final credential = GoogleAuthProvider.credential(idToken: googleAuth.idToken);
    if (isReauthenticate) {
      return await _firebaseAuth.currentUser!.reauthenticateWithCredential(credential);
    }
    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    final user = userCredential.user;
    if (user != null) {
      _createUser(user: user, name: user.displayName, provider: 'google');
    }

    return userCredential;
  }

  Future<UserCredential> signInWithApple({bool isReauthenticate = false}) async {
    final rawNonce = _generateNonce();
    final sha256Nonce = sha256.convert(utf8.encode(rawNonce)).toString();

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: sha256Nonce,
    );
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    if (isReauthenticate) {
      return await _firebaseAuth.currentUser!.reauthenticateWithCredential(oauthCredential);
    }

    final userCredential = await _firebaseAuth.signInWithCredential(oauthCredential);
    final user = userCredential.user;
    if (user != null) {
      String displayName = '';
      if (appleCredential.givenName != null) {
        displayName = '${appleCredential.givenName} ${appleCredential.familyName ?? ''}'.trim();
      }
      _createUser(user: user, name: displayName, provider: 'apple');
    }

    return userCredential;
  }

  Future<void> register({required String name, required String email, required String password}) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    final user = userCredential.user;
    if(user != null) {
      await user.updateDisplayName(name);
      await _createUser(user: user, name: name, provider: 'email');
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> deleteAccount({String? password}) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return;
    final userDoc = await _firebaseStore.collection('users').doc(user.uid).get();
    final provider = userDoc.data()?['provider'] as String?;
    //Re-authenticate based on provider
    await _reauthenticate(user: user, provider: provider, password: password);
    //Delete Firestore document first (while still authenticated)
    await _firebaseStore.collection('users').doc(user.uid).delete();
    //Delete Firebase Auth account last
    await user.delete();
  }

  Future<void> _createUser({required User user, String? name, required String provider}) async {
    final userDoc = _firebaseStore.collection('users').doc(user.uid);
    final docSnapshot = await userDoc.get();
    if (!docSnapshot.exists) {
      final newUser = UserModel(
        id: user.uid,
        email: user.email ?? '',
        name: name,
        photoUrl: user.photoURL,
        provider: provider,
        createdAt: null,
      );
      final json = newUser.toJson();
      json['createdAt'] = FieldValue.serverTimestamp();
      await userDoc.set(json);
    }
  }

  Future<void> _reauthenticateWithEmail({required User user, required String password}) async {
    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: password,
    );
    await user.reauthenticateWithCredential(credential);
  }

  Future<void> _reauthenticate({
    required User user,
    required String? provider,
    String? password,
  }) async {
    switch (provider) {
      case 'google':
        await signInWithGoogle(isReauthenticate: true);
      case 'apple':
        await signInWithApple(isReauthenticate: true);
      case 'email':
        if (password == null) throw Exception('Password required for email provider');
        await _reauthenticateWithEmail(user: user, password: password);
      default:
        throw Exception();
    }
  }

  // Helper function to generate random string for Apple Sign In
  String _generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }
}
