// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginDataModel _$LoginDataModelFromJson(Map<String, dynamic> json) =>
    _LoginDataModel(
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      userId: (json['userId'] as num?)?.toInt(),
      username: json['username'] as String?,
      email: json['email'] as String?,
      userPhoto: json['userPhoto'] as String?,
      role: json['role'] as String?,
      useFullName: json['useFullName'] as String?,
      hash: json['hash'] as String?,
      address: json['address'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      newUser: json['newUser'] as bool?,
    );

Map<String, dynamic> _$LoginDataModelToJson(_LoginDataModel instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'userId': instance.userId,
      'username': instance.username,
      'email': instance.email,
      'userPhoto': instance.userPhoto,
      'role': instance.role,
      'useFullName': instance.useFullName,
      'hash': instance.hash,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'newUser': instance.newUser,
    };
