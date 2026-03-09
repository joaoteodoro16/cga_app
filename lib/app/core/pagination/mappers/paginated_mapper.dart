import '../entities/paginated_result.dart';
import '../dtos/paginated_dto.dart';

extension PaginatedMapper<T, R> on PaginatedDto<T> {
  PaginatedResult<R> toEntity(R Function(T) mapper) {
    return PaginatedResult(
      items: items.map(mapper).toList(),
      page: page,
      pageSize: pageSize,
      totalItems: totalItems,
      totalPages: totalPages,
    );
  }
}