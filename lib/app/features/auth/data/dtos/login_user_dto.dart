import 'dart:convert';

import '../../domain/entities/user.dart';

class LoginUserDto {
  final String id;
  final String name;
  final String operator;
  final int userNivel;
  final String accessToken;
  final String? clinicId;

  LoginUserDto({
    required this.id,
    required this.name,
    required this.operator,
    required this.userNivel,
    required this.accessToken,
    this.clinicId,
  });

  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': name,
      'operador': operator,
      'nivelUsuario': userNivel,
      'accessToken': accessToken,
      'clinicaId': clinicId,
    };
  }

  factory LoginUserDto.fromMap(Map<String, dynamic> map) {
    return LoginUserDto(
      id: map['id'] ?? '',
      name: map['nome'] ?? '',
      operator: map['operador'] ?? '',
      userNivel: map['nivelUsuario']?.toInt() ?? 0,
      accessToken: map['accessToken'] ?? '',
      clinicId: map['clinicaId'],
    );
  }

  User toEntity() {
    return User(
      id: id,
      name: name,
      operator: operator,
      userNivel: userNivel,
      clinicaId: clinicId,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginUserDto.fromJson(String source) => LoginUserDto.fromMap(json.decode(source));
}
