import 'package:cga_app/app/core/pagination/entities/paginated_result.dart';
import 'package:cga_app/app/features/groups/domain/entities/group.dart';

abstract class GetGroupsUsecase {
  Future<PaginatedResult<Group>> call({
    String? name,
    String? clinicId,
    bool? active,
    required int page,
    required int pageSize,
  });
}
