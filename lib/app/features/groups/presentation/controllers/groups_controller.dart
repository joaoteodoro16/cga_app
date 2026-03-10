import 'package:cga_app/app/core/controller/base_pagination_controller.dart';
import 'package:cga_app/app/core/enums/entity_status_enum.dart';
import 'package:cga_app/app/core/enums/entity_status_filter_enum.dart';
import 'package:cga_app/app/core/exceptions/exceptions.dart';
import 'package:cga_app/app/core/pagination/entities/paginated_result.dart';
import 'package:cga_app/app/core/ui/helpers/messager.dart';
import 'package:cga_app/app/features/clinics/domain/entities/clinic.dart';
import 'package:cga_app/app/features/groups/domain/entities/group.dart';
import 'package:cga_app/app/features/groups/domain/usecases/contracts/add_group_usecase.dart';
import 'package:cga_app/app/features/groups/domain/usecases/contracts/get_groups_usecase.dart';
import 'package:cga_app/app/features/groups/domain/usecases/contracts/update_group_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupsController extends BasePaginationController<Group> {
  final GetGroupsUsecase _getGroupsUsecase;
  final AddGroupUsecase _addGroupUsecase;
  final UpdateGroupUsecase _updateGroupUsecase;

  GroupsController({
    required GetGroupsUsecase getGroupsUsecase,
    required AddGroupUsecase addGroupUsecase,
    required UpdateGroupUsecase updateGroupUsecase,
  }) : _getGroupsUsecase = getGroupsUsecase,
       _addGroupUsecase = addGroupUsecase,
       _updateGroupUsecase = updateGroupUsecase;

  final nameFilterEC = TextEditingController();
  final Rxn<Clinic> _clinicFilterSeleted = Rxn();
  Clinic? get clinicFilterSelected => _clinicFilterSeleted.value;
  set clinicFilterSelected(Clinic? clinic) =>
      _clinicFilterSeleted.value = clinic;

  final _activeFilter = Rx<EntityStatusFilterEnum>(EntityStatusFilterEnum.all);
  bool? get activeFilter => _activeFilter.value.toBoolean();
  set activeFilter(EntityStatusFilterEnum? value) =>
      _activeFilter.value = value ?? EntityStatusFilterEnum.all;

  //Cadastro
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final descriptionEC = TextEditingController();
  final Rxn<Clinic> _clinicSelected = Rxn();

  Clinic? get clinicSelected => _clinicSelected.value;
  set clinicSelected(Clinic? clinic) => _clinicSelected.value = clinic;

  final _active = Rx<EntityStatusEnum>(EntityStatusEnum.active);
  bool? get active => _active.value.toBoolean();
  set active(EntityStatusEnum value) => _active.value = value;

  Group? editingGroup;

  @override
  void onControllerReady() async {
    await load();
    super.onControllerReady();
  }

  @override
  Future<PaginatedResult<Group>> fetch({
    required int page,
    required int pageSize,
  }) async {
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

  Future<void> addGroup() async {
    try {
      showLoading();
      final entity = _buildEntity();
      await _addGroupUsecase.call(group: entity);
      hideLoading();
    } on AppException catch (e) {
      showMessage(Messager.error(message: e.message));
    } catch (e) {
      showMessage(Messager.error(message: e.toString()));
    }
  }

  Future<void> updateGroup() async {
    try {
      showLoading();
      final entity = _buildEntity();
      await _updateGroupUsecase.call(group: entity);
      hideLoading();
    } on AppException catch (e) {
      showMessage(Messager.error(message: e.message));
    } catch (e) {
      showMessage(Messager.error(message: e.toString()));
    }
  }

  Future<void> search() async {
    await load(newPage: 1);
  }

  Group _buildEntity() {
    return Group(
      id: editingGroup?.id ?? '',
      name: nameEC.text,
      clinicId: clinicSelected?.id ?? editingGroup?.clinicId ?? '',
      patients: [],
      active: active ?? false,
    );
  }

  void cleanForm() {
    nameEC.clear();
    descriptionEC.clear();
    clinicSelected = null;
  }

  void cleanFilters() {
    nameFilterEC.clear();
    activeFilter = EntityStatusFilterEnum.all;
    clinicFilterSelected = null;
  }

  @override
  void dispose() {
    cleanFilters();
    cleanForm();
    nameEC.dispose();
    nameFilterEC.dispose();
    super.dispose();
  }
}
