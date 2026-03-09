import 'package:cga_app/app/features/clinics/domain/entities/clinic.dart';
import 'package:cga_app/app/features/clinics/domain/repositories/clinic_repository.dart';
import 'package:cga_app/app/features/clinics/domain/usecases/contract/update_clinic_usecase.dart';

class UpdateClinicUsecaseImpl extends UpdateClinicUsecase {
  final ClinicRepository _clinicRepository;

  UpdateClinicUsecaseImpl({required ClinicRepository clinicRepository})
    : _clinicRepository = clinicRepository;

  @override
  Future<void> call({required Clinic clinic}) async {
    await _clinicRepository.update(clinic: clinic);
  }
}
