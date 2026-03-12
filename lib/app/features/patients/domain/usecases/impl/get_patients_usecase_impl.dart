import 'package:cga_app/app/core/pagination/entities/paginated_result.dart';
import 'package:cga_app/app/features/patients/domain/entities/patient.dart';
import 'package:cga_app/app/features/patients/domain/repositories/patient_repository.dart';
import '../contracts/get_patients_usecase.dart';

class GetPatientsUsecaseImpl extends GetPatientsUsecase {
  final PatientRepository _repository;

  GetPatientsUsecaseImpl({required PatientRepository repository})
    : _repository = repository;

  @override
  Future<PaginatedResult<Patient>> call({
    String? name,
    String? groupId,
    String? clinicId,
    bool? active,
    String? phone,
    required int page,
    required int pageSize,
  }) async {
    return await _repository.getAll(
      name: name,
      groupId: groupId,
      active: active,
      clinicId: clinicId,
      phone: phone,
      page: page,
      pageSize: pageSize,
    );
  }
}
