import 'package:cga_app/app/core/pagination/entities/paginated_result.dart';
import 'package:cga_app/app/features/patients/data/datasources/remote/patient_remote_datasource.dart';
import 'package:cga_app/app/features/patients/data/dtos/create_patient_dto.dart';
import 'package:cga_app/app/features/patients/data/dtos/update_patient_dto.dart';
import 'package:cga_app/app/features/patients/domain/entities/patient.dart';
import 'package:cga_app/app/features/patients/domain/repositories/patient_repository.dart';

class PatientRepositoryImpl extends PatientRepository {
  final PatientRemoteDatasource _datasource;

  PatientRepositoryImpl({required PatientRemoteDatasource datasource})
    : _datasource = datasource;

  @override
  Future<void> add({required Patient patient}) async {
    await _datasource.add(
      patient: CreatePatientDto.fromEntity(patient: patient),
    );
  }

  @override
  Future<PaginatedResult<Patient>> getAll({
    String? name,
    String? groupId,
    bool? active,
    required int page,
    required int pageSize,
  }) async {
    final result = await _datasource.getAll(
      page: page,
      pageSize: pageSize,
      active: active,
      groupId: groupId,
      name: name,
    );

    return PaginatedResult<Patient>(
      items: result.items.map((dto) => dto.toEntity()).toList(),
      page: result.page,
      pageSize: result.pageSize,
      totalItems: result.totalItems,
      totalPages: result.totalPages,
    );
  }

  @override
  Future<void> update({required Patient patient}) async {
    await _datasource.update(
      patient: UpdatePatientDto.fromEntity(patient: patient),
    );
  }
}
