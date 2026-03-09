import 'package:cga_app/app/core/constants/text_constants.dart';
import 'package:cga_app/app/core/exceptions/exceptions.dart';
import 'package:cga_app/app/core/pagination/dtos/paginated_dto.dart';
import 'package:cga_app/app/core/rest_client/app_rest_client.dart';
import 'package:cga_app/app/core/rest_client/end_points/app_end_points.dart';
import 'package:cga_app/app/features/groups/data/dtos/group_dto.dart';
import './group_remote_datasource.dart';

class GroupRemoteDatasourceImpl extends GroupRemoteDatasource {
  final AppRestClient _dio;

  GroupRemoteDatasourceImpl({required AppRestClient dio}) : _dio = dio;

  @override
  Future<PaginatedDto<GroupDto>> getAll({
    String? name,
    String? clinicId,
    bool? active,
    required int page,
    required int pageSize,
  }) async {
    try {
      final apiResponse = await _dio.auth().getApi(
        AppEndPoints.getGroups,
        fromMapT: (map) {
          final data = map['data'];
          return PaginatedDto<GroupDto>.fromMap(
            data,
            (item) => GroupDto.fromMap(item),
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
}
