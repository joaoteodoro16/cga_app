import 'package:cga_app/app/core/pagination/entities/paginated_result.dart';
import 'package:cga_app/app/features/clinics/data/datasources/remote/clinic_remote_datasource.dart';
import 'package:cga_app/app/features/clinics/data/dtos/create_clinic_dto.dart';
import 'package:cga_app/app/features/clinics/data/dtos/update_clinic_dto.dart';
import 'package:cga_app/app/features/clinics/domain/entities/clinic.dart';
import 'package:cga_app/app/features/clinics/domain/repositories/clinic_repository.dart';

class ClinicRepositoryImpl extends ClinicRepository {
  final ClinicRemoteDatasource _remote;

  ClinicRepositoryImpl({required ClinicRemoteDatasource remote})
    : _remote = remote;

  @override
  Future<PaginatedResult<Clinic>> getAll({
    int? page,
    int? pageSize,
    String? cnpj,
    String? name,
    bool? active,
  }) async {
    final result = await _remote.getAll(
      active: active,
      cnpj: cnpj,
      name: name,
      page: page,
      pageSize: pageSize,
    );
    return PaginatedResult<Clinic>(
      items: result.items.map((dto) => dto.toEntity()).toList(),
      page: result.page,
      pageSize: result.pageSize,
      totalItems: result.totalItems,
      totalPages: result.totalPages,
    );
  }

  @override
  Future<void> add({required Clinic clinic}) async {
    await _remote.create(clinic: CreateClinicDto.fromEntity(clinic: clinic));
  }

  @override
  Future<void> update({required Clinic clinic}) async {
    await _remote.update(clinic: UpdateClinicDto.fromEntity(clinic: clinic));
  }

  @override
  Future<Clinic?> getClinicById({required String id}) async {
    final dto = await _remote.getClinicById(id: id);
    return dto?.toEntity();
  }
}
