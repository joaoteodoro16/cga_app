import 'package:cga_app/app/core/pagination/entities/paginated_result.dart';

import 'package:cga_app/app/features/groups/domain/entities/group.dart';
import 'package:cga_app/app/features/groups/domain/repositories/group_repository.dart';

import '../contracts/get_groups_usecase.dart';

class GetGroupsUsecaseImpl extends GetGroupsUsecase {
  final GroupRepository _groupRepository;

  GetGroupsUsecaseImpl({required GroupRepository groupRepository})
    : _groupRepository = groupRepository;

  @override
  Future<PaginatedResult<Group>> call({
    String? name,
    String? clinicId,
    bool? active,
    required int page,
    required int pageSize,
  }) async {
    return await _groupRepository.getAll(page: page, pageSize: pageSize);
  }
}
