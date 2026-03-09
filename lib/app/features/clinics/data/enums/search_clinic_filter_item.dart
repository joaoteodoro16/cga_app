import 'package:cga_app/app/core/ui/models/base_search_filter_item.dart';

class SearchClinicFilterItem extends BaseSearchFilterItem {
  const SearchClinicFilterItem({
    required super.label,
    required super.key,
  });

  static const String nameKey = "name";
  static const String cnpjKey = "cnpj";

  static const SearchClinicFilterItem name =
      SearchClinicFilterItem(label: "Nome", key: nameKey);

  static const SearchClinicFilterItem cnpj =
      SearchClinicFilterItem(label: "CNPJ", key: cnpjKey);

  static const List<SearchClinicFilterItem> items = [
    name,
    cnpj,
  ];
}