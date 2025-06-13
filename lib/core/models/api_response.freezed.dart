// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ApiResponse<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(String message, String? type) error,
    required TResult Function() noContent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? success,
    TResult? Function(String message, String? type)? error,
    TResult? Function()? noContent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(String message, String? type)? error,
    TResult Function()? noContent,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApiResponseSuccess<T> value) success,
    required TResult Function(ApiResponseError<T> value) error,
    required TResult Function(ApiResponseNoContent<T> value) noContent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApiResponseSuccess<T> value)? success,
    TResult? Function(ApiResponseError<T> value)? error,
    TResult? Function(ApiResponseNoContent<T> value)? noContent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApiResponseSuccess<T> value)? success,
    TResult Function(ApiResponseError<T> value)? error,
    TResult Function(ApiResponseNoContent<T> value)? noContent,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiResponseCopyWith<T, $Res> {
  factory $ApiResponseCopyWith(
          ApiResponse<T> value, $Res Function(ApiResponse<T>) then) =
      _$ApiResponseCopyWithImpl<T, $Res, ApiResponse<T>>;
}

/// @nodoc
class _$ApiResponseCopyWithImpl<T, $Res, $Val extends ApiResponse<T>>
    implements $ApiResponseCopyWith<T, $Res> {
  _$ApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ApiResponseSuccessImplCopyWith<T, $Res> {
  factory _$$ApiResponseSuccessImplCopyWith(_$ApiResponseSuccessImpl<T> value,
          $Res Function(_$ApiResponseSuccessImpl<T>) then) =
      __$$ApiResponseSuccessImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data});
}

