import 'package:cga_app/app/features/patients/domain/entities/patient.dart';
import 'package:cga_app/app/features/patients/domain/repositories/patient_repository.dart';

import './update_patient_usecase.dart';

class UpdatePatientUsecaseImpl extends UpdatePatientUsecase {
  final PatientRepository _repository;

  UpdatePatientUsecaseImpl({required PatientRepository repository}) : _repository = repository;

  @override
  Future<void> call({required Patient patient}) async{
    await _repository.update(patient: patient);
  }

}