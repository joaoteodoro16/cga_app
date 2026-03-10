import 'package:cga_app/app/core/pagination/entities/paginated_result.dart';
import 'package:cga_app/app/features/groups/domain/entities/group.dart';

abstract class GroupRepository {
  Future<PaginatedResult<Group>> getAll({String? name, String? clinicId, bool? active,required int page,required int pageSize});

  Future<void> add({required Group group});
  Future<void> update({required Group group});
}