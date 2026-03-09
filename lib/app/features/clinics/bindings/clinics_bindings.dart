import 'package:cga_app/app/features/clinics/data/datasources/remote/clinic_remote_datasource.dart';
import 'package:cga_app/app/features/clinics/data/datasources/remote/clinic_remote_datasource_impl.dart';
import 'package:cga_app/app/features/clinics/data/repositories/clinic_repository_impl.dart';
import 'package:cga_app/app/features/clinics/domain/repositories/clinic_repository.dart';
import 'package:cga_app/app/features/clinics/domain/usecases/contract/add_clinic_usecase.dart';
import 'package:cga_app/app/features/clinics/domain/usecases/contract/get_clinics_usecase.dart';
import 'package:cga_app/app/features/clinics/domain/usecases/contract/update_clinic_usecase.dart';
import 'package:cga_app/app/features/clinics/domain/usecases/impl/add_clinic_usecase_impl.dart';
import 'package:cga_app/app/features/clinics/domain/usecases/impl/get_clinics_usecase_impl.dart';
import 'package:cga_app/app/features/clinics/domain/usecases/impl/update_clinic_usecase_impl.dart';
import 'package:cga_app/app/features/clinics/presentation/controllers/clinics_controller.dart';
import 'package:get/get.dart';

class ClinicsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClinicRemoteDatasource>(
      () => ClinicRemoteDatasourceImpl(dio: Get.find()),
      fenix: true,
    );
    Get.lazyPut<ClinicRepository>(
      () => ClinicRepositoryImpl(remote: Get.find()),
      fenix: true,
    );
    Get.lazyPut<GetClinicsUsecase>(
      () => GetClinicsUsecaseImpl(clinicRepository: Get.find()),
      fenix: true,
    );
    Get.lazyPut<AddClinicUsecase>(
      () => AddClinicUsecaseImpl(clinicRepository: Get.find()),
      fenix: true,
    );
    Get.lazyPut<UpdateClinicUsecase>(
      () => UpdateClinicUsecaseImpl(clinicRepository: Get.find()),
      fenix: true,
    );
    Get.lazyPut(
      () => ClinicsController(
        getClinicsUsecase: Get.find(),
        addClinicUsecase: Get.find(),
        updateClinicUsecase: Get.find(),
      ),
    );
  }
}
