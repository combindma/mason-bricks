// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: json['id'] as String,
  name: json['name'] as String?,
  email: json['email'] as String,
  phone: json['phone'] as String?,
  address: json['address'] as String?,
  city: json['city'] as String?,
  zipCode: json['zipCode'] as String?,
  country: json['country'] as String?,
  photoUrl: json['photoUrl'] as String?,
  provider: json['provider'] as String? ?? 'email',
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'city': instance.city,
      'zipCode': instance.zipCode,
      'country': instance.country,
      'photoUrl': instance.photoUrl,
      'provider': instance.provider,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
