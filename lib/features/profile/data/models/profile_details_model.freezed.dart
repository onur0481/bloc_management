// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_details_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProfileDetailsModel _$ProfileDetailsModelFromJson(Map<String, dynamic> json) {
  return _ProfileDetailsModel.fromJson(json);
}

/// @nodoc
mixin _$ProfileDetailsModel {
  String get address => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  String get bio => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProfileDetailsModelCopyWith<ProfileDetailsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileDetailsModelCopyWith<$Res> {
  factory $ProfileDetailsModelCopyWith(
          ProfileDetailsModel value, $Res Function(ProfileDetailsModel) then) =
      _$ProfileDetailsModelCopyWithImpl<$Res, ProfileDetailsModel>;
  @useResult
  $Res call({String address, String city, String country, String bio});
}

/// @nodoc
class _$ProfileDetailsModelCopyWithImpl<$Res, $Val extends ProfileDetailsModel>
    implements $ProfileDetailsModelCopyWith<$Res> {
  _$ProfileDetailsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? city = null,
    Object? country = null,
    Object? bio = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      bio: null == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileDetailsModelImplCopyWith<$Res>
    implements $ProfileDetailsModelCopyWith<$Res> {
  factory _$$ProfileDetailsModelImplCopyWith(_$ProfileDetailsModelImpl value,
          $Res Function(_$ProfileDetailsModelImpl) then) =
      __$$ProfileDetailsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String address, String city, String country, String bio});
}

/// @nodoc
class __$$ProfileDetailsModelImplCopyWithImpl<$Res>
    extends _$ProfileDetailsModelCopyWithImpl<$Res, _$ProfileDetailsModelImpl>
    implements _$$ProfileDetailsModelImplCopyWith<$Res> {
  __$$ProfileDetailsModelImplCopyWithImpl(_$ProfileDetailsModelImpl _value,
      $Res Function(_$ProfileDetailsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? city = null,
    Object? country = null,
    Object? bio = null,
  }) {
    return _then(_$ProfileDetailsModelImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      bio: null == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileDetailsModelImpl implements _ProfileDetailsModel {
  const _$ProfileDetailsModelImpl(
      {required this.address,
      required this.city,
      required this.country,
      required this.bio});

  factory _$ProfileDetailsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileDetailsModelImplFromJson(json);

  @override
  final String address;
  @override
  final String city;
  @override
  final String country;
  @override
  final String bio;

  @override
  String toString() {
    return 'ProfileDetailsModel(address: $address, city: $city, country: $country, bio: $bio)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileDetailsModelImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.bio, bio) || other.bio == bio));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, address, city, country, bio);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileDetailsModelImplCopyWith<_$ProfileDetailsModelImpl> get copyWith =>
      __$$ProfileDetailsModelImplCopyWithImpl<_$ProfileDetailsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileDetailsModelImplToJson(
      this,
    );
  }
}

abstract class _ProfileDetailsModel implements ProfileDetailsModel {
  const factory _ProfileDetailsModel(
      {required final String address,
      required final String city,
      required final String country,
      required final String bio}) = _$ProfileDetailsModelImpl;

  factory _ProfileDetailsModel.fromJson(Map<String, dynamic> json) =
      _$ProfileDetailsModelImpl.fromJson;

  @override
  String get address;
  @override
  String get city;
  @override
  String get country;
  @override
  String get bio;
  @override
  @JsonKey(ignore: true)
  _$$ProfileDetailsModelImplCopyWith<_$ProfileDetailsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
