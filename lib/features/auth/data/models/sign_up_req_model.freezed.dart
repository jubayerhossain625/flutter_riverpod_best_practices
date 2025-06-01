// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_req_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignUpReqModel {

 String get fullName; String get email; String get phone; String get address; double get latitude; double get longitude;
/// Create a copy of SignUpReqModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignUpReqModelCopyWith<SignUpReqModel> get copyWith => _$SignUpReqModelCopyWithImpl<SignUpReqModel>(this as SignUpReqModel, _$identity);

  /// Serializes this SignUpReqModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpReqModel&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,email,phone,address,latitude,longitude);

@override
String toString() {
  return 'SignUpReqModel(fullName: $fullName, email: $email, phone: $phone, address: $address, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $SignUpReqModelCopyWith<$Res>  {
  factory $SignUpReqModelCopyWith(SignUpReqModel value, $Res Function(SignUpReqModel) _then) = _$SignUpReqModelCopyWithImpl;
@useResult
$Res call({
 String fullName, String email, String phone, String address, double latitude, double longitude
});




}
/// @nodoc
class _$SignUpReqModelCopyWithImpl<$Res>
    implements $SignUpReqModelCopyWith<$Res> {
  _$SignUpReqModelCopyWithImpl(this._self, this._then);

  final SignUpReqModel _self;
  final $Res Function(SignUpReqModel) _then;

/// Create a copy of SignUpReqModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = null,Object? email = null,Object? phone = null,Object? address = null,Object? latitude = null,Object? longitude = null,}) {
  return _then(_self.copyWith(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SignUpReqModel implements SignUpReqModel {
   _SignUpReqModel({required this.fullName, required this.email, required this.phone, required this.address, required this.latitude, required this.longitude});
  factory _SignUpReqModel.fromJson(Map<String, dynamic> json) => _$SignUpReqModelFromJson(json);

@override final  String fullName;
@override final  String email;
@override final  String phone;
@override final  String address;
@override final  double latitude;
@override final  double longitude;

/// Create a copy of SignUpReqModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignUpReqModelCopyWith<_SignUpReqModel> get copyWith => __$SignUpReqModelCopyWithImpl<_SignUpReqModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignUpReqModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignUpReqModel&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,email,phone,address,latitude,longitude);

@override
String toString() {
  return 'SignUpReqModel(fullName: $fullName, email: $email, phone: $phone, address: $address, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$SignUpReqModelCopyWith<$Res> implements $SignUpReqModelCopyWith<$Res> {
  factory _$SignUpReqModelCopyWith(_SignUpReqModel value, $Res Function(_SignUpReqModel) _then) = __$SignUpReqModelCopyWithImpl;
@override @useResult
$Res call({
 String fullName, String email, String phone, String address, double latitude, double longitude
});




}
/// @nodoc
class __$SignUpReqModelCopyWithImpl<$Res>
    implements _$SignUpReqModelCopyWith<$Res> {
  __$SignUpReqModelCopyWithImpl(this._self, this._then);

  final _SignUpReqModel _self;
  final $Res Function(_SignUpReqModel) _then;

/// Create a copy of SignUpReqModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? email = null,Object? phone = null,Object? address = null,Object? latitude = null,Object? longitude = null,}) {
  return _then(_SignUpReqModel(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
