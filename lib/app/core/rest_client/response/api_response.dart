import 'dart:convert';

class ApiResponse<T> {
  final int statusCode;
  final T? data;
  final bool success;
  final String? message;

  ApiResponse({
    required this.statusCode,
    this.data,
    required this.success,
    this.message,
  });

  Map<String, dynamic> toMap(Map<String, dynamic> Function(T) toMapT) {
    return {
      'statusCode': statusCode,
      'data': data != null ? toMapT(data as T) : null,
      'success': success,
      'message': message,
    };
  }

  factory ApiResponse.fromMap(
    Map<String, dynamic> map,
    T Function(Map<String, dynamic>) fromMapT,
  ) {
    return ApiResponse<T>(
      statusCode: map['statusCode']?.toInt() ?? 0,
      data: map['data'] != null ? fromMapT(map) : null,
      success: map['success'] ?? false,
      message: map['message'],
    );
  }

  String toJson(Map<String, dynamic> Function(T) toMapT) =>
      json.encode(toMap(toMapT));

  factory ApiResponse.fromJson(
    String source,
    T Function(Map<String, dynamic>) fromMapT,
  ) => ApiResponse.fromMap(json.decode(source), fromMapT);
}
