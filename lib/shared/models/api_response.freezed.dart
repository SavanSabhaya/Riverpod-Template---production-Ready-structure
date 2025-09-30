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

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'success':
      return ApiResponseSuccess.fromJson(json);
    case 'error':
      return ApiResponseError.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'ApiResponse',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$ApiResponse {
  int get statusCode => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic> data, int statusCode,
            String? message, Map<String, dynamic>? metadata)
        success,
    required TResult Function(String message, int statusCode, String? errorCode,
            Map<String, dynamic>? details)
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, dynamic> data, int statusCode,
            String? message, Map<String, dynamic>? metadata)?
        success,
    TResult? Function(String message, int statusCode, String? errorCode,
            Map<String, dynamic>? details)?
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, dynamic> data, int statusCode, String? message,
            Map<String, dynamic>? metadata)?
        success,
    TResult Function(String message, int statusCode, String? errorCode,
            Map<String, dynamic>? details)?
        error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApiResponseSuccess value) success,
    required TResult Function(ApiResponseError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApiResponseSuccess value)? success,
    TResult? Function(ApiResponseError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApiResponseSuccess value)? success,
    TResult Function(ApiResponseError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApiResponseCopyWith<ApiResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiResponseCopyWith<$Res> {
  factory $ApiResponseCopyWith(
          ApiResponse value, $Res Function(ApiResponse) then) =
      _$ApiResponseCopyWithImpl<$Res, ApiResponse>;
  @useResult
  $Res call({int statusCode, String message});
}

/// @nodoc
class _$ApiResponseCopyWithImpl<$Res, $Val extends ApiResponse>
    implements $ApiResponseCopyWith<$Res> {
  _$ApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message!
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApiResponseSuccessImplCopyWith<$Res>
    implements $ApiResponseCopyWith<$Res> {
  factory _$$ApiResponseSuccessImplCopyWith(_$ApiResponseSuccessImpl value,
          $Res Function(_$ApiResponseSuccessImpl) then) =
      __$$ApiResponseSuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, dynamic> data,
      int statusCode,
      String? message,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$ApiResponseSuccessImplCopyWithImpl<$Res>
    extends _$ApiResponseCopyWithImpl<$Res, _$ApiResponseSuccessImpl>
    implements _$$ApiResponseSuccessImplCopyWith<$Res> {
  __$$ApiResponseSuccessImplCopyWithImpl(_$ApiResponseSuccessImpl _value,
      $Res Function(_$ApiResponseSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? statusCode = null,
    Object? message = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$ApiResponseSuccessImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiResponseSuccessImpl implements ApiResponseSuccess {
  const _$ApiResponseSuccessImpl(
      {required final Map<String, dynamic> data,
      required this.statusCode,
      this.message,
      final Map<String, dynamic>? metadata,
      final String? $type})
      : _data = data,
        _metadata = metadata,
        $type = $type ?? 'success';

  factory _$ApiResponseSuccessImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiResponseSuccessImplFromJson(json);

  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  final int statusCode;
  @override
  final String? message;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ApiResponse.success(data: $data, statusCode: $statusCode, message: $message, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiResponseSuccessImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_data),
      statusCode,
      message,
      const DeepCollectionEquality().hash(_metadata));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiResponseSuccessImplCopyWith<_$ApiResponseSuccessImpl> get copyWith =>
      __$$ApiResponseSuccessImplCopyWithImpl<_$ApiResponseSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic> data, int statusCode,
            String? message, Map<String, dynamic>? metadata)
        success,
    required TResult Function(String message, int statusCode, String? errorCode,
            Map<String, dynamic>? details)
        error,
  }) {
    return success(data, statusCode, message, metadata);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, dynamic> data, int statusCode,
            String? message, Map<String, dynamic>? metadata)?
        success,
    TResult? Function(String message, int statusCode, String? errorCode,
            Map<String, dynamic>? details)?
        error,
  }) {
    return success?.call(data, statusCode, message, metadata);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, dynamic> data, int statusCode, String? message,
            Map<String, dynamic>? metadata)?
        success,
    TResult Function(String message, int statusCode, String? errorCode,
            Map<String, dynamic>? details)?
        error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data, statusCode, message, metadata);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApiResponseSuccess value) success,
    required TResult Function(ApiResponseError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApiResponseSuccess value)? success,
    TResult? Function(ApiResponseError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApiResponseSuccess value)? success,
    TResult Function(ApiResponseError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiResponseSuccessImplToJson(
      this,
    );
  }
}