/// @nodoc
class __$$ApiResponseSuccessImplCopyWithImpl<T, $Res>
    extends _$ApiResponseCopyWithImpl<T, $Res, _$ApiResponseSuccessImpl<T>>
    implements _$$ApiResponseSuccessImplCopyWith<T, $Res> {
  __$$ApiResponseSuccessImplCopyWithImpl(_$ApiResponseSuccessImpl<T> _value,
      $Res Function(_$ApiResponseSuccessImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$ApiResponseSuccessImpl<T>(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$ApiResponseSuccessImpl<T> implements ApiResponseSuccess<T> {
  const _$ApiResponseSuccessImpl(this.data);

  @override
  final T data;

  @override
  String toString() {
    return 'ApiResponse<$T>.success(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiResponseSuccessImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiResponseSuccessImplCopyWith<T, _$ApiResponseSuccessImpl<T>>
      get copyWith => __$$ApiResponseSuccessImplCopyWithImpl<T,
          _$ApiResponseSuccessImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(String message, String? type) error,
    required TResult Function() noContent,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? success,
    TResult? Function(String message, String? type)? error,
    TResult? Function()? noContent,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(String message, String? type)? error,
    TResult Function()? noContent,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApiResponseSuccess<T> value) success,
    required TResult Function(ApiResponseError<T> value) error,
    required TResult Function(ApiResponseNoContent<T> value) noContent,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApiResponseSuccess<T> value)? success,
    TResult? Function(ApiResponseError<T> value)? error,
    TResult? Function(ApiResponseNoContent<T> value)? noContent,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApiResponseSuccess<T> value)? success,
    TResult Function(ApiResponseError<T> value)? error,
    TResult Function(ApiResponseNoContent<T> value)? noContent,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class ApiResponseSuccess<T> implements ApiResponse<T> {
  const factory ApiResponseSuccess(final T data) = _$ApiResponseSuccessImpl<T>;

  T get data;
  @JsonKey(ignore: true)
  _$$ApiResponseSuccessImplCopyWith<T, _$ApiResponseSuccessImpl<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ApiResponseErrorImplCopyWith<T, $Res> {
  factory _$$ApiResponseErrorImplCopyWith(_$ApiResponseErrorImpl<T> value,
          $Res Function(_$ApiResponseErrorImpl<T>) then) =
      __$$ApiResponseErrorImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String message, String? type});
}

/// @nodoc
class __$$ApiResponseErrorImplCopyWithImpl<T, $Res>
    extends _$ApiResponseCopyWithImpl<T, $Res, _$ApiResponseErrorImpl<T>>
    implements _$$ApiResponseErrorImplCopyWith<T, $Res> {
  __$$ApiResponseErrorImplCopyWithImpl(_$ApiResponseErrorImpl<T> _value,
      $Res Function(_$ApiResponseErrorImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? type = freezed,
  }) {
    return _then(_$ApiResponseErrorImpl<T>(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ApiResponseErrorImpl<T> implements ApiResponseError<T> {
  const _$ApiResponseErrorImpl(this.message, {this.type});

  @override
  final String message;
  @override
  final String? type;

  @override
  String toString() {
    return 'ApiResponse<$T>.error(message: $message, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiResponseErrorImpl<T> &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiResponseErrorImplCopyWith<T, _$ApiResponseErrorImpl<T>> get copyWith =>
      __$$ApiResponseErrorImplCopyWithImpl<T, _$ApiResponseErrorImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(String message, String? type) error,
    required TResult Function() noContent,
  }) {
    return error(message, type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? success,
    TResult? Function(String message, String? type)? error,
    TResult? Function()? noContent,
  }) {
    return error?.call(message, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(String message, String? type)? error,
    TResult Function()? noContent,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApiResponseSuccess<T> value) success,
    required TResult Function(ApiResponseError<T> value) error,
    required TResult Function(ApiResponseNoContent<T> value) noContent,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApiResponseSuccess<T> value)? success,
    TResult? Function(ApiResponseError<T> value)? error,
    TResult? Function(ApiResponseNoContent<T> value)? noContent,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApiResponseSuccess<T> value)? success,
    TResult Function(ApiResponseError<T> value)? error,
    TResult Function(ApiResponseNoContent<T> value)? noContent,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ApiResponseError<T> implements ApiResponse<T> {
  const factory ApiResponseError(final String message, {final String? type}) =
      _$ApiResponseErrorImpl<T>;

  String get message;
  String? get type;
  @JsonKey(ignore: true)
  _$$ApiResponseErrorImplCopyWith<T, _$ApiResponseErrorImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ApiResponseNoContentImplCopyWith<T, $Res> {
  factory _$$ApiResponseNoContentImplCopyWith(
          _$ApiResponseNoContentImpl<T> value,
          $Res Function(_$ApiResponseNoContentImpl<T>) then) =
      __$$ApiResponseNoContentImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$ApiResponseNoContentImplCopyWithImpl<T, $Res>
    extends _$ApiResponseCopyWithImpl<T, $Res, _$ApiResponseNoContentImpl<T>>
    implements _$$ApiResponseNoContentImplCopyWith<T, $Res> {
  __$$ApiResponseNoContentImplCopyWithImpl(_$ApiResponseNoContentImpl<T> _value,
      $Res Function(_$ApiResponseNoContentImpl<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ApiResponseNoContentImpl<T> implements ApiResponseNoContent<T> {
  const _$ApiResponseNoContentImpl();

  @override
  String toString() {
    return 'ApiResponse<$T>.noContent()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiResponseNoContentImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(String message, String? type) error,
    required TResult Function() noContent,
  }) {
    return noContent();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? success,
    TResult? Function(String message, String? type)? error,
    TResult? Function()? noContent,
  }) {
    return noContent?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(String message, String? type)? error,
    TResult Function()? noContent,
    required TResult orElse(),
  }) {
    if (noContent != null) {
      return noContent();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApiResponseSuccess<T> value) success,
    required TResult Function(ApiResponseError<T> value) error,
    required TResult Function(ApiResponseNoContent<T> value) noContent,
  }) {
    return noContent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApiResponseSuccess<T> value)? success,
    TResult? Function(ApiResponseError<T> value)? error,
    TResult? Function(ApiResponseNoContent<T> value)? noContent,
  }) {
    return noContent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApiResponseSuccess<T> value)? success,
    TResult Function(ApiResponseError<T> value)? error,
    TResult Function(ApiResponseNoContent<T> value)? noContent,
    required TResult orElse(),
  }) {
    if (noContent != null) {
      return noContent(this);
    }
    return orElse();
  }
}

abstract class ApiResponseNoContent<T> implements ApiResponse<T> {
  const factory ApiResponseNoContent() = _$ApiResponseNoContentImpl<T>;
}
