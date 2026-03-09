import 'package:cga_app/app/features/clinics/domain/entities/clinic.dart';

abstract class UpdateClinicUsecase {
Future<void> call({required Clinic clinic});
}