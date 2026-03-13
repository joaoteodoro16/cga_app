import 'package:cga_app/app/core/ui/models/base_search_filter_item.dart';

class SearchGroupFilterItem extends BaseSearchFilterItem {
  const SearchGroupFilterItem({required super.label, required super.key});

  static const String nameKey = "name";
  static const String clinicNameKey = "clinicName";

  static const SearchGroupFilterItem name = SearchGroupFilterItem(
    label: "Nome",
    key: nameKey,
  );

  static const SearchGroupFilterItem clinicName = SearchGroupFilterItem(
    label: "Nome da Clínica",
    key: clinicNameKey,
  );

  static const List<SearchGroupFilterItem> items = [name, clinicName];
}
