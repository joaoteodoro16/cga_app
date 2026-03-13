import 'package:cga_app/app/core/controller/base_dialog_pagination_controller.dart';
import 'package:cga_app/app/core/pagination/entities/paginated_result.dart';
import 'package:cga_app/app/features/groups/data/enums/search_group_filter_item.dart';
import 'package:cga_app/app/features/groups/domain/entities/group.dart';
import 'package:cga_app/app/features/groups/domain/usecases/contracts/get_groups_usecase.dart';
import 'package:cga_app/app/features/groups/domain/usecases/params/get_all_groups_params.dart';

class SearchGroupsController extends BaseDialogPaginationController<Group> {
  final GetGroupsUsecase _getGroupsUsecase;

  SearchGroupsController({required GetGroupsUsecase getGroupsUsecase})
    : _getGroupsUsecase = getGroupsUsecase;

  @override
  String? getItemId(Group item) {
    return item.id;
  }

  String? _name = "";
  String? _clinicName = "";

  @override
  Future<PaginatedResult<Group>> fetch({
    required int page,
    required int pageSize,
  }) async {
    _setFilterText();

    return await _getGroupsUsecase.call(
      params: GetAllGroupsParams(
        page: page,
        pageSize: pageSize,
        name: _name,
        active: true,
        clinicName: _clinicName
      ),
    );
  }

  void _setFilterText() {
    _name = null;
    _clinicName = null;

    final text = searchText.text.trim();
    final filterKey = filterSelected?.key;

    if (text.isEmpty) return;

    switch (filterKey) {
      case SearchGroupFilterItem.clinicNameKey:
        _clinicName = text;
        break;
      case SearchGroupFilterItem.nameKey:
        _name = text;
        break;
    }
  }
}
