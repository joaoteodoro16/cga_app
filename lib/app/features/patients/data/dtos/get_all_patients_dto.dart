import 'dart:convert';

import 'package:cga_app/app/features/groups/data/dtos/patient_group_dto.dart';
import 'package:cga_app/app/features/patients/domain/entities/patient.dart';

class GetAllPatientsDto {
  final String id;
  final String nome;
  final String telefone;
  final PatientGroupDto grupo;
  final DateTime dataInicio;
  final DateTime dataEncerramento;
  final double pesoInicial;
  final bool ativo;
  GetAllPatientsDto({
    required this.id,
    required this.nome,
    required this.telefone,
    required this.grupo,
    required this.dataInicio,
    required this.dataEncerramento,
    required this.pesoInicial,
    required this.ativo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'telefone': telefone,
      'grupo': grupo.toMap(),
      'dataInicio': dataInicio.millisecondsSinceEpoch,
      'dataEncerramento': dataEncerramento.millisecondsSinceEpoch,
      'pesoInicial': pesoInicial,
      'ativo': ativo,
    };
  }

  factory GetAllPatientsDto.fromMap(Map<String, dynamic> map) {
    return GetAllPatientsDto(
      id: map['id'] ?? '',
      nome: map['nome'] ?? '',
      telefone: map['telefone'] ?? '',
      grupo: PatientGroupDto.fromMap(map['grupo']),
      dataInicio: DateTime.fromMillisecondsSinceEpoch(map['dataInicio']),
      dataEncerramento: DateTime.fromMillisecondsSinceEpoch(
        map['dataEncerramento'],
      ),
      pesoInicial: map['pesoInicial']?.toDouble() ?? 0.0,
      ativo: map['ativo'] ?? false,
    );
  }

  Patient toEntity() {
    return Patient(
      id: id,
      nome: nome,
      grupo: grupo.toEntity(),
      dataInicio: dataInicio,
      dataEncerramento: dataEncerramento,
      pesoInicial: pesoInicial,
      telefone: telefone,
      ativo: ativo,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAllPatientsDto.fromJson(String source) =>
      GetAllPatientsDto.fromMap(json.decode(source));
}
