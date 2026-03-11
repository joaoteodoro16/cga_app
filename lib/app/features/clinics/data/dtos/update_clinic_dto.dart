import 'dart:convert';

import 'package:cga_app/app/features/clinics/domain/entities/clinic.dart';

class UpdateClinicDto {
  final String id;
  final String nome;
  final String? cnpj;
  final String? endereco;
  final String? telefone;
  final bool ativo;

  UpdateClinicDto({
    required this.id,
    required this.nome,
    this.cnpj,
    this.endereco,
    this.telefone,
    required this.ativo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'cnpj': cnpj,
      'endereco': endereco,
      'telefone': telefone,
      'ativo': ativo,
    };
  }

  factory UpdateClinicDto.fromMap(Map<String, dynamic> map) {
    return UpdateClinicDto(
      id: map['id'] ?? '',
      nome: map['nome'] ?? '',
      cnpj: map['cnpj'],
      endereco: map['endereco'],
      telefone: map['telefone'],
      ativo: map['ativo'] ?? false,
    );
  }

  factory UpdateClinicDto.fromEntity({required Clinic clinic}) {
    return UpdateClinicDto(
      id: clinic.id,
      nome: clinic.name,
      cnpj: clinic.cnpj,
      endereco: clinic.address,
      telefone: clinic.phone,
      ativo: clinic.active,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateClinicDto.fromJson(String source) =>
      UpdateClinicDto.fromMap(json.decode(source));
}
