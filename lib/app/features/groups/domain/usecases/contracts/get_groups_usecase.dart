import 'package:cga_app/app/core/pagination/entities/paginated_result.dart';
import 'package:cga_app/app/features/groups/domain/entities/group.dart';
import 'package:cga_app/app/features/groups/domain/usecases/params/get_all_groups_params.dart';

abstract class GetGroupsUsecase {
  Future<PaginatedResult<Group>> call({required GetAllGroupsParams params});
}
