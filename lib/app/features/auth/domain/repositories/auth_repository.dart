import 'package:cga_app/app/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login({required String operator, required String password});
}
