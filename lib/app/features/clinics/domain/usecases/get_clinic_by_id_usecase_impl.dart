import 'package:cga_app/app/features/clinics/domain/entities/clinic.dart';
import 'package:cga_app/app/features/clinics/domain/repositories/clinic_repository.dart';
import 'package:cga_app/app/features/clinics/domain/usecases/contract/get_clinic_by_id_usecase.dart';

class GetClinicByIdUsecaseImpl implements GetClinicByIdUsecase {
  final ClinicRepository _repository;

  GetClinicByIdUsecaseImpl({required ClinicRepository repository})
      : _repository = repository;

  @override
  Future<Clinic?> call({required String id}) {
    return _repository.getClinicById(id: id);
  }
}