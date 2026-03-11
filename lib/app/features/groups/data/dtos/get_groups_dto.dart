import 'dart:convert';

import 'package:cga_app/app/features/clinics/data/dtos/clinic_summary_dto.dart';
import 'package:cga_app/app/features/groups/domain/entities/group.dart';

class GetGroupsDto {
  final String id;
  final String nome;
  final String? descricao;
  final DateTime dataCadastro;
  final DateTime? dataAtualizacao;
  final bool ativo;
  final ClinicSummaryDto clinica;

  GetGroupsDto({
    required this.id,
    required this.nome,
    this.descricao,
    required this.dataCadastro,
    this.dataAtualizacao,
    required this.ativo,
    required this.clinica,
  });

  factory GetGroupsDto.fromMap(Map<String, dynamic> map) {
    return GetGroupsDto(
      id: map['id'] ?? '',
      nome: map['nome'] ?? '',
      descricao: map['descricao'],
      dataCadastro: DateTime.parse(map['dataCadastro']),
      dataAtualizacao: map['dataAtualizacao'] != null
          ? DateTime.parse(map['dataAtualizacao'])
          : null,
      ativo: map['ativo'] ?? false,
      clinica: ClinicSummaryDto.fromMap(map['clinica']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'dataCadastro': dataCadastro.toUtc().toIso8601String(),
      'dataAtualizacao': dataAtualizacao?.toUtc().toIso8601String(),
      'ativo': ativo,
      'clinica': clinica.toMap(),
    };
  }

  Group toEntity() {
    return Group(
      id: id,
      name: nome,
      description: descricao,
      clinicId: clinica.id,
      clinic: clinica.toEntity(),
      patients: [],
      active: ativo,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetGroupsDto.fromJson(String source) =>
      GetGroupsDto.fromMap(json.decode(source));
}
