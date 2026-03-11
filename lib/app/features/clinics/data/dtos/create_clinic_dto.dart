import 'dart:convert';

import 'package:cga_app/app/features/clinics/domain/entities/clinic.dart';

class CreateClinicDto {
  final String nome;
  final String? cnpj;
  final String? endereco;
  final String? telefone;
  CreateClinicDto({
    required this.nome,
    this.cnpj,
    this.endereco,
    this.telefone,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'cnpj': cnpj,
      'endereco': endereco,
      'telefone': telefone,
    };
  }

  factory CreateClinicDto.fromMap(Map<String, dynamic> map) {
    return CreateClinicDto(
      nome: map['nome'] ?? '',
      cnpj: map['cnpj'],
      endereco: map['endereco'],
      telefone: map['telefone'],
    );
  }

  factory CreateClinicDto.fromEntity({required Clinic clinic}) {
    return CreateClinicDto(
      nome: clinic.name,
      cnpj: clinic.cnpj,
      endereco: clinic.address,
      telefone: clinic.phone,
    );
  }

  Clinic toEntity() {
    return Clinic(
      id: '',
      name: nome,
      cnpj: cnpj,
      address: endereco,
      phone: telefone,
      active: true,
      groups: [],
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateClinicDto.fromJson(String source) =>
      CreateClinicDto.fromMap(json.decode(source));
}
