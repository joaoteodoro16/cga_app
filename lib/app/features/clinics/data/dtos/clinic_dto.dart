import 'dart:convert';
import 'package:cga_app/app/features/clinics/domain/entities/clinic.dart';
import 'package:cga_app/app/features/groups/data/dtos/group_dto.dart';

class ClinicDto {
  final String? id;
  final String name;
  final String? cnpj;
  final String? phone;
  final String? address;
  final bool active;
  final List<GroupDto> groups;
  final int amountGroups;

  ClinicDto({
    this.id,
    required this.name,
    this.cnpj,
    this.phone,
    this.address,
    required this.active,
    required this.groups,
    required this.amountGroups,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': name,
      'cnpj': cnpj,
      'telefone': phone,
      'endereco': address,
      'ativo': active,
      'grupos': groups.map((x) => x.toMap()).toList(),
      'quantidadeGrupos': amountGroups,
    };
  }

  factory ClinicDto.fromMap(Map<String, dynamic> map) {
    return ClinicDto(
      id: map['id'] ?? '',
      name: map['nome'] ?? '',
      cnpj: map['cnpj'],
      phone: map['telefone'],
      address: map['endereco'],
      active: map['ativo'] ?? false,
      groups: List<GroupDto>.from(
        map['grupos']?.map((x) => GroupDto.fromMap(x)) ?? const [],
      ),
      amountGroups: map['quantidadeGrupos']?.toInt() ?? 0,
    );
  }

  factory ClinicDto.fromEntity(Clinic clinic) {
    return ClinicDto(
      id: clinic.id,
      name: clinic.name,
      active: clinic.active,
      groups: clinic.groups
          .map((entity) => GroupDto.fromEntity(entity))
          .toList(),
      amountGroups: 0,
      address: clinic.address,
      cnpj: clinic.cnpj,
      phone: clinic.phone,
    );
  }

  Clinic toEntity() {
    return Clinic(
      id: id!,
      name: name,
      cnpj: cnpj,
      address: address,
      phone: phone,
      groups: groups.map((g) => g.toEntity()).toList(),
      active: active,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClinicDto.fromJson(String source) =>
      ClinicDto.fromMap(json.decode(source));
}
