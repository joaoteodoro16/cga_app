import 'package:cga_app/app/core/controller/base_pagination_controller.dart';
import 'package:cga_app/app/core/enums/entity_status_enum.dart';
import 'package:cga_app/app/core/enums/entity_status_filter_enum.dart';
import 'package:cga_app/app/core/exceptions/exceptions.dart';
import 'package:cga_app/app/core/extensions/string_extension.dart';
import 'package:cga_app/app/core/pagination/entities/paginated_result.dart';
import 'package:cga_app/app/core/ui/helpers/messager.dart';
import 'package:cga_app/app/core/util/date_util.dart';
import 'package:cga_app/app/features/clinics/domain/entities/clinic.dart';
import 'package:cga_app/app/features/groups/domain/entities/group.dart';
import 'package:cga_app/app/features/patients/domain/entities/patient.dart';
import 'package:cga_app/app/features/patients/domain/usecases/contracts/create_patient_usecase.dart';
import 'package:cga_app/app/features/patients/domain/usecases/contracts/get_patients_usecase.dart';
import 'package:cga_app/app/features/patients/domain/usecases/contracts/update_patient_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class PatientsController extends BasePaginationController {
  final GetPatientsUsecase _getPatientsUsecase;
  final CreatePatientUsecase _createPatientUsecase;
  final UpdatePatientUsecase _updatePatientUsecase;

  PatientsController({
    required GetPatientsUsecase getPatientsUsecase,
    required CreatePatientUsecase createPatientUsecase,
    required UpdatePatientUsecase updatePatientUsecase,
  }) : _getPatientsUsecase = getPatientsUsecase,
       _createPatientUsecase = createPatientUsecase,
       _updatePatientUsecase = updatePatientUsecase;

  final nameFilterEC = TextEditingController();
  final phoneFilterEC = TextEditingController();

  final _activeFilter = Rx<EntityStatusFilterEnum>(EntityStatusFilterEnum.all);
  bool? get activeFilter => _activeFilter.value.toBoolean();
  set activeFilter(EntityStatusFilterEnum? value) =>
      _activeFilter.value = value ?? EntityStatusFilterEnum.all;

  final Rxn<Group> _groupFilterSeleted = Rxn();
  Group? get groupFilterSelected => _groupFilterSeleted.value;
  set groupFilterSelected(Group? group) => _groupFilterSeleted.value = group;

  final Rxn<Clinic> _clinicFilterSelected = Rxn();
  Clinic? get clinicFilterSelected => _clinicFilterSelected.value;
  set clinicFilterSelected(Clinic? clinic) =>
      _clinicFilterSelected.value = clinic;

  final nameEC = TextEditingController();
  final phoneEC = TextEditingController();
  final startDateEC = TextEditingController();
  final endDateEC = TextEditingController();
  final startWeightEC = TextEditingController();

  final _active = Rx<EntityStatusEnum>(EntityStatusEnum.active);
  bool? get active => _active.value.toBoolean();
  set active(EntityStatusEnum value) => _active.value = value;

  final Rxn<Group> _groupSelected = Rxn();
  Group? get groupSelected => _groupSelected.value;
  set groupSelected(Group? group) => _groupSelected.value = group;

  final formKey = GlobalKey<FormState>();

  Patient? editingPatient;

  @override
  void onControllerReady() async {
    await load();
  }

  @override
  Future<PaginatedResult<dynamic>> fetch({
    required int page,
    required int pageSize,
  }) async {
    try {
      return await _getPatientsUsecase(
        page: page,
        pageSize: pageSize,
        name: nameFilterEC.text.nullIfEmpty,
        active: activeFilter,
        groupId: groupFilterSelected?.id,
        phone: phoneFilterEC.text.nullIfEmpty,
        clinicId: clinicFilterSelected?.id,
      );
    } on AppException catch (e) {
      showMessage(Messager.error(message: e.message));
      rethrow;
    } catch (e) {
      showMessage(Messager.error(message: e.toString()));
      rethrow;
    }
  }

  Future<void> addPatient() async {
    try {
      showLoading();

      final patient = _buildEntity();

      await _createPatientUsecase.call(patient: patient);

      hideLoading();

      clearForm();
      showMessage(
        Messager.success(message: "Paciente cadastrado com sucesso!"),
      );
      await load();
    } on AppException catch (e) {
      showMessage(Messager.error(message: e.message));
    } catch (e) {
      showMessage(Messager.error(message: e.toString()));
    }
  }

  Future<void> updatePatient() async {
    try {
      showLoading();

      final patient = _buildEntity();

      await _updatePatientUsecase.call(patient: patient);

      hideLoading();

      clearForm();
      showMessage(Messager.success(message: "Paciente editado com sucesso!"));
      await load();
    } on AppException catch (e) {
      showMessage(Messager.error(message: e.message));
    } catch (e) {
      showMessage(Messager.error(message: e.toString()));
    }
  }

  Patient _buildEntity() {
    return Patient(
      id: editingPatient?.id ?? '',
      nome: nameEC.text,
      telefone: phoneEC.text,
      dataInicio: DateUtil.pTBRDateToDateTime(startDateEC.text),
      dataEncerramento: DateUtil.pTBRDateToDateTime(endDateEC.text),
      pesoInicial: startWeightEC.text.toDoubleOrThrow,
      ativo: active ?? true,
      grupoId: groupSelected?.id ?? '',
      grupo: groupSelected,
    );
  }

  void clearFilters() async {
    nameFilterEC.clear();
    phoneFilterEC.clear();
    activeFilter = EntityStatusFilterEnum.all;
    groupFilterSelected = null;
    clinicFilterSelected = null;
    await load();
  }

  void clearForm() {
    nameEC.clear();
    phoneEC.clear();
    startDateEC.clear();
    endDateEC.clear();
    startWeightEC.clear();
    groupSelected = null;
  }

  @override
  void dispose() {
    nameEC.dispose();
    phoneEC.dispose();
    startDateEC.dispose();
    endDateEC.dispose();
    startWeightEC.dispose();
    nameFilterEC.dispose();
    phoneEC.dispose();
    super.dispose();
  }
}
