import 'package:cga_app/app/features/auth/domain/entities/user.dart';

abstract class LoginUsecase {
  Future<User> call({required String operator, required String password});
}