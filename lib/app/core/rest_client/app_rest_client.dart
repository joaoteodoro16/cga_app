import 'package:cga_app/app/core/exceptions/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:cga_app/app/core/config/env.dart';
import 'package:cga_app/app/core/rest_client/interceptors/auth_interceptor.dart';
import 'package:cga_app/app/core/rest_client/response/api_response.dart';

class AppRestClient {
  late final Dio _dio;
  late final AuthInterceptor _authInterceptor;

  AppRestClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: Env.apiUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 60),
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
      ),
    );

    _authInterceptor = AuthInterceptor(client: this);
  }

  AppRestClient auth() {
    if (!_dio.interceptors.contains(_authInterceptor)) {
      _dio.interceptors.add(_authInterceptor);
    }
    return this;
  }

  AppRestClient unAuth() {
    _dio.interceptors.remove(_authInterceptor);
    return this;
  }

  // Future<ApiResponse<T>> getApi<T>(
  //   String path, {
  //   Map<String, dynamic>? queryParameters,
  //   required T Function(Map<String, dynamic>) fromMapT,
  // }) async {
  //   try {
  //     final response = await _dio.get(path, queryParameters: queryParameters);
  //     return ApiResponse<T>.fromMap(
  //       response.data as Map<String, dynamic>,
  //       fromMapT,
  //     );
  //   } on DioException catch (e) {
  //     _handleDioError(e);
  //   } catch (e) {
  //     throw AppException(message: 'Erro inesperado: $e');
  //   }
  // }

  Future<ApiResponse<T>> getApi<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic>) fromMapT,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      final map = response.data as Map<String, dynamic>;
      return ApiResponse<T>.fromMap(map, fromMapT);
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e) {
      throw AppException(message: 'Erro inesperado: $e');
    }
  }

  Future<ApiResponse<T>> postApi<T>(
    String path, {
    Map<String, dynamic>? data,
    required T Function(Map<String, dynamic>) fromMapT,
  }) async {
    try {
      final response = await _dio.post(path, data: data);
      return ApiResponse<T>.fromMap(
        response.data as Map<String, dynamic>,
        fromMapT,
      );
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e) {
      throw AppException(message: 'Erro inesperado: $e');
    }
  }

  Future<ApiResponse<T>> putApi<T>(
    String path, {
    Map<String, dynamic>? data,
    required T Function(Map<String, dynamic>) fromMapT,
  }) async {
    try {
      final response = await _dio.put(path, data: data);
      return ApiResponse<T>.fromMap(
        response.data as Map<String, dynamic>,
        fromMapT,
      );
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e) {
      throw AppException(message: 'Erro inesperado: $e');
    }
  }

  Future<ApiResponse<T>> deleteApi<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic>) fromMapT,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return ApiResponse<T>.fromMap(
        response.data as Map<String, dynamic>,
        fromMapT,
      );
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e) {
      throw AppException(message: 'Erro inesperado: $e');
    }
  }

  Future<ApiResponse<T>> patchApi<T>(
    String path, {
    Map<String, dynamic>? data,
    required T Function(Map<String, dynamic>) fromMapT,
  }) async {
    try {
      final response = await _dio.patch(path, data: data);
      return ApiResponse<T>.fromMap(
        response.data as Map<String, dynamic>,
        fromMapT,
      );
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e) {
      throw AppException(message: 'Erro inesperado: $e');
    }
  }

  Dio get dio => _dio;

  Never _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throw AppException(message: 'Tempo de conexão excedido');

      case DioExceptionType.sendTimeout:
        throw AppException(message: 'Tempo de envio excedido');

      case DioExceptionType.receiveTimeout:
        throw AppException(message: 'Tempo de resposta excedido');

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final data = e.response?.data;

        String message = 'Erro na requisição';

        if (data is Map<String, dynamic>) {
          message = data['message'] ?? data['error'] ?? message;
        }

        throw AppRestClientException(
          message: message,
          statusCode: statusCode,
          data: data,
        );

      case DioExceptionType.cancel:
        throw AppRestClientException(message: 'Requisição cancelada');

      case DioExceptionType.connectionError:
        throw AppRestClientException(message: 'Erro de conexão com o servidor');

      case DioExceptionType.unknown:
      default:
        throw AppRestClientException(message: 'Erro inesperado: ${e.message}');
    }
  }
}
