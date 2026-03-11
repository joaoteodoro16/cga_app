import 'package:cga_app/app/features/groups/domain/entities/group.dart';

class Patient {
  final String id;
  final String nome;
  final Group grupo;
  final String telefone;
  final DateTime dataInicio;
  final DateTime dataEncerramento;
  final double pesoInicial;
  final bool ativo;

  Patient({
    required this.id,
    required this.nome,
    required this.grupo,
    required this.dataInicio,
    required this.dataEncerramento,
    required this.pesoInicial,
    required this.telefone,
    required this.ativo,
  });
}
