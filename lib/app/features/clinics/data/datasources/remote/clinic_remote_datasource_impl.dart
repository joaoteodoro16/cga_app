import 'package:cga_app/app/core/constants/text_constants.dart';
import 'package:cga_app/app/core/exceptions/exceptions.dart';
import 'package:cga_app/app/core/pagination/dtos/paginated_dto.dart';
import 'package:cga_app/app/core/rest_client/app_rest_client.dart';
import 'package:cga_app/app/core/rest_client/end_points/app_end_points.dart';
import 'package:cga_app/app/features/clinics/data/datasources/remote/clinic_remote_datasource.dart';
import 'package:cga_app/app/features/clinics/data/dtos/clinic_dto.dart';

class ClinicRemoteDatasourceImpl extends ClinicRemoteDatasource {
  final AppRestClient _dio;

  ClinicRemoteDatasourceImpl({required AppRestClient dio}) : _dio = dio;

  @override
  Future<PaginatedDto<ClinicDto>> getAll({
    int? page,
    int? pageSize,
    String? cnpj,
    String? name,
    bool? active,
  }) async {
    try {
      final apiResponse = await _dio.auth().getApi<PaginatedDto<ClinicDto>>(
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

          return PaginatedDto<ClinicDto>.fromMap(
            data,
            (item) => ClinicDto.fromMap(item),
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
  Future<void> add({required ClinicDto clinic}) async {
    try {
      final apiResponse = await _dio.auth().postApi<ClinicDto>(
        AppEndPoints.addClinic,
        data: clinic.toMap(),
        fromMapT: (map) => ClinicDto.fromMap(map),
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
  Future<void> update({required ClinicDto clinic}) async {
    try {
      final apiResponse = await _dio.auth().putApi(
        AppEndPoints.updateClinic,
        fromMapT: (map) => ClinicDto.fromMap(map),
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
  Future<ClinicDto?> getClinicById({required String id}) async {
    try {
      final apiResponse = await _dio.auth().getApi(
        AppEndPoints.getCliniById,
        queryParameters: {'id': id},
        fromMapT: (map) {
          final data = map['data'];
          return ClinicDto.fromMap(data);
        } 
          
      );
      return apiResponse.data;
    } on AppRestClientException catch (e) {
      throw AppException(message: e.message);
    } catch (e) {
      throw AppException(message: TextConstants.erroInesperado);
    }
  }
}
