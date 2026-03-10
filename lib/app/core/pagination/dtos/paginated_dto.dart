import 'package:cga_app/app/core/exceptions/exceptions.dart';

class PaginatedDto<T> {
  final List<T> items;
  final int page;
  final int pageSize;
  final int totalItems;
  final int totalPages;

  PaginatedDto({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
  });

  factory PaginatedDto.fromMap(
    Map<String, dynamic> map,
    T Function(Map<String, dynamic>) fromItem,
  ) {
    try {
      return PaginatedDto(
        items: (map['items'] as List).map((e) => fromItem(e)).toList(),
        page: map['page'],
        pageSize: map['pageSize'],
        totalItems: map['totalItems'],
        totalPages: map['totalPages'],
      );
    }  catch (e) {
      print(e);
      throw AppException(message: "Erro ao converter objeto");
    }
  }
}
