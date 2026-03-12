import 'package:cga_app/app/features/patients/data/datasources/remote/patient_remote_datasource.dart';
import 'package:cga_app/app/features/patients/data/datasources/remote/patient_remote_datasource_impl.dart';
import 'package:cga_app/app/features/patients/data/repositories/patient_repository_impl.dart';
import 'package:cga_app/app/features/patients/domain/repositories/patient_repository.dart';
import 'package:cga_app/app/features/patients/domain/usecases/contracts/create_patient_usecase.dart';
import 'package:cga_app/app/features/patients/domain/usecases/contracts/get_patients_usecase.dart';
import 'package:cga_app/app/features/patients/domain/usecases/contracts/update_patient_usecase.dart';
import 'package:cga_app/app/features/patients/domain/usecases/impl/update_patient_usecase_impl.dart';
import 'package:cga_app/app/features/patients/domain/usecases/impl/create_patient_usecase_impl.dart';
import 'package:cga_app/app/features/patients/domain/usecases/impl/get_patients_usecase_impl.dart';
import 'package:cga_app/app/features/patients/presentation/controllers/patients_controller.dart';
import 'package:get/get.dart';

class PatientsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientRemoteDatasource>(
      () => PatientRemoteDatasourceImpl(dio: Get.find()),
      fenix: true,
    );
    Get.lazyPut<PatientRepository>(
      () => PatientRepositoryImpl(datasource: Get.find()),
      fenix: true,
    );
    Get.lazyPut<GetPatientsUsecase>(
      () => GetPatientsUsecaseImpl(repository: Get.find()),
      fenix: true,
    );
    Get.lazyPut<CreatePatientUsecase>(
      () => CreatePatientUsecaseImpl(repository: Get.find()),
      fenix: true,
    );
    Get.lazyPut<UpdatePatientUsecase>(
      () => UpdatePatientUsecaseImpl(repository: Get.find()),
      fenix: true,
    );
    Get.lazyPut(
      () => PatientsController(
        createPatientUsecase: Get.find(),
        getPatientsUsecase: Get.find(),
        updatePatientUsecase: Get.find(),
      ),
    );
  }
}
