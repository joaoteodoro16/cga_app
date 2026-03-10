
import 'package:cga_app/app/core/controller/base_controller.dart';
import 'package:cga_app/app/core/controller/base_dialog_pagination_controller.dart';
import 'package:cga_app/app/core/controller/base_pagination_controller.dart';
import 'package:cga_app/app/core/pagination/entities/paginated_result.dart';
import 'package:cga_app/app/features/clinics/domain/entities/clinic.dart';
import 'package:cga_app/app/features/groups/domain/entities/group.dart';
import 'package:cga_app/app/features/patients/domain/entities/patient.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class SearchGroupsController extends BaseDialogPaginationController<Group>{
  
  final groupSelected = Rxn<Group>();

  Future<void> loadGroupById(String id) async {
    try {
      final clinic = await _getClinicByIdUsecase.call(id: id);
      groupSelected.value = clinic;
    } catch (e) {
      groupSelected.value = null;
    }
  }

  void selectGroup(Group? clinic) {
    groupSelected.value = clinic;
  }

  @override
  Future<PaginatedResult<dynamic>> fetch({required int page, required int pageSize}) {
    // TODO: implement fetch
    throw UnimplementedError();
  }

}