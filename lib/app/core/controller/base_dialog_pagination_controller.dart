import 'package:cga_app/app/core/pagination/entities/paginated_result.dart';
import 'package:cga_app/app/core/ui/models/base_search_filter_item.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

abstract class BaseDialogPaginationController<T> extends GetxController {
  final items = <T>[].obs;
  final selected = Rxn<T>();

  final _page = 1.obs;
  int get page => _page.value;
  set page(int value) => _page.value = value;

  final _pageSize = 10.obs;
  int get pageSize => _pageSize.value;

  final _totalPages = 1.obs;
  int get totalPages => _totalPages.value;

  final _totalItems = 0.obs;
  int get totalitems => _totalItems.value;

  bool get hasNextPage => page < totalPages;
  bool get hasPreviousPage => page > 1;

  final RxBool _isLoading = RxBool(false);
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value;

  final _searchText = TextEditingController();
  TextEditingController get searchText => _searchText;

  final Rxn<BaseSearchFilterItem> _filterSelected = Rxn<BaseSearchFilterItem>();
  BaseSearchFilterItem? get filterSelected => _filterSelected.value;
  set filterSelected(BaseSearchFilterItem? value) => _filterSelected.value = value;

  String? getItemId(T item) => null;

  Future<PaginatedResult<T>> fetch({required int page, required int pageSize});

  void select(T? value) {
    selected.value = value;
  }

  T? _findCachedById(String id) {
    for (final item in items) {
      if (getItemId(item) == id) {
        return item;
      }
    }
    return null;
  }

  Future<void> load({int? newPage}) async {
    try {
      showLoading();

      final result = await fetch(page: newPage ?? page, pageSize: pageSize);

      items.assignAll(result.items);
      page = result.page;
      _totalPages.value = result.totalPages;
      _totalItems.value = result.totalItems;
    } finally {
      hideLoading();
    }
  }

  Future<T?> findById(String id) async {
    final cached = _findCachedById(id);
    if (cached != null) {
      return cached;
    }

    if (items.isEmpty && !isLoading) {
      await load();
      return _findCachedById(id);
    }

    return null;
  }

  Future<void> loadById(String id) async {
    try {
      selected.value = await findById(id);
    } catch (_) {
      selected.value = null;
    }
  }

  Future<void> search() async {
    await load(newPage: 1);
  }
  void showLoading() {
    _isLoading.value = true;
  }

  void hideLoading() {
    _isLoading.value = false;
  }

  Future<void> nextPage() async {
    if (hasNextPage) {
      await load(newPage: page + 1);
    }
  }

  Future<void> previousPage() async {
    if (hasPreviousPage) {
      await load(newPage: page - 1);
    }
  }

  void clearFilter(){
    _searchText.clear();
  }


  @override
  void dispose() {
    _searchText.dispose();
    super.dispose();
  }
}
