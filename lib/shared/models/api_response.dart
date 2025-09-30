import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

@freezed
class ApiResponse with _$ApiResponse {
  const factory ApiResponse.success({
    required Map<String, dynamic> data,
    required int statusCode,
    String? message,
    Map<String, dynamic>? metadata,
  }) = ApiResponseSuccess;

  const factory ApiResponse.error({
    required String message,
    required int statusCode,
    String? errorCode,
    Map<String, dynamic>? details,
  }) = ApiResponseError;

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);
}

@freezed
class PaginationMeta with _$PaginationMeta {
  const factory PaginationMeta({
    required int currentPage,
    required int perPage,
    required int total,
    required int totalPages,
    bool? hasNextPage,
    bool? hasPreviousPage,
  }) = _PaginationMeta;

  factory PaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$PaginationMetaFromJson(json);
}

@freezed
class ApiListResponse with _$ApiListResponse {
  const factory ApiListResponse({
    required List<Map<String, dynamic>> data,
    required PaginationMeta pagination,
    String? message,
  }) = _ApiListResponse;

  factory ApiListResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiListResponseFromJson(json);
}
