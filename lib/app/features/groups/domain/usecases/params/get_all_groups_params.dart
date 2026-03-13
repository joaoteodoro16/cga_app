class GetAllGroupsParams {
  final String? name;
  final String? clinicId;
  final String? clinicName;
  final bool? active;
  final int page;
  final int pageSize;

  GetAllGroupsParams({
    this.name,
    this.clinicId,
    this.clinicName,
    this.active,
    required this.page,
    required this.pageSize,
  });
}
