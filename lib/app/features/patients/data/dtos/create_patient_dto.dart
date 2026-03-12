import 'dart:convert';

import 'package:cga_app/app/features/patients/domain/entities/patient.dart';

class CreatePatientDto {
  final String nome;
  final String telefone;
  final DateTime dataInicio;
  final DateTime dataEncerramento;
  final double pesoInicial;
  final String grupoId;

  CreatePatientDto({
    required this.nome,
    required this.telefone,
    required this.dataInicio,
    required this.dataEncerramento,
    required this.pesoInicial,
    required this.grupoId,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'telefone': telefone,
      'dataInicio': dataInicio.toUtc().toIso8601String(),
      'dataEncerramento': dataEncerramento.toUtc().toIso8601String(),
      'pesoInicial': pesoInicial,
      'grupoId': grupoId,
    };
  }

  factory CreatePatientDto.fromMap(Map<String, dynamic> map) {
    return CreatePatientDto(
      nome: map['nome'] ?? '',
      telefone: map['telefone'] ?? '',
      dataInicio: DateTime.parse(map['dataInicio']),
      dataEncerramento: DateTime.parse(map['dataEncerramento']),
      pesoInicial: map['pesoInicial']?.toDouble() ?? 0.0,
      grupoId: map['grupoId'] ?? '',
    );
  }

  factory CreatePatientDto.fromEntity({required Patient patient}) {
    return CreatePatientDto(
      nome: patient.nome,
      telefone: patient.telefone,
      dataInicio: patient.dataInicio,
      dataEncerramento: patient.dataEncerramento,
      pesoInicial: patient.pesoInicial,
      grupoId: patient.grupo?.id ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CreatePatientDto.fromJson(String source) =>
      CreatePatientDto.fromMap(json.decode(source));
}
