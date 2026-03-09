import 'package:get/get.dart';
import '../bindings/clinics_bindings.dart';
import '../domain/usecases/contract/get_clinics_usecase.dart';

class ClinicsModule {
  static void ensureInitialized() {
    if (!Get.isRegistered<GetClinicsUsecase>()) {
      ClinicsBindings().dependencies();
    }
  }
}