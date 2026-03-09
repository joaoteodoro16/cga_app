import 'package:cga_app/app/features/auth/data/dtos/login_user_dto.dart';

abstract class AuthRemoteDatasource {
  Future<LoginUserDto> logIn({required String operator, required String password});
}