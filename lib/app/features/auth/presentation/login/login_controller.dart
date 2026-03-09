import 'package:cga_app/app/core/controller/base_controller.dart';
import 'package:cga_app/app/core/exceptions/exceptions.dart';
import 'package:cga_app/app/core/routes/app_routes.dart';
import 'package:cga_app/app/core/ui/helpers/messager.dart';
import 'package:cga_app/app/features/auth/domain/usecases/contracts/login_usecase.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';

class LoginController extends BaseController {
  final LoginUsecase _loginUsecase;

  LoginController({required LoginUsecase loginUsecase})
    : _loginUsecase = loginUsecase;

  final _isSuccess = false.obs;
  bool get isSuccess => _isSuccess.value;
  set isSuccess(bool value) => _isSuccess.value = value;

  @override
  void onControllerReady() {
    ever<bool>(_isSuccess, (success) {
      if (success) {
        Get.offAllNamed(AppRoutes.home);
      }
    });
  }

  Future<void> login({
    required String operator,
    required String password,
  }) async {
    try {
      showLoading();
      await _loginUsecase.call(operator: operator, password: password);
      hideLoading();
      isSuccess = true;
    } on AppException catch (e) {
      hideLoading();
      showMessage(Messager.error(message: e.message));
    } catch (e) {
      hideLoading();
      showMessage(Messager.error(message: e.toString()));
    }
  }
}
