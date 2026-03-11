import 'package:cga_app/app/features/patients/domain/entities/patient.dart';

abstract class CreatePatientUsecase {
Future<void> call({required Patient patient});
}