import 'package:cga_app/app/core/pagination/dtos/paginated_dto.dart';
import 'package:cga_app/app/features/groups/data/dtos/create_group_dto.dart';
import 'package:cga_app/app/features/groups/data/dtos/get_groups_dto.dart';
import 'package:cga_app/app/features/groups/data/dtos/get_groups_request_dto.dart';
import 'package:cga_app/app/features/groups/data/dtos/update_group_dto.dart';

abstract class GroupRemoteDatasource {
  Future<PaginatedDto<GetGroupsDto>> getAll({required GetGroupsRequestDto request});

  Future<void> add({required CreateGroupDto group});
  Future<void> update({required UpdateGroupDto group});
  
}

// public string? Nome { get; init; }
// public Guid? ClinicaId { get; init; }
// public bool? Ativo { get; init; }

// public int Page { get; init; } = 1;
// public int PageSize { get; init; } = 10;