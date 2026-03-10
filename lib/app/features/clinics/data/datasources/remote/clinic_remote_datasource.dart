import 'package:cga_app/app/core/pagination/dtos/paginated_dto.dart';
import 'package:cga_app/app/features/clinics/data/dtos/clinic_dto.dart';

abstract class ClinicRemoteDatasource {
  Future<PaginatedDto<ClinicDto>> getAll({
    int? page,
    int? pageSize,
    String? cnpj,
    String? name,
    bool? active,
  });

  Future<void> add({required ClinicDto clinic});
  Future<void> update({required ClinicDto clinic});
  Future<ClinicDto?> getClinicById({required String id});
}
