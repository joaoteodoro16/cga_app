import 'package:cga_app/app/features/groups/domain/usecases/params/get_all_groups_params.dart';

class GetGroupsRequestDto {
  final String? name;
  final String? clinicId;
  final String? clinicName;
  final bool? active;
  final int page;
  final int pageSize;

  GetGroupsRequestDto({
    this.name,
    this.clinicId,
    this.clinicName,
    this.active,
    required this.page,
    required this.pageSize,
  });

  factory GetGroupsRequestDto.fromParams(GetAllGroupsParams params) {
    return GetGroupsRequestDto(
      name: params.name,
      clinicId: params.clinicId,
      clinicName: params.clinicName,
      active: params.active,
      page: params.page,
      pageSize: params.pageSize,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Nome': name,
      'ClinicaId': clinicId,
      'ClinicaNome': clinicName,
      'Ativo': active,
      'Page': page,
      'PageSize': pageSize,
    };
  }
}
