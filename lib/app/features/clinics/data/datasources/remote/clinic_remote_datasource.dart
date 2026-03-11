import 'package:cga_app/app/core/pagination/dtos/paginated_dto.dart';
import 'package:cga_app/app/features/clinics/data/dtos/create_clinic_dto.dart';
import 'package:cga_app/app/features/clinics/data/dtos/get_clinic_by_id_dto.dart';
import 'package:cga_app/app/features/clinics/data/dtos/get_clinics_dto.dart';
import 'package:cga_app/app/features/clinics/data/dtos/update_clinic_dto.dart';

abstract class ClinicRemoteDatasource {
  Future<PaginatedDto<GetClinicsDto>> getAll({
    int? page,
    int? pageSize,
    String? cnpj,
    String? name,
    bool? active,
  });

  Future<void> create({required CreateClinicDto clinic});
  Future<void> update({required UpdateClinicDto clinic});
  Future<GetClinicByIdDto?> getClinicById({required String id});
}
