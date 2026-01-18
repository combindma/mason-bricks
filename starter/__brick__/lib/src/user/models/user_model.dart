import 'user.dart';

class UserModel extends User {
  const UserModel({required super.id, required super.name, required super.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id'] as String, name: json['name'] as String, email: json['email'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'name': super.name,
      'email': super.email,
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
}) {
    return UserModel(id: id?? super.id, name: name?? super.name, email: email?? super.email);
  }
}
