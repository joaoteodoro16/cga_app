import 'package:cga_app/app/core/pagination/entities/paginated_result.dart';
import 'package:cga_app/app/features/patients/domain/entities/patient.dart';

abstract class PatientRepository {

  Future<PaginatedResult<Patient>> getAll({String? name, String? groupId, bool? active, required int page,required int pageSize});
  Future<void> add({required Patient patient});
  Future<void> update({required Patient patient});
}