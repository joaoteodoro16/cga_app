import 'dart:convert';
import 'package:cga_app/app/features/clinics/domain/entities/clinic.dart';
import 'package:cga_app/app/features/groups/data/dtos/group_summary_dto.dart';


class GetClinicByIdDto {
  final String id;
  final String nome;
  final String cnpj;
  final String telefone;
  final String endereco;
  final DateTime dataCadastro;
  final bool ativo;
  final List<GroupSummaryDto> grupos;
  final int quantidadeGrupos;

  GetClinicByIdDto({
    required this.id,
    required this.nome,
    required this.cnpj,
    required this.telefone,
    required this.endereco,
    required this.dataCadastro,
    required this.ativo,
    required this.grupos,
    required this.quantidadeGrupos,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'cnpj': cnpj,
      'telefone': telefone,
      'endereco': endereco,
      'dataCadastro': dataCadastro.toUtc().toIso8601String(),
      'ativo': ativo,
      'grupos': grupos.map((x) => x.toMap()).toList(),
      'quantidadeGrupos': quantidadeGrupos,
    };
  }

  factory GetClinicByIdDto.fromMap(Map<String, dynamic> map) {
    return GetClinicByIdDto(
      id: map['id'] ?? '',
      nome: map['nome'] ?? '',
      cnpj: map['cnpj'] ?? '',
      telefone: map['telefone'] ?? '',
      endereco: map['endereco'] ?? '',
      dataCadastro: DateTime.parse(map['dataCadastro']),
      ativo: map['ativo'] ?? false,
      grupos: List<GroupSummaryDto>.from(
        map['grupos']?.map((x) => GroupSummaryDto.fromMap(x)) ?? const [],
      ),
      quantidadeGrupos: map['quantidadeGrupos']?.toInt() ?? 0,
    );
  }

  Clinic toEntity() {
    return Clinic(
      id: id,
      name: nome,
      cnpj: cnpj,
      address: endereco,
      phone: telefone,
      active: ativo,
      groups: grupos.map((x) => x.toEntity()).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetClinicByIdDto.fromJson(String source) =>
      GetClinicByIdDto.fromMap(json.decode(source));
}
