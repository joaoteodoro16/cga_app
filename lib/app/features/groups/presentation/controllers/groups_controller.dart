import 'package:cga_app/app/core/controller/base_pagination_controller.dart';
import 'package:cga_app/app/core/exceptions/exceptions.dart';
import 'package:cga_app/app/core/pagination/entities/paginated_result.dart';
import 'package:cga_app/app/core/ui/helpers/messager.dart';
import 'package:cga_app/app/features/clinics/domain/entities/clinic.dart';
import 'package:cga_app/app/features/groups/domain/entities/group.dart';
import 'package:cga_app/app/features/groups/domain/usecases/contracts/get_groups_usecase.dart';
import 'package:get/get.dart';

class GroupsController extends BasePaginationController<Group> {
  final GetGroupsUsecase _getGroupsUsecase;

  GroupsController({required GetGroupsUsecase getGroupsUsecase})
    : _getGroupsUsecase = getGroupsUsecase;

  final Rxn<Clinic> _clinicSeleted = Rxn();
  Clinic? get clinicSelected => _clinicSeleted.value;
  set clinicSelected(Clinic? clinic) => _clinicSeleted.value = clinic;

  @override
  Future<PaginatedResult<Group>> fetch({
    required int page,
    required int pageSize,
  }) async{
    try {
      return await _getGroupsUsecase.call(page: page, pageSize: pageSize);
    } on AppException catch (e) {
      showMessage(Messager.error(message: e.message));
      rethrow;
    } catch (e) {
      showMessage(Messager.error(message: e.toString()));
      rethrow;
    }
  }
}
