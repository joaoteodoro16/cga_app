import 'package:cga_app/app/features/clinics/module/clinics_module.dart';
import 'package:cga_app/app/features/clinics/presentation/controllers/search_clinics_controller.dart';
import 'package:get/instance_manager.dart';

class SearchClinicsBindings extends Bindings {
  final String tag;

  SearchClinicsBindings(this.tag);

  @override
  void dependencies() {
    ClinicsModule.ensureInitialized();

    Get.lazyPut<SearchClinicsController>(
      () => SearchClinicsController(
        getClinicsUsecase: Get.find(),
      ),
      tag: tag,
    );
  }
}