import 'package:cga_app/app/features/patients/domain/entities/patient.dart';
import 'package:cga_app/app/features/patients/domain/repositories/patient_repository.dart';

import '../contracts/create_patient_usecase.dart';

class CreatePatientUsecaseImpl extends CreatePatientUsecase {
  final PatientRepository _repository;

  CreatePatientUsecaseImpl({required PatientRepository repository})
    : _repository = repository;

  @override
  Future<void> call({required Patient patient}) async {
    await _repository.add(patient: patient);
  }
}
