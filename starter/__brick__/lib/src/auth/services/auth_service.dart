import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseStore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<bool> checkIfAuthenticated() async {
    final user = _firebaseAuth.currentUser;
    return user != null;
  }

  Future<UserCredential> signInWithEmailAndPassword({required String email, required String password}) async {
    return await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> signInWithGoogle() async {
    await _googleSignIn.initialize();
    final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;
    final credential = GoogleAuthProvider.credential(idToken: googleAuth.idToken);
    final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
    final User? user = userCredential.user;
    if (user != null) {
      _createUser(user, user.displayName, 'google');
    }

    return userCredential;
  }

  Future<UserCredential> register({required String name, required String email, required String password}) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    await _createUser(userCredential.user!, name, 'email');
    return userCredential;
  }

  Future<void> _createUser(User user, String? name, String provider) async {
    final userDoc = _firebaseStore.collection('users').doc(user.uid);
    final docSnapshot = await userDoc.get();
    if (!docSnapshot.exists) {
      await userDoc.set({
        'uid': user.uid,
        'name': name,
        'email': user.email,
        'photoURL': user.photoURL,
        'provider': provider,
        'created_at': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
