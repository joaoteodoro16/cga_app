import 'package:cga_app/app/core/pagination/entities/paginated_result.dart';
import 'package:cga_app/app/features/groups/data/datasources/remote/group_remote_datasource.dart';
import 'package:cga_app/app/features/groups/data/dtos/create_group_dto.dart';
import 'package:cga_app/app/features/groups/data/dtos/update_group_dto.dart';
import 'package:cga_app/app/features/groups/domain/entities/group.dart';
import 'package:cga_app/app/features/groups/domain/repositories/group_repository.dart';

class GroupRepositoryImpl extends GroupRepository {
  final GroupRemoteDatasource _remote;

  GroupRepositoryImpl({required GroupRemoteDatasource remote})
    : _remote = remote;

  @override
  Future<PaginatedResult<Group>> getAll({
    String? name,
    String? clinicId,
    bool? active,
    required int page,
    required int pageSize,
  }) async {
    final result = await _remote.getAll(
      page: page,
      pageSize: pageSize,
      active: active,
      clinicId: clinicId,
      name: name,
    );

    return PaginatedResult<Group>(
      items: result.items.map((dto) => dto.toEntity()).toList(),
      page: result.page,
      pageSize: result.pageSize,
      totalItems: result.totalItems,
      totalPages: result.totalPages,
    );
  }

  @override
  Future<void> add({required Group group}) async {
    return await _remote.add(group: CreateGroupDto.fromEntity(group));
  }

  @override
  Future<void> update({required Group group}) async {
    return await _remote.update(group: UpdateGroupDto.fromEntity(group: group));
  }
}
