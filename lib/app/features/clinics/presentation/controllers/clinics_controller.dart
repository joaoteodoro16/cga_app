import 'package:cga_app/app/core/controller/base_pagination_controller.dart';
import 'package:cga_app/app/core/enums/entity_status_enum.dart';
import 'package:cga_app/app/core/enums/entity_status_filter_enum.dart';
import 'package:cga_app/app/core/exceptions/exceptions.dart';
import 'package:cga_app/app/core/extensions/string_extension.dart';
import 'package:cga_app/app/core/pagination/entities/paginated_result.dart';
import 'package:cga_app/app/core/ui/helpers/messager.dart';
import 'package:cga_app/app/features/clinics/domain/entities/clinic.dart';
import 'package:cga_app/app/features/clinics/domain/usecases/contract/add_clinic_usecase.dart';
import 'package:cga_app/app/features/clinics/domain/usecases/contract/get_clinics_usecase.dart';
import 'package:cga_app/app/features/clinics/domain/usecases/contract/update_clinic_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClinicsController extends BasePaginationController<Clinic> {
  final GetClinicsUsecase _getClinicsUsecase;
  final AddClinicUsecase _addClinicUsecase;
  final UpdateClinicUsecase _updateClinicUsecase;

  ClinicsController({
    required GetClinicsUsecase getClinicsUsecase,
    required AddClinicUsecase addClinicUsecase,
    required UpdateClinicUsecase updateClinicUsecase,
  }) : _getClinicsUsecase = getClinicsUsecase,
       _addClinicUsecase = addClinicUsecase,
       _updateClinicUsecase = updateClinicUsecase;

  /// FORM CONTROLLERS
  final nameEC = TextEditingController();
  final cnpjEC = TextEditingController();
  final phoneEC = TextEditingController();
  final addressEC = TextEditingController();

  /// FILTER CONTROLLERS
  final nameFilterEC = TextEditingController();
  final cnpjFilterEC = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final _active = Rx<EntityStatusEnum>(EntityStatusEnum.active);
  bool? get active => _active.value.toBoolean();
  set active(EntityStatusEnum value) => _active.value = value;

  final _activeFilter = Rx<EntityStatusFilterEnum>(EntityStatusFilterEnum.all);
  bool? get activeFilter => _activeFilter.value.toBoolean();
  set activeFilter(EntityStatusFilterEnum? value) =>
      _activeFilter.value = value ?? EntityStatusFilterEnum.all;

  Clinic? editingClinic;

  @override
  void onControllerReady() async {
    await load();
  }

  @override
  Future<PaginatedResult<Clinic>> fetch({
    required int page,
    required int pageSize,
  }) async {
    try {
      return await _getClinicsUsecase(
        page: page,
        pageSize: pageSize,
        active: activeFilter,
        cnpj: cnpjFilterEC.text.nullIfEmpty,
        name: nameFilterEC.text.nullIfEmpty,
      );
    } on AppException catch (e) {
      showMessage(Messager.error(message: e.message));
      rethrow;
    } catch (e) {
      showMessage(Messager.error(message: e.toString()));
      rethrow;
    }
  }

  Future<void> addClinic() async {
    try {
      showLoading();

      final clinic = _buildEntity();

      await _addClinicUsecase.call(clinic: clinic);

      hideLoading();

      clearForm();
      showMessage(Messager.success(message: "Clínica cadastrada com sucesso!"));
      await load();
    } on AppException catch (e) {
      showMessage(Messager.error(message: e.message));
    } catch (e) {
      showMessage(Messager.error(message: e.toString()));
    }
  }

  Clinic _buildEntity() {
    return Clinic(
      id: editingClinic?.id ?? '',
      name: nameEC.text,
      cnpj: cnpjEC.text.nullIfEmpty,
      phone: phoneEC.text.nullIfEmpty,
      address: addressEC.text.nullIfEmpty,
      groups: [],
      active: active ?? true,
    );
  }

  Future<void> updateClinic() async {
    try {
      showLoading();

      final clinic = _buildEntity();

      await _updateClinicUsecase.call(clinic: clinic);

      hideLoading();

      clearForm();
      showMessage(Messager.success(message: "Clínica editada com sucesso!"));
      await load();
    } on AppException catch (e) {
      showMessage(Messager.error(message: e.message));
    } catch (e) {
      showMessage(Messager.error(message: e.toString()));
    }
  }

  void clearForm() {
    nameEC.clear();
    cnpjEC.clear();
    phoneEC.clear();
    addressEC.clear();
    cleanFilter();
    editingClinic = null;
  }

  Future<void> cleanFilter() async {
    nameFilterEC.clear();
    cnpjFilterEC.clear();
    activeFilter = EntityStatusFilterEnum.all;
    await load();
  }

  @override
  void onClose() {
    nameEC.dispose();
    cnpjEC.dispose();
    phoneEC.dispose();
    addressEC.dispose();
    nameFilterEC.dispose();
    cnpjFilterEC.dispose();
    super.onClose();
  }
}
