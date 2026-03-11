import 'package:cga_app/app/features/patients/domain/entities/patient.dart';

abstract class UpdatePatientUsecase {
  Future<void> call({required Patient patient});
} 