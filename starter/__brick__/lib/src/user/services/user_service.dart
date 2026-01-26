import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/services/service.dart';
import '../models/user_model.dart';

class UserService extends Service {
  UserService(super.ref);

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseStore = FirebaseFirestore.instance;

  Future<UserModel?> currentUser() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;

    final doc = await _firebaseStore.collection('users').doc(user.uid).get();

    if (!doc.exists || doc.data() == null) return null;

    final data = Map<String, dynamic>.from(doc.data()!);
    data['id'] = doc.id;

    return UserModel.fromJson(data);
  }

  Future<void> updateProfile({
    required String name,
    String? phone,
    String? address,
    String? city,
    String? zipCode,
    String? country,
}) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return;

    final updates = <String, dynamic>{
      'name': name,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (city != null) 'city': city,
      if (zipCode != null) 'zipCode': zipCode,
      if (country != null) 'country': country,
    };

    await Future.wait([
      _firebaseStore.collection('users').doc(user.uid).update(updates),
      user.updateDisplayName(name),
    ]);
  }
}
