import 'package:cga_app/app/features/clinics/domain/entities/clinic.dart';

abstract class GetClinicByIdUsecase {
  Future<Clinic?> call({required String id});
}