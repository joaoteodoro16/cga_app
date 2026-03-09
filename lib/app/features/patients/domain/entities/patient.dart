import 'package:cga_app/app/features/groups/domain/entities/group.dart';

class Patient {
  final String id;
  final String name;
  final List<Group> groups;
  final DateTime startDate;
  final DateTime endDate;
  final double startingWeight;

  Patient({
    required this.id,
    required this.name,
    required this.groups,
    required this.startDate,
    required this.endDate,
    required this.startingWeight,
  });


  
}

