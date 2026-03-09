import 'package:cga_app/app/core/controller/base_controller.dart';
import 'package:cga_app/app/core/pagination/entities/paginated_result.dart';
import 'package:get/get.dart';

abstract class BasePaginationController<T> extends BaseController {
  final items = <T>[].obs;

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

  Future<PaginatedResult<T>> fetch({required int page, required int pageSize});

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
}
