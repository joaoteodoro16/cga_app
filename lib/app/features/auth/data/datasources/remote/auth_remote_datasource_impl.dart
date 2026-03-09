import 'package:cga_app/app/core/exceptions/exceptions.dart';
import 'package:cga_app/app/core/rest_client/app_rest_client.dart';
import 'package:cga_app/app/core/rest_client/end_points/app_end_points.dart';
import 'package:cga_app/app/features/auth/data/dtos/login_user_dto.dart';
import 'auth_remote_datasource.dart';

class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
  final AppRestClient _dio;

  AuthRemoteDatasourceImpl({required AppRestClient dio}) : _dio = dio;

  @override
  Future<LoginUserDto> logIn({
    required String operator,
    required String password,
  }) async {
    try {
      final apiResponse = await _dio.postApi<LoginUserDto>(
        data: {"operador": operator, "senha": password},
        AppEndPoints.auth,
        fromMapT: (map) => LoginUserDto.fromMap(map),
      );
      if (apiResponse.data != null) return apiResponse.data!;
      throw UnauthorizedException(message: apiResponse.message ?? '');
    } on AppRestClientException catch (e) {
      throw AppException(message: e.message);
    } catch (e) {
      throw AppException(message: "Erro inesperado ao realizar login");
    }
  }
}
