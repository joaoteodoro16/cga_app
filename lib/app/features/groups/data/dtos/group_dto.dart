import 'dart:convert';
import 'package:cga_app/app/features/groups/domain/entities/group.dart';

class GroupDto {
  final String id;
  final String name;
  final String? description;
  final String clinicId;
  final bool active;

  GroupDto({
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

  factory GroupDto.fromMap(Map<String, dynamic> map) {
    return GroupDto(
      id: map['id'] ?? '',
      name: map['nome'] ?? '',
      description: map['descricao'],
      clinicId: map['clinicaId'] ?? '',
      active: map['ativo'] ?? false,
    );
  }

  factory GroupDto.fromEntity(Group entity) {
    return GroupDto(
      id: entity.id,
      name: entity.name,
      clinicId: entity.clinicId,
      active: entity.active,
      description: entity.description,
    );
  }

  Group toEntity() {
    return Group(
      id: id,
      name: name,
      description: description,
      clinicId: clinicId,
      patients: [],
      active: active,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupDto.fromJson(String source) =>
      GroupDto.fromMap(json.decode(source));
}
