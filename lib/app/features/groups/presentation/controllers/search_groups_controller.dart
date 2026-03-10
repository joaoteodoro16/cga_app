import 'package:cga_app/app/core/controller/base_dialog_pagination_controller.dart';
import 'package:cga_app/app/core/pagination/entities/paginated_result.dart';
import 'package:cga_app/app/features/groups/domain/entities/group.dart';
import 'package:cga_app/app/features/groups/domain/usecases/contracts/get_groups_usecase.dart';

class SearchGroupsController extends BaseDialogPaginationController<Group> {
  final GetGroupsUsecase _getGroupsUsecase;

  SearchGroupsController({required GetGroupsUsecase getGroupsUsecase})
    : _getGroupsUsecase = getGroupsUsecase;

  @override
  String? getItemId(Group item) {
    return item.id;
  }

  @override
  Future<PaginatedResult<Group>> fetch({
    required int page,
    required int pageSize,
  }) async {
    return await _getGroupsUsecase.call(page: page, pageSize: pageSize);
  }
}
