import 'dart:developer';

import 'package:cga_app/app/core/rest_client/app_rest_client.dart';
import 'package:cga_app/app/core/rest_client/exceptions/expire_token_exception.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  final AppRestClient client;

  AuthInterceptor({required this.client});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final sp = await SharedPreferences.getInstance();
    final accessToken = sp.getString('accessToken');

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        // Evita loop infinito se o endpoint for refresh
        if (err.requestOptions.path != '/auth/refresh') {
          await _refreshToken();
          await _retryRequest(err, handler);
        } else {
          // Aqui você pode notificar globalmente que o login expirou
          throw ExpireTokenException();
        }
      } catch (e) {
        // Qualquer erro no refresh também deve disparar login expirado
        throw ExpireTokenException();
      }
    } else {
      handler.next(err);
    }
  }

  Future<void> _refreshToken() async {
    final sp = await SharedPreferences.getInstance();
    final refreshToken = sp.getString("refreshToken");

    if (refreshToken == null) {
      throw ExpireTokenException();
    }

    try {
      // Use unAuth() para evitar que o interceptor seja aplicado novamente
      final result = await client.unAuth().putApi<Map<String, dynamic>>(
        '/auth/refresh',
        data: {'refresh_token': refreshToken},
        fromMapT: (map) => map, // Retorna o Map direto
      );

      final data = result.data!;
      await sp.setString('accessToken', data['access_token']);
      await sp.setString('refreshToken', data['refresh_token']);
    } on DioException catch (e, s) {
      log("Erro ao realizar o refresh token", error: e, stackTrace: s);
      throw ExpireTokenException();
    }
  }

  Future<void> _retryRequest(
      DioException err, ErrorInterceptorHandler handler) async {
    final options = err.requestOptions;

    final response = await client.dio.request(
      options.path,
      options: Options(
        method: options.method,
        headers: options.headers,
        responseType: options.responseType,
      ),
      data: options.data,
      queryParameters: options.queryParameters,
    );

    handler.resolve(
      Response(
        requestOptions: options,
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      ),
    );
  }
}