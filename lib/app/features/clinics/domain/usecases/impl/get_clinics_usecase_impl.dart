import 'package:cga_app/app/core/pagination/entities/paginated_result.dart';
import 'package:cga_app/app/features/clinics/domain/entities/clinic.dart';
import 'package:cga_app/app/features/clinics/domain/repositories/clinic_repository.dart';

import '../contract/get_clinics_usecase.dart';

class GetClinicsUsecaseImpl extends GetClinicsUsecase {
  final ClinicRepository _clinicRepository;

  GetClinicsUsecaseImpl({required ClinicRepository clinicRepository})
      : _clinicRepository = clinicRepository;

  @override
  Future<PaginatedResult<Clinic>> call({
    int? page,
    int? pageSize,
    String? cnpj,
    String? name,
    bool? active,
  }) async {
    return await _clinicRepository.getAll(
      active: active,
      cnpj: cnpj,
      name: name,
      page: page,
      pageSize: pageSize,
    );
  }
}