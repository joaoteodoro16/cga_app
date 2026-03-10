import 'package:cga_app/app/core/pagination/entities/paginated_result.dart';
import 'package:cga_app/app/features/clinics/domain/entities/clinic.dart';

abstract class ClinicRepository {
  Future<PaginatedResult<Clinic>> getAll({
    int? page,
    int? pageSize,
    String? cnpj,
    String? name,
    bool? active,
  });

  Future<void> add({required Clinic clinic});

  Future<void> update({required Clinic clinic});

  Future<Clinic?> getClinicById({required String id});
}
