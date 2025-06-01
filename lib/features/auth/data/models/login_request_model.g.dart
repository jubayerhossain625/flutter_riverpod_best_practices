// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginRequestModel _$LoginRequestModelFromJson(Map<String, dynamic> json) =>
    _LoginRequestModel(
      phone: json['phone'] as String,
      otp: json['otp'] as String?,
      hash: json['hash'] as String?,
    );

Map<String, dynamic> _$LoginRequestModelToJson(_LoginRequestModel instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'otp': instance.otp,
      'hash': instance.hash,
    };
