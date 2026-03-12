import 'package:cga_app/app/core/pagination/dtos/paginated_dto.dart';
import 'package:cga_app/app/features/patients/data/dtos/create_patient_dto.dart';
import 'package:cga_app/app/features/patients/data/dtos/get_all_patients_dto.dart';
import 'package:cga_app/app/features/patients/data/dtos/update_patient_dto.dart';

abstract class PatientRemoteDatasource {
  Future<PaginatedDto<GetAllPatientsDto>> getAll({
    String? name,
    String? groupId,
    String? clinicId,
    bool? active,
    String? phone,
    required int page,
    required int pageSize,
  });
  Future<void> add({required CreatePatientDto patient});
  Future<void> update({required UpdatePatientDto patient});
}
