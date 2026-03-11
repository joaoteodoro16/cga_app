import 'dart:convert';

import 'package:cga_app/app/features/groups/domain/entities/group.dart';

class CreateGroupDto {
  final String nome;
  final String? descricao;
  final String clinicaId;

  CreateGroupDto({
    required this.nome,
    this.descricao,
    required this.clinicaId,
  });

  Map<String, dynamic> toMap() {
    return {'nome': nome, 'descricao': descricao, 'clinicaId': clinicaId};
  }

  factory CreateGroupDto.fromMap(Map<String, dynamic> map) {
    return CreateGroupDto(
      nome: map['nome'] ?? '',
      descricao: map['descricao'],
      clinicaId: map['clinicaId'] ?? '',
    );
  }

  factory CreateGroupDto.fromEntity(Group group) {
    return CreateGroupDto(
      nome: group.name,
      descricao: group.description,
      clinicaId: group.clinicId,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateGroupDto.fromJson(String source) =>
      CreateGroupDto.fromMap(json.decode(source));
}
