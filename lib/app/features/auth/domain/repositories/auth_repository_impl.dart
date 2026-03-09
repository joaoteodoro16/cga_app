import 'package:cga_app/app/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:cga_app/app/features/auth/domain/entities/user.dart';

import './auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDatasource _remote;
  AuthRepositoryImpl({required AuthRemoteDatasource remote}) : _remote = remote;

  @override
  Future<User> login({
    required String operator,
    required String password,
  }) async {
    final dto = await _remote.logIn(operator: operator, password: password);
    return dto.toEntity();
  }
}
