import 'package:cga_app/app/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:cga_app/app/features/auth/data/datasources/remote/auth_remote_datasource_impl.dart';
import 'package:cga_app/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:cga_app/app/features/auth/domain/repositories/auth_repository_impl.dart';
import 'package:cga_app/app/features/auth/domain/usecases/contracts/login_usecase.dart';
import 'package:cga_app/app/features/auth/domain/usecases/impl/login_usecase_impl.dart';
import 'package:cga_app/app/features/auth/presentation/login/login_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(dio: Get.find()),
      fenix: true,
    );
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(remote: Get.find()),
      fenix: true,
    );
    Get.lazyPut<LoginUsecase>(
      () => LoginUsecaseImpl(repository: Get.find()),
      fenix: true,
    );
    Get.lazyPut<LoginController>(
      () => LoginController(loginUsecase: Get.find()),
    );
  }
}
