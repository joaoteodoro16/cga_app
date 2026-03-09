import 'package:cga_app/app/features/clinics/domain/entities/clinic.dart';
import 'package:cga_app/app/features/clinics/domain/repositories/clinic_repository.dart';

import '../contract/add_clinic_usecase.dart';

class AddClinicUsecaseImpl extends AddClinicUsecase {
  final ClinicRepository _clinicRepository;

  AddClinicUsecaseImpl({required ClinicRepository clinicRepository})
    : _clinicRepository = clinicRepository;

  @override
  Future<void> call({required Clinic clinic}) async {
    await _clinicRepository.add(clinic: clinic);
  }
}
