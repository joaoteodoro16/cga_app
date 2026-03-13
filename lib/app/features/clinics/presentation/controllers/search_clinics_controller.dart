import 'package:cga_app/app/core/constants/text_constants.dart';
import 'package:cga_app/app/core/controller/base_dialog_pagination_controller.dart';
import 'package:cga_app/app/core/exceptions/exceptions.dart';
import 'package:cga_app/app/core/pagination/entities/paginated_result.dart';
import 'package:cga_app/app/core/ui/helpers/messager.dart';
import 'package:cga_app/app/features/clinics/data/enums/search_clinic_filter_item.dart';
import 'package:cga_app/app/features/clinics/domain/entities/clinic.dart';
import 'package:cga_app/app/features/clinics/domain/usecases/contract/get_clinics_usecase.dart';

class SearchClinicsController extends BaseDialogPaginationController<Clinic> {
  final GetClinicsUsecase _getClinicsUsecase;

  SearchClinicsController({required GetClinicsUsecase getClinicsUsecase})
    : _getClinicsUsecase = getClinicsUsecase;

  String? _cnpj = "";
  String? _name = "";

  @override
  void onInit() {
    super.onInit();
    filterSelected = SearchClinicFilterItem.name;
  }

  @override
  String? getItemId(Clinic item) {
    return item.id;
  }

  @override
  Future<PaginatedResult<Clinic>?> fetch({
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
    } on AppException catch (e) {
      showMessage(Messager.error(message: e.message));
    } catch (e) {
      showMessage(Messager.error(message: TextConstants.erroInesperado));
    }
    return null;
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
