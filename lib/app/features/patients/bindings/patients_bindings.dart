import 'package:cga_app/app/features/patients/presentation/controllers/patients_controller.dart';
import 'package:get/get.dart';

class PatientsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PatientsController());
  }
}
