import 'package:cga_app/app/features/groups/domain/entities/group.dart';

class Clinic {
  final String id;
  final String name;
  final String? cnpj;
  final String? phone;
  final String? address;
  final List<Group> groups;
  final bool active;

  Clinic({
    required this.id,
    required this.name,
    this.cnpj,
    this.phone,
    this.address,
    required this.groups,
    required this.active,
  });
}