import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_data_model.freezed.dart';
part 'login_data_model.g.dart';

// @freezed
// abstract class LoginResponseModel with _$LoginResponseModel {
//   const factory LoginResponseModel({
//     LoginDataModel? data,
//     String? message,
//     String? errorMessage,
//   }) = _LoginResponseModel;

//   factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
//       _$LoginResponseModelFromJson(json);
// }

@freezed
abstract class LoginDataModel with _$LoginDataModel {
  const factory LoginDataModel({
    String? accessToken,
    String? refreshToken,
    int? userId,
    String? username,
    String? email,
    String? userPhoto,
    String? role,
    String? useFullName,
    String? hash,
    String? address,
    double? latitude,
    double? longitude,
    bool? newUser,
  }) = _LoginDataModel;

  factory LoginDataModel.fromJson(Map<String, dynamic> json) =>
      _$LoginDataModelFromJson(json);
}
