// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_req_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SignUpReqModel _$SignUpReqModelFromJson(Map<String, dynamic> json) =>
    _SignUpReqModel(
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$SignUpReqModelToJson(_SignUpReqModel instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
