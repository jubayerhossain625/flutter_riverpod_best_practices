// {
//   "fullName": "string",
//   "email": "string",
//   "phone": "string",
//   "password": "string",
//   "userPhoto": "string",
//   "role": "string",
//   "address": "string",
//   "latitude": 0,
//   "longitude": 0
// }

import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_req_model.freezed.dart';
part 'sign_up_req_model.g.dart';

@freezed
abstract class SignUpReqModel with _$SignUpReqModel {
  factory SignUpReqModel({
    required String fullName,
    required String email,
    required String phone,
    required String address,
    required double latitude,
    required double longitude,
  }) = _SignUpReqModel;

  factory SignUpReqModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpReqModelFromJson(json);
}
