
import 'dart:convert';

import 'package:cga_app/app/features/groups/domain/entities/group.dart';

class UpdateGroupDto {
  final String id;
  final String name;
  final String? description;
  final String clinicId;
  final bool active;

  UpdateGroupDto({
    required this.id,
    required this.name,
    this.description,
    required this.clinicId,
    required this.active,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': name,
      'descricao': description,
      'clinicaId': clinicId,
      'ativo': active,
    };
  }

  factory UpdateGroupDto.fromMap(Map<String, dynamic> map) {
    return UpdateGroupDto(
      id: map['id'] ?? '',
      name: map['nome'] ?? '',
      description: map['descricao'],
      clinicId: map['clinicaId'] ?? '',
      active: map['ativo'] ?? false,
    );
  }

    factory UpdateGroupDto.fromEntity({required Group group}) {
      return UpdateGroupDto(
        id: group.id,
        name: group.name,
        description: group.description,
        clinicId: group.clinicId,
        active: group.active,
      );
    }

  String toJson() => json.encode(toMap());

  factory UpdateGroupDto.fromJson(String source) =>
      UpdateGroupDto.fromMap(json.decode(source));
}

