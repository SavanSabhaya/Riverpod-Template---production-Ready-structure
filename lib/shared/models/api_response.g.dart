// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiResponseSuccessImpl _$$ApiResponseSuccessImplFromJson(
        Map<String, dynamic> json) =>
    _$ApiResponseSuccessImpl(
      data: json['data'] as Map<String, dynamic>,
      statusCode: (json['statusCode'] as num).toInt(),
      message: json['message'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ApiResponseSuccessImplToJson(
        _$ApiResponseSuccessImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'statusCode': instance.statusCode,
      'message': instance.message,
      'metadata': instance.metadata,
      'runtimeType': instance.$type,
    };

_$ApiResponseErrorImpl _$$ApiResponseErrorImplFromJson(
        Map<String, dynamic> json) =>
    _$ApiResponseErrorImpl(
      message: json['message'] as String,
      statusCode: (json['statusCode'] as num).toInt(),
      errorCode: json['errorCode'] as String?,
      details: json['details'] as Map<String, dynamic>?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ApiResponseErrorImplToJson(
        _$ApiResponseErrorImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'statusCode': instance.statusCode,
      'errorCode': instance.errorCode,
      'details': instance.details,
      'runtimeType': instance.$type,
    };

_$PaginationMetaImpl _$$PaginationMetaImplFromJson(Map<String, dynamic> json) =>
    _$PaginationMetaImpl(
      currentPage: (json['currentPage'] as num).toInt(),
      perPage: (json['perPage'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      hasNextPage: json['hasNextPage'] as bool?,
      hasPreviousPage: json['hasPreviousPage'] as bool?,
    );

Map<String, dynamic> _$$PaginationMetaImplToJson(
        _$PaginationMetaImpl instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'perPage': instance.perPage,
      'total': instance.total,
      'totalPages': instance.totalPages,
      'hasNextPage': instance.hasNextPage,
      'hasPreviousPage': instance.hasPreviousPage,
    };

_$ApiListResponseImpl _$$ApiListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ApiListResponseImpl(
      data: (json['data'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      pagination:
          PaginationMeta.fromJson(json['pagination'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$ApiListResponseImplToJson(
        _$ApiListResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'pagination': instance.pagination,
      'message': instance.message,
    };
