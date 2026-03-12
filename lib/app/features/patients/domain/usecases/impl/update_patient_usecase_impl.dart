import 'package:cga_app/app/core/exceptions/exceptions.dart';
import 'package:cga_app/app/features/patients/domain/entities/patient.dart';
import 'package:cga_app/app/features/patients/domain/repositories/patient_repository.dart';

import '../contracts/update_patient_usecase.dart';

class UpdatePatientUsecaseImpl extends UpdatePatientUsecase {
  final PatientRepository _repository;

  UpdatePatientUsecaseImpl({required PatientRepository repository})
    : _repository = repository;

  @override
  Future<void> call({required Patient patient}) async {
    if (patient.dataInicio.isAfter(patient.dataEncerramento)) {
      throw AppException(
        message: 'Data de início deve ser anterior à data de fim',
      );
    }
    await _repository.update(patient: patient);
  }
}
