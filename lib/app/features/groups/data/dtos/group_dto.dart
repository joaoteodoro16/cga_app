import 'dart:convert';
import 'package:cga_app/app/features/clinics/data/dtos/clinic_dto.dart';
import 'package:cga_app/app/features/clinics/domain/entities/clinic.dart';
import 'package:cga_app/app/features/groups/domain/entities/group.dart';

class GroupDto {
  final String id;
  final String name;
  final String? description;
  final ClinicDto clinic;
  final bool active;

  GroupDto({
    required this.id,
    required this.name,
    this.description,
    required this.clinic,
    required this.active,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': name,
      'descricao': description,
      'clinicaId': clinic.id,
      'ativo': active,
    };
  }

  factory GroupDto.fromMap(Map<String, dynamic> map) {
    final clinicMap = map['clinica'];

    return GroupDto(
      id: map['id'] ?? '',
      name: map['nome'] ?? '',
      description: map['descricao'],
      clinic: clinicMap is Map<String, dynamic>
          ? ClinicDto.fromMap(clinicMap)
          : ClinicDto(
              id: '',
              name: '',
              active: false,
              groups: const [],
              amountGroups: 0,
            ),
      active: map['ativo'] ?? false,
    );
  }



  factory GroupDto.fromEntity(Group entity) {
    return GroupDto(
      id: entity.id,
      name: entity.name,
      clinic: ClinicDto.fromEntity(entity.clinic),
      active: entity.active,
      description: entity.description,
    );
  }

  Group toEntity() {
    return Group(
      id: id,
      name: name,
      description: description,
      clinic: Clinic(
        id: clinic.id!,
        name: clinic.name,
        groups: [],
        active: clinic.active,
      ),
      patients: [],
      active: active,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupDto.fromJson(String source) =>
      GroupDto.fromMap(json.decode(source));
}
