import 'dart:convert';

import 'package:cga_app/app/features/clinics/data/dtos/clinic_summary_dto.dart';
import 'package:cga_app/app/features/groups/domain/entities/group.dart';

class PatientGroupDto {
  final String id;
  final String nome;
  final String descricao;
  final DateTime dataCadastro;
  final DateTime? dataAtualizacao;
  final bool ativo;
  final ClinicSummaryDto clinica;

  PatientGroupDto({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.dataCadastro,
    this.dataAtualizacao,
    required this.ativo,
    required this.clinica,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'dataCadastro': dataCadastro.millisecondsSinceEpoch,
      'dataAtualizacao': dataAtualizacao?.millisecondsSinceEpoch,
      'ativo': ativo,
      'clinica': clinica.toMap(),
    };
  }

  factory PatientGroupDto.fromMap(Map<String, dynamic> map) {
    return PatientGroupDto(
      id: map['id'] ?? '',
      nome: map['nome'] ?? '',
      descricao: map['descricao'] ?? '',
      dataCadastro: DateTime.fromMillisecondsSinceEpoch(map['dataCadastro']),
      dataAtualizacao: map['dataAtualizacao'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dataAtualizacao'])
          : null,
      ativo: map['ativo'] ?? false,
      clinica: ClinicSummaryDto.fromMap(map['clinica']),
    );
  }

  Group toEntity() {
    return Group(
      id: id,
      name: nome,
      clinic: clinica.toEntity(),
      patients: [],
      active: ativo,
    );
  }

  String toJson() => json.encode(toMap());

  factory PatientGroupDto.fromJson(String source) =>
      PatientGroupDto.fromMap(json.decode(source));
}
