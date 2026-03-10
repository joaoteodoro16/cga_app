import 'package:cga_app/app/core/ui/models/base_search_filter_item.dart';

class SearchGroupFilterItem extends BaseSearchFilterItem {
  const SearchGroupFilterItem({required super.label, required super.key});

  static const String nameKey = "name";
  static const String cnpjKey = "cnpj";

  static const SearchGroupFilterItem name = SearchGroupFilterItem(
    label: "Nome",
    key: nameKey,
  );

  static const SearchGroupFilterItem cnpj = SearchGroupFilterItem(
    label: "CNPJ",
    key: cnpjKey,
  );

  static const List<SearchGroupFilterItem> items = [name, cnpj];
}
