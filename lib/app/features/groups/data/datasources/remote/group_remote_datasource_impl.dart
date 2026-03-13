import 'package:cga_app/app/core/constants/text_constants.dart';
import 'package:cga_app/app/core/exceptions/exceptions.dart';
import 'package:cga_app/app/core/pagination/dtos/paginated_dto.dart';
import 'package:cga_app/app/core/rest_client/app_rest_client.dart';
import 'package:cga_app/app/core/rest_client/end_points/app_end_points.dart';
import 'package:cga_app/app/features/groups/data/dtos/create_group_dto.dart';
import 'package:cga_app/app/features/groups/data/dtos/get_groups_dto.dart';
import 'package:cga_app/app/features/groups/data/dtos/get_groups_request_dto.dart';
import 'package:cga_app/app/features/groups/data/dtos/update_group_dto.dart';
import './group_remote_datasource.dart';

class GroupRemoteDatasourceImpl extends GroupRemoteDatasource {
  final AppRestClient _dio;

  GroupRemoteDatasourceImpl({required AppRestClient dio}) : _dio = dio;

  @override
  Future<PaginatedDto<GetGroupsDto>> getAll({
    required GetGroupsRequestDto request,
  }) async {
    try {
      final apiResponse = await _dio.auth().getApi(
        AppEndPoints.getGroups,
        queryParameters: request.toMap()
          ..removeWhere((key, value) => value == null),
        fromMapT: (map) {
          final data = map['data'];
          return PaginatedDto<GetGroupsDto>.fromMap(
            data,
            (item) => GetGroupsDto.fromMap(item),
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
  Future<void> add({required CreateGroupDto group}) async {
    try {
      final apiResponse = await _dio.auth().postApi<CreateGroupDto>(
        AppEndPoints.addGroups,
        data: group.toMap(),
        fromMapT: (map) => CreateGroupDto.fromMap(map),
      );

      if (!apiResponse.success) {
        throw AppException(
          message: apiResponse.message ?? TextConstants.erroInesperado,
        );
      }
    } on AppRestClientException catch (e) {
      throw AppException(message: e.message);
    } catch (e) {
      throw AppException(message: TextConstants.erroInesperado);
    }
  }

  @override
  Future<void> update({required UpdateGroupDto group}) async {
    try {
      final apiResponse = await _dio.auth().putApi<UpdateGroupDto>(
        AppEndPoints.updateGroups,
        data: group.toMap(),
        fromMapT: (map) => UpdateGroupDto.fromMap(map),
      );

      if (!apiResponse.success) {
        throw AppException(
          message: apiResponse.message ?? TextConstants.erroInesperado,
        );
      }
    } on AppRestClientException catch (e) {
      throw AppException(message: e.message);
    } catch (e) {
      throw AppException(message: TextConstants.erroInesperado);
    }
  }
}
