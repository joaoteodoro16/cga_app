import 'package:cga_app/app/core/controller/base_pagination_controller.dart';
import 'package:cga_app/app/core/enums/entity_status_enum.dart';
import 'package:cga_app/app/core/enums/entity_status_filter_enum.dart';
import 'package:cga_app/app/core/pagination/entities/paginated_result.dart';
import 'package:cga_app/app/features/groups/domain/entities/group.dart';
import 'package:cga_app/app/features/patients/domain/entities/patient.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class PatientsController extends BasePaginationController {
  final nameFilterEC = TextEditingController();
  final phoneFilterEC = TextEditingController();

  final _activeFilter = Rx<EntityStatusFilterEnum>(EntityStatusFilterEnum.all);
  bool? get activeFilter => _activeFilter.value.toBoolean();
  set activeFilter(EntityStatusFilterEnum? value) =>
      _activeFilter.value = value ?? EntityStatusFilterEnum.all;

    final Rxn<Group> _groupFilterSeleted = Rxn();
  Group? get groupFilterSelected => _groupFilterSeleted.value;
  set groupFilterSelected(Group? group) =>
      _groupFilterSeleted.value = group;

  final nameEC = TextEditingController();
  final phoneEC = TextEditingController();

  final _active = Rx<EntityStatusEnum>(EntityStatusEnum.active);
  bool? get active => _active.value.toBoolean();
  set active(EntityStatusEnum value) => _active.value = value;

  final formKey = GlobalKey<FormState>();

  Patient? editingPatient;

  @override
  Future<PaginatedResult<dynamic>> fetch({
    required int page,
    required int pageSize,
  }) {
    throw UnimplementedError();
  }

  void clearFilters() {
    nameFilterEC.clear();
    phoneFilterEC.clear();
  }

  void clearForm() {
    nameEC.clear();
    phoneEC.clear();
  }

  @override
  void dispose() {
    nameEC.dispose();
    phoneEC.dispose();
    nameFilterEC.dispose();
    phoneEC.dispose();
    super.dispose();
  }
}
