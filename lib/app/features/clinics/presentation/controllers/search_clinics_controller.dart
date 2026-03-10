import 'package:cga_app/app/core/controller/base_dialog_pagination_controller.dart';
import 'package:cga_app/app/core/exceptions/exceptions.dart';
import 'package:cga_app/app/core/pagination/entities/paginated_result.dart';
import 'package:cga_app/app/features/clinics/data/enums/search_clinic_filter_item.dart';
import 'package:cga_app/app/features/clinics/domain/entities/clinic.dart';
import 'package:cga_app/app/features/clinics/domain/usecases/contract/get_clinics_usecase.dart';
import 'package:cga_app/app/features/clinics/domain/usecases/contract/get_clinic_by_id_usecase.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class SearchClinicsController extends BaseDialogPaginationController<Clinic> {
  final GetClinicsUsecase _getClinicsUsecase;
  final GetClinicByIdUsecase _getClinicByIdUsecase;

  SearchClinicsController({
    required GetClinicsUsecase getClinicsUsecase,
    required GetClinicByIdUsecase getClinicByIdUsecase,
  }) : _getClinicsUsecase = getClinicsUsecase,
       _getClinicByIdUsecase = getClinicByIdUsecase;

  String? _cnpj = "";
  String? _name = "";

  final clinicSelected = Rxn<Clinic>();

  @override
  void onInit() {
    super.onInit();
    filterSelected = SearchClinicFilterItem.name;
  }

  Future<void> loadClinicById(String id) async {
    try {
      final clinic = await _getClinicByIdUsecase.call(id: id);
      clinicSelected.value = clinic;
    } catch (e) {
      clinicSelected.value = null;
    }
  }

  void selectClinic(Clinic? clinic) {
    clinicSelected.value = clinic;
  }

  @override
  Future<PaginatedResult<Clinic>> fetch({
    required int page,
    required int pageSize,
  }) async {
    try {
      _setFilterText();
      return await _getClinicsUsecase(
        page: page,
        pageSize: pageSize,
        active: true,
        cnpj: _cnpj,
        name: _name,
      );
    } on AppException {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  void _setFilterText() {
    _cnpj = null;
    _name = null;

    final text = searchText.text.trim();
    final filterKey = filterSelected?.key;

    if (text.isEmpty) return;

    switch (filterKey) {
      case SearchClinicFilterItem.cnpjKey:
        _cnpj = text;
        break;
      case SearchClinicFilterItem.nameKey:
        _name = text;
        break;
    }
  }
}
