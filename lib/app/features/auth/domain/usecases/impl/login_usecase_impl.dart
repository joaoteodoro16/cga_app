import 'package:cga_app/app/features/auth/domain/entities/user.dart';
import 'package:cga_app/app/features/auth/domain/repositories/auth_repository.dart';

import '../contracts/login_usecase.dart';

class LoginUsecaseImpl extends LoginUsecase {
  final AuthRepository _repository;

  LoginUsecaseImpl({required AuthRepository repository})
    : _repository = repository;

  @override
  Future<User> call({
    required String operator,
    required String password,
  }) async {
    return await _repository.login(operator: operator, password: password);
  }
}