abstract class ApiResponseSuccess implements ApiResponse {
  const factory ApiResponseSuccess(
      {required final Map<String, dynamic> data,
      required final int statusCode,
      final String? message,
      final Map<String, dynamic>? metadata}) = _$ApiResponseSuccessImpl;

  factory ApiResponseSuccess.fromJson(Map<String, dynamic> json) =
      _$ApiResponseSuccessImpl.fromJson;

  Map<String, dynamic> get data;
  @override
  int get statusCode;
  @override
  String? get message;
  Map<String, dynamic>? get metadata;
  @override
  @JsonKey(ignore: true)
  _$$ApiResponseSuccessImplCopyWith<_$ApiResponseSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ApiResponseErrorImplCopyWith<$Res>
    implements $ApiResponseCopyWith<$Res> {
  factory _$$ApiResponseErrorImplCopyWith(_$ApiResponseErrorImpl value,
          $Res Function(_$ApiResponseErrorImpl) then) =
      __$$ApiResponseErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String message,
      int statusCode,
      String? errorCode,
      Map<String, dynamic>? details});
}

/// @nodoc
class __$$ApiResponseErrorImplCopyWithImpl<$Res>
    extends _$ApiResponseCopyWithImpl<$Res, _$ApiResponseErrorImpl>
    implements _$$ApiResponseErrorImplCopyWith<$Res> {
  __$$ApiResponseErrorImplCopyWithImpl(_$ApiResponseErrorImpl _value,
      $Res Function(_$ApiResponseErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? statusCode = null,
    Object? errorCode = freezed,
    Object? details = freezed,
  }) {
    return _then(_$ApiResponseErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      errorCode: freezed == errorCode
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as String?,
      details: freezed == details
          ? _value._details
          : details // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiResponseErrorImpl implements ApiResponseError {
  const _$ApiResponseErrorImpl(
      {required this.message,
      required this.statusCode,
      this.errorCode,
      final Map<String, dynamic>? details,
      final String? $type})
      : _details = details,
        $type = $type ?? 'error';

  factory _$ApiResponseErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiResponseErrorImplFromJson(json);

  @override
  final String message;
  @override
  final int statusCode;
  @override
  final String? errorCode;
  final Map<String, dynamic>? _details;
  @override
  Map<String, dynamic>? get details {
    final value = _details;
    if (value == null) return null;
    if (_details is EqualUnmodifiableMapView) return _details;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ApiResponse.error(message: $message, statusCode: $statusCode, errorCode: $errorCode, details: $details)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiResponseErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode) &&
            const DeepCollectionEquality().equals(other._details, _details));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message, statusCode, errorCode,
      const DeepCollectionEquality().hash(_details));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiResponseErrorImplCopyWith<_$ApiResponseErrorImpl> get copyWith =>
      __$$ApiResponseErrorImplCopyWithImpl<_$ApiResponseErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic> data, int statusCode,
            String? message, Map<String, dynamic>? metadata)
        success,
    required TResult Function(String message, int statusCode, String? errorCode,
            Map<String, dynamic>? details)
        error,
  }) {
    return error(message, statusCode, errorCode, details);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, dynamic> data, int statusCode,
            String? message, Map<String, dynamic>? metadata)?
        success,
    TResult? Function(String message, int statusCode, String? errorCode,
            Map<String, dynamic>? details)?
        error,
  }) {
    return error?.call(message, statusCode, errorCode, details);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, dynamic> data, int statusCode, String? message,
            Map<String, dynamic>? metadata)?
        success,
    TResult Function(String message, int statusCode, String? errorCode,
            Map<String, dynamic>? details)?
        error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, statusCode, errorCode, details);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApiResponseSuccess value) success,
    required TResult Function(ApiResponseError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApiResponseSuccess value)? success,
    TResult? Function(ApiResponseError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApiResponseSuccess value)? success,
    TResult Function(ApiResponseError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiResponseErrorImplToJson(
      this,
    );
  }
}

abstract class ApiResponseError implements ApiResponse {
  const factory ApiResponseError(
      {required final String message,
      required final int statusCode,
      final String? errorCode,
      final Map<String, dynamic>? details}) = _$ApiResponseErrorImpl;

  factory ApiResponseError.fromJson(Map<String, dynamic> json) =
      _$ApiResponseErrorImpl.fromJson;

