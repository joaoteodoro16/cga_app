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
    bool? active,
    required int page,
    required int pageSize,
  }) async {
    return await _repository.getAll(page: page, pageSize: pageSize);
  }
}
