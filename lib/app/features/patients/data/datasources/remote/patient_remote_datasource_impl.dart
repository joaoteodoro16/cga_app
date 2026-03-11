import 'package:cga_app/app/core/constants/text_constants.dart';
import 'package:cga_app/app/core/exceptions/exceptions.dart';
import 'package:cga_app/app/core/pagination/dtos/paginated_dto.dart';
import 'package:cga_app/app/core/rest_client/app_rest_client.dart';
import 'package:cga_app/app/core/rest_client/end_points/app_end_points.dart';
import 'package:cga_app/app/features/patients/data/dtos/create_patient_dto.dart';
import 'package:cga_app/app/features/patients/data/dtos/get_all_patients_dto.dart';
import 'package:cga_app/app/features/patients/data/dtos/update_patient_dto.dart';

import './patient_remote_datasource.dart';

class PatientRemoteDatasourceImpl extends PatientRemoteDatasource {
  final AppRestClient _dio;

  PatientRemoteDatasourceImpl({required AppRestClient dio}) : _dio = dio;

  @override
  Future<PaginatedDto<GetAllPatientsDto>> getAll({
    String? name,
    String? groupId,
    bool? active,
    required int page,
    required int pageSize,
  }) async {
    try {
      final apiResponse = await _dio.auth().getApi(
        AppEndPoints.getPatients,
        queryParameters: {'nome': name, 'grupoId': groupId, 'ativo': active},
        fromMapT: (map) {
          final data = map['data'];
          return PaginatedDto<GetAllPatientsDto>.fromMap(
            data,
            (item) => GetAllPatientsDto.fromMap(item),
          );
        },
      );
      return apiResponse.data!;
    } on AppRestClientException catch (e) {
      throw AppException(message: e.message);
    } catch (e) {
      throw AppException(message: TextConstants.erroInesperado);
    }
  }

  @override
  Future<void> add({required CreatePatientDto patient}) async {
    try {
      final apiResponse = await _dio.auth().postApi<CreatePatientDto>(
        AppEndPoints.addPatients,
        data: patient.toMap(),
        fromMapT: (map) => CreatePatientDto.fromMap(map),
      );

      if (apiResponse.data == null) {
        throw AppException(message: apiResponse.message ?? '');
      }
    } on AppRestClientException catch (e) {
      throw AppException(message: e.message);
    } catch (e) {
      throw AppException(message: TextConstants.erroInesperado);
    }
  }

  @override
  Future<void> update({required UpdatePatientDto patient}) async {
    try {
      final apiResponse = await _dio.auth().postApi<UpdatePatientDto>(
        AppEndPoints.updatePatients,
        data: patient.toMap(),
        fromMapT: (map) => UpdatePatientDto.fromMap(map),
      );

      if (apiResponse.data == null) {
        throw AppException(message: apiResponse.message ?? '');
      }
    } on AppRestClientException catch (e) {
      throw AppException(message: e.message);
    } catch (e) {
      throw AppException(message: TextConstants.erroInesperado);
    }
  }
}
