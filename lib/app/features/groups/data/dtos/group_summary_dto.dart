import 'dart:convert';
import 'package:cga_app/app/features/groups/domain/entities/group.dart';

class GroupSummaryDto {
  final String id;
  final String nome;
  final String descricao;
  final bool ativo;

  GroupSummaryDto({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.ativo,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'nome': nome, 'descricao': descricao, 'ativo': ativo};
  }

  factory GroupSummaryDto.fromMap(Map<String, dynamic> map) {
    return GroupSummaryDto(
      id: map['id'] ?? '',
      nome: map['nome'] ?? '',
      descricao: map['descricao'] ?? '',
      ativo: map['ativo'] ?? false,
    );
  }

  Group toEntity() {
    return Group(
      id: id,
      name: nome,
      description: descricao,
      clinicId: '',
      patients: [],
      active: ativo,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupSummaryDto.fromJson(String source) =>
      GroupSummaryDto.fromMap(json.decode(source));
}
