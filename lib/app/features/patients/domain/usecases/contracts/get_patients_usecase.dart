import 'package:cga_app/app/core/pagination/entities/paginated_result.dart';
import 'package:cga_app/app/features/patients/domain/entities/patient.dart';

abstract class GetPatientsUsecase {
  Future<PaginatedResult<Patient>> call({
    String? name,
    String? groupId,
    bool? active,
    required int page,
    required int pageSize,
  });
}