  @override
  String get message;
  @override
  int get statusCode;
  String? get errorCode;
  Map<String, dynamic>? get details;
  @override
  @JsonKey(ignore: true)
  _$$ApiResponseErrorImplCopyWith<_$ApiResponseErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaginationMeta _$PaginationMetaFromJson(Map<String, dynamic> json) {
  return _PaginationMeta.fromJson(json);
}

/// @nodoc
mixin _$PaginationMeta {
  int get currentPage => throw _privateConstructorUsedError;
  int get perPage => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  bool? get hasNextPage => throw _privateConstructorUsedError;
  bool? get hasPreviousPage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaginationMetaCopyWith<PaginationMeta> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginationMetaCopyWith<$Res> {
  factory $PaginationMetaCopyWith(
          PaginationMeta value, $Res Function(PaginationMeta) then) =
      _$PaginationMetaCopyWithImpl<$Res, PaginationMeta>;
  @useResult
  $Res call(
      {int currentPage,
      int perPage,
      int total,
      int totalPages,
      bool? hasNextPage,
      bool? hasPreviousPage});
}

/// @nodoc
class _$PaginationMetaCopyWithImpl<$Res, $Val extends PaginationMeta>
    implements $PaginationMetaCopyWith<$Res> {
  _$PaginationMetaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = null,
    Object? perPage = null,
    Object? total = null,
    Object? totalPages = null,
    Object? hasNextPage = freezed,
    Object? hasPreviousPage = freezed,
  }) {
    return _then(_value.copyWith(
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      perPage: null == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      hasNextPage: freezed == hasNextPage
          ? _value.hasNextPage
          : hasNextPage // ignore: cast_nullable_to_non_nullable
              as bool?,
      hasPreviousPage: freezed == hasPreviousPage
          ? _value.hasPreviousPage
          : hasPreviousPage // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaginationMetaImplCopyWith<$Res>
    implements $PaginationMetaCopyWith<$Res> {
  factory _$$PaginationMetaImplCopyWith(_$PaginationMetaImpl value,
          $Res Function(_$PaginationMetaImpl) then) =
      __$$PaginationMetaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int currentPage,
      int perPage,
      int total,
      int totalPages,
      bool? hasNextPage,
      bool? hasPreviousPage});
}

/// @nodoc
class __$$PaginationMetaImplCopyWithImpl<$Res>
    extends _$PaginationMetaCopyWithImpl<$Res, _$PaginationMetaImpl>
    implements _$$PaginationMetaImplCopyWith<$Res> {
  __$$PaginationMetaImplCopyWithImpl(
      _$PaginationMetaImpl _value, $Res Function(_$PaginationMetaImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = null,
    Object? perPage = null,
    Object? total = null,
    Object? totalPages = null,
    Object? hasNextPage = freezed,
    Object? hasPreviousPage = freezed,
  }) {
    return _then(_$PaginationMetaImpl(
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      perPage: null == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      hasNextPage: freezed == hasNextPage
          ? _value.hasNextPage
          : hasNextPage // ignore: cast_nullable_to_non_nullable
              as bool?,
      hasPreviousPage: freezed == hasPreviousPage
          ? _value.hasPreviousPage
          : hasPreviousPage // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginationMetaImpl implements _PaginationMeta {
  const _$PaginationMetaImpl(
      {required this.currentPage,
      required this.perPage,
      required this.total,
      required this.totalPages,
      this.hasNextPage,
      this.hasPreviousPage});

  factory _$PaginationMetaImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginationMetaImplFromJson(json);

  @override
  final int currentPage;
  @override
  final int perPage;
  @override
  final int total;
  @override
  final int totalPages;
  @override
  final bool? hasNextPage;
  @override
  final bool? hasPreviousPage;

  @override
  String toString() {
    return 'PaginationMeta(currentPage: $currentPage, perPage: $perPage, total: $total, totalPages: $totalPages, hasNextPage: $hasNextPage, hasPreviousPage: $hasPreviousPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginationMetaImpl &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.hasNextPage, hasNextPage) ||
                other.hasNextPage == hasNextPage) &&
            (identical(other.hasPreviousPage, hasPreviousPage) ||
                other.hasPreviousPage == hasPreviousPage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, currentPage, perPage, total,
      totalPages, hasNextPage, hasPreviousPage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginationMetaImplCopyWith<_$PaginationMetaImpl> get copyWith =>
      __$$PaginationMetaImplCopyWithImpl<_$PaginationMetaImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginationMetaImplToJson(
      this,
    );
  }
}

abstract class _PaginationMeta implements PaginationMeta {
  const factory _PaginationMeta(
      {required final int currentPage,
      required final int perPage,
      required final int total,
      required final int totalPages,
      final bool? hasNextPage,
      final bool? hasPreviousPage}) = _$PaginationMetaImpl;

  factory _PaginationMeta.fromJson(Map<String, dynamic> json) =
      _$PaginationMetaImpl.fromJson;

  @override
  int get currentPage;
  @override
  int get perPage;
  @override
  int get total;
  @override
  int get totalPages;
  @override
  bool? get hasNextPage;
  @override
  bool? get hasPreviousPage;
  @override
  @JsonKey(ignore: true)
  _$$PaginationMetaImplCopyWith<_$PaginationMetaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApiListResponse _$ApiListResponseFromJson(Map<String, dynamic> json) {
  return _ApiListResponse.fromJson(json);
}

/// @nodoc
mixin _$ApiListResponse {
  List<Map<String, dynamic>> get data => throw _privateConstructorUsedError;
  PaginationMeta get pagination => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApiListResponseCopyWith<ApiListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiListResponseCopyWith<$Res> {
  factory $ApiListResponseCopyWith(
          ApiListResponse value, $Res Function(ApiListResponse) then) =
      _$ApiListResponseCopyWithImpl<$Res, ApiListResponse>;
  @useResult
  $Res call(
      {List<Map<String, dynamic>> data,
      PaginationMeta pagination,
      String? message});

  $PaginationMetaCopyWith<$Res> get pagination;
}

/// @nodoc
class _$ApiListResponseCopyWithImpl<$Res, $Val extends ApiListResponse>
    implements $ApiListResponseCopyWith<$Res> {
  _$ApiListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? pagination = null,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      pagination: null == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as PaginationMeta,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PaginationMetaCopyWith<$Res> get pagination {
    return $PaginationMetaCopyWith<$Res>(_value.pagination, (value) {
      return _then(_value.copyWith(pagination: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ApiListResponseImplCopyWith<$Res>
    implements $ApiListResponseCopyWith<$Res> {
  factory _$$ApiListResponseImplCopyWith(_$ApiListResponseImpl value,
          $Res Function(_$ApiListResponseImpl) then) =
      __$$ApiListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Map<String, dynamic>> data,
      PaginationMeta pagination,
      String? message});

  @override
  $PaginationMetaCopyWith<$Res> get pagination;
}

/// @nodoc
class __$$ApiListResponseImplCopyWithImpl<$Res>
    extends _$ApiListResponseCopyWithImpl<$Res, _$ApiListResponseImpl>
    implements _$$ApiListResponseImplCopyWith<$Res> {
  __$$ApiListResponseImplCopyWithImpl(
      _$ApiListResponseImpl _value, $Res Function(_$ApiListResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? pagination = null,
    Object? message = freezed,
  }) {
    return _then(_$ApiListResponseImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      pagination: null == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as PaginationMeta,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiListResponseImpl implements _ApiListResponse {
  const _$ApiListResponseImpl(
      {required final List<Map<String, dynamic>> data,
      required this.pagination,
      this.message})
      : _data = data;

  factory _$ApiListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiListResponseImplFromJson(json);

  final List<Map<String, dynamic>> _data;
  @override
  List<Map<String, dynamic>> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final PaginationMeta pagination;
  @override
  final String? message;

  @override
  String toString() {
    return 'ApiListResponse(data: $data, pagination: $pagination, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiListResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.pagination, pagination) ||
                other.pagination == pagination) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_data), pagination, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiListResponseImplCopyWith<_$ApiListResponseImpl> get copyWith =>
      __$$ApiListResponseImplCopyWithImpl<_$ApiListResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiListResponseImplToJson(
      this,
    );
  }
}

abstract class _ApiListResponse implements ApiListResponse {
  const factory _ApiListResponse(
      {required final List<Map<String, dynamic>> data,
      required final PaginationMeta pagination,
      final String? message}) = _$ApiListResponseImpl;

  factory _ApiListResponse.fromJson(Map<String, dynamic> json) =
      _$ApiListResponseImpl.fromJson;

  @override
  List<Map<String, dynamic>> get data;
  @override
  PaginationMeta get pagination;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$ApiListResponseImplCopyWith<_$ApiListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
