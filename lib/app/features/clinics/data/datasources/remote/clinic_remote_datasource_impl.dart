import 'package:cga_app/app/core/constants/text_constants.dart';
import 'package:cga_app/app/core/exceptions/exceptions.dart';
import 'package:cga_app/app/core/pagination/dtos/paginated_dto.dart';
import 'package:cga_app/app/core/rest_client/app_rest_client.dart';
import 'package:cga_app/app/core/rest_client/end_points/app_end_points.dart';
import 'package:cga_app/app/features/clinics/data/datasources/remote/clinic_remote_datasource.dart';
import 'package:cga_app/app/features/clinics/data/dtos/create_clinic_dto.dart';
import 'package:cga_app/app/features/clinics/data/dtos/get_clinic_by_id_dto.dart';
import 'package:cga_app/app/features/clinics/data/dtos/get_clinics_dto.dart';
import 'package:cga_app/app/features/clinics/data/dtos/update_clinic_dto.dart';

class ClinicRemoteDatasourceImpl extends ClinicRemoteDatasource {
  final AppRestClient _dio;

  ClinicRemoteDatasourceImpl({required AppRestClient dio}) : _dio = dio;

  @override
  Future<PaginatedDto<GetClinicsDto>> getAll({
    int? page,
    int? pageSize,
    String? cnpj,
    String? name,
    bool? active,
  }) async {
    try {
      final apiResponse = await _dio.auth().getApi<PaginatedDto<GetClinicsDto>>(
        AppEndPoints.getClinics,
        queryParameters: {
          'Page': page,
          'pageSize': pageSize,
          'Cnpj': cnpj,
          'Nome': name,
          'Ativo': active,
        }..removeWhere((key, value) => value == null),
        fromMapT: (map) {
          final data = map['data'];

          return PaginatedDto<GetClinicsDto>.fromMap(
            data,
            (item) => GetClinicsDto.fromMap(item),
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
  Future<void> create({required CreateClinicDto clinic}) async {
    try {
      final apiResponse = await _dio.auth().postApi<CreateClinicDto>(
        AppEndPoints.addClinic,
        data: clinic.toMap(),
        fromMapT: (map) => CreateClinicDto.fromMap(map),
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
  Future<void> update({required UpdateClinicDto clinic}) async {
    try {
      final apiResponse = await _dio.auth().putApi(
        AppEndPoints.updateClinic,
        fromMapT: (map) => UpdateClinicDto.fromMap(map),
        data: clinic.toMap(),
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
  Future<GetClinicByIdDto?> getClinicById({required String id}) async {
    try {
      final apiResponse = await _dio.auth().getApi(
        AppEndPoints.getCliniById,
        queryParameters: {'id': id},
        fromMapT: (map) {
          final data = map['data'];
          return GetClinicByIdDto.fromMap(data);
        },
      );
      return apiResponse.data;
    } on AppRestClientException catch (e) {
      throw AppException(message: e.message);
    } catch (e) {
      throw AppException(message: TextConstants.erroInesperado);
    }
  }
}
