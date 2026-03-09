import 'package:cga_app/app/core/pagination/entities/paginated_result.dart';
import 'package:cga_app/app/features/clinics/domain/entities/clinic.dart';

abstract class GetClinicsUsecase {
  Future<PaginatedResult<Clinic>> call({
    int? page,
    int? pageSize,
    String? cnpj,
    String? name,
    bool? active,
  });
}
