
class User {
  final String id;
  final String name;
  final String operator;
  final int userNivel;
  final String? clinicaId; 

  User({
    required this.id,
    required this.name,
    required this.operator,
    required this.userNivel,
    this.clinicaId
  });
}
