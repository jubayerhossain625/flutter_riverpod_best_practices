import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_request_model.freezed.dart';
part 'login_request_model.g.dart';

@freezed
abstract class LoginRequestModel with _$LoginRequestModel {
  factory LoginRequestModel({
    required String phone,
    String? otp,
    String? hash,
  }) = _LoginRequestModel;

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) => _$LoginRequestModelFromJson(json);
}
