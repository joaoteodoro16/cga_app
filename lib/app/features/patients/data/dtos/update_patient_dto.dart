
import 'dart:convert';

import 'package:cga_app/app/features/patients/domain/entities/patient.dart';

class UpdatePatientDto {
	final String id;
	final String nome;
	final String telefone;
	final DateTime dataInicio;
	final DateTime dataEncerramento;
	final double pesoInicial;
	final bool ativo;

	UpdatePatientDto({
		required this.id,
		required this.nome,
		required this.telefone,
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
			'dataInicio': dataInicio.toUtc().toIso8601String(),
			'dataEncerramento': dataEncerramento.toUtc().toIso8601String(),
			'pesoInicial': pesoInicial,
			'ativo': ativo,
		};
	}

	factory UpdatePatientDto.fromMap(Map<String, dynamic> map) {
		return UpdatePatientDto(
			id: map['id'] ?? '',
			nome: map['nome'] ?? '',
			telefone: map['telefone'] ?? '',
			dataInicio: DateTime.parse(map['dataInicio']),
			dataEncerramento: DateTime.parse(map['dataEncerramento']),
			pesoInicial: map['pesoInicial']?.toDouble() ?? 0.0,
			ativo: map['ativo'] ?? false,
		);
	}

  factory UpdatePatientDto.fromEntity({required Patient patient}) {
    return UpdatePatientDto(
      id: patient.id,
			nome: patient.nome,
			telefone: patient.telefone,
			dataInicio: patient.dataInicio,
			dataEncerramento: patient.dataEncerramento,
			pesoInicial: patient.pesoInicial,
			ativo: patient.ativo,
    );
  }

	String toJson() => json.encode(toMap());

	factory UpdatePatientDto.fromJson(String source) =>
			UpdatePatientDto.fromMap(json.decode(source));
}
