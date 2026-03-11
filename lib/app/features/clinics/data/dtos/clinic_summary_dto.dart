import 'dart:convert';

import 'package:cga_app/app/features/clinics/domain/entities/clinic.dart';

class ClinicSummaryDto {
  final String id;
  final String nome;
  final bool ativo;

  ClinicSummaryDto({required this.id, required this.nome, required this.ativo});

  Map<String, dynamic> toMap() {
    return {'id': id, 'nome': nome, 'ativo': ativo};
  }

  factory ClinicSummaryDto.fromMap(Map<String, dynamic> map) {
    return ClinicSummaryDto(
      id: map['id'] ?? '',
      nome: map['nome'] ?? '',
      ativo: map['ativo'] ?? false,
    );
  }

  Clinic toEntity() {
    return Clinic(id: id, name: nome, active: ativo, groups: []);
  }

  String toJson() => json.encode(toMap());

  factory ClinicSummaryDto.fromJson(String source) =>
      ClinicSummaryDto.fromMap(json.decode(source));
}
