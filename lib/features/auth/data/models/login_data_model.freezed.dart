// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginDataModel {

 String? get accessToken; String? get refreshToken; int? get userId; String? get username; String? get email; String? get userPhoto; String? get role; String? get useFullName; String? get hash; String? get address; double? get latitude; double? get longitude; bool? get newUser;
/// Create a copy of LoginDataModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginDataModelCopyWith<LoginDataModel> get copyWith => _$LoginDataModelCopyWithImpl<LoginDataModel>(this as LoginDataModel, _$identity);

  /// Serializes this LoginDataModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginDataModel&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.email, email) || other.email == email)&&(identical(other.userPhoto, userPhoto) || other.userPhoto == userPhoto)&&(identical(other.role, role) || other.role == role)&&(identical(other.useFullName, useFullName) || other.useFullName == useFullName)&&(identical(other.hash, hash) || other.hash == hash)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.newUser, newUser) || other.newUser == newUser));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,refreshToken,userId,username,email,userPhoto,role,useFullName,hash,address,latitude,longitude,newUser);

@override
String toString() {
  return 'LoginDataModel(accessToken: $accessToken, refreshToken: $refreshToken, userId: $userId, username: $username, email: $email, userPhoto: $userPhoto, role: $role, useFullName: $useFullName, hash: $hash, address: $address, latitude: $latitude, longitude: $longitude, newUser: $newUser)';
}


}

/// @nodoc
abstract mixin class $LoginDataModelCopyWith<$Res>  {
  factory $LoginDataModelCopyWith(LoginDataModel value, $Res Function(LoginDataModel) _then) = _$LoginDataModelCopyWithImpl;
@useResult
$Res call({
 String? accessToken, String? refreshToken, int? userId, String? username, String? email, String? userPhoto, String? role, String? useFullName, String? hash, String? address, double? latitude, double? longitude, bool? newUser
});




}
/// @nodoc
class _$LoginDataModelCopyWithImpl<$Res>
    implements $LoginDataModelCopyWith<$Res> {
  _$LoginDataModelCopyWithImpl(this._self, this._then);

  final LoginDataModel _self;
  final $Res Function(LoginDataModel) _then;

/// Create a copy of LoginDataModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = freezed,Object? refreshToken = freezed,Object? userId = freezed,Object? username = freezed,Object? email = freezed,Object? userPhoto = freezed,Object? role = freezed,Object? useFullName = freezed,Object? hash = freezed,Object? address = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? newUser = freezed,}) {
  return _then(_self.copyWith(
accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,userPhoto: freezed == userPhoto ? _self.userPhoto : userPhoto // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,useFullName: freezed == useFullName ? _self.useFullName : useFullName // ignore: cast_nullable_to_non_nullable
as String?,hash: freezed == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,newUser: freezed == newUser ? _self.newUser : newUser // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _LoginDataModel implements LoginDataModel {
  const _LoginDataModel({this.accessToken, this.refreshToken, this.userId, this.username, this.email, this.userPhoto, this.role, this.useFullName, this.hash, this.address, this.latitude, this.longitude, this.newUser});
  factory _LoginDataModel.fromJson(Map<String, dynamic> json) => _$LoginDataModelFromJson(json);

@override final  String? accessToken;
@override final  String? refreshToken;
@override final  int? userId;
@override final  String? username;
@override final  String? email;
@override final  String? userPhoto;
@override final  String? role;
@override final  String? useFullName;
@override final  String? hash;
@override final  String? address;
@override final  double? latitude;
@override final  double? longitude;
@override final  bool? newUser;

/// Create a copy of LoginDataModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginDataModelCopyWith<_LoginDataModel> get copyWith => __$LoginDataModelCopyWithImpl<_LoginDataModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginDataModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginDataModel&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.email, email) || other.email == email)&&(identical(other.userPhoto, userPhoto) || other.userPhoto == userPhoto)&&(identical(other.role, role) || other.role == role)&&(identical(other.useFullName, useFullName) || other.useFullName == useFullName)&&(identical(other.hash, hash) || other.hash == hash)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.newUser, newUser) || other.newUser == newUser));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,refreshToken,userId,username,email,userPhoto,role,useFullName,hash,address,latitude,longitude,newUser);

@override
String toString() {
  return 'LoginDataModel(accessToken: $accessToken, refreshToken: $refreshToken, userId: $userId, username: $username, email: $email, userPhoto: $userPhoto, role: $role, useFullName: $useFullName, hash: $hash, address: $address, latitude: $latitude, longitude: $longitude, newUser: $newUser)';
}


}

/// @nodoc
abstract mixin class _$LoginDataModelCopyWith<$Res> implements $LoginDataModelCopyWith<$Res> {
  factory _$LoginDataModelCopyWith(_LoginDataModel value, $Res Function(_LoginDataModel) _then) = __$LoginDataModelCopyWithImpl;
@override @useResult
$Res call({
 String? accessToken, String? refreshToken, int? userId, String? username, String? email, String? userPhoto, String? role, String? useFullName, String? hash, String? address, double? latitude, double? longitude, bool? newUser
});




}
/// @nodoc
class __$LoginDataModelCopyWithImpl<$Res>
    implements _$LoginDataModelCopyWith<$Res> {
  __$LoginDataModelCopyWithImpl(this._self, this._then);

  final _LoginDataModel _self;
  final $Res Function(_LoginDataModel) _then;

/// Create a copy of LoginDataModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = freezed,Object? refreshToken = freezed,Object? userId = freezed,Object? username = freezed,Object? email = freezed,Object? userPhoto = freezed,Object? role = freezed,Object? useFullName = freezed,Object? hash = freezed,Object? address = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? newUser = freezed,}) {
  return _then(_LoginDataModel(
accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,userPhoto: freezed == userPhoto ? _self.userPhoto : userPhoto // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,useFullName: freezed == useFullName ? _self.useFullName : useFullName // ignore: cast_nullable_to_non_nullable
as String?,hash: freezed == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,newUser: freezed == newUser ? _self.newUser : newUser // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
