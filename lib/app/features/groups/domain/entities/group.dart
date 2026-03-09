import 'package:cga_app/app/features/patients/domain/entities/patient.dart';

class Group {
  final String id;
  final String name;
  final String? description;
  final String clinicId;
  final List<Patient> patients;
  final bool active;

  Group({
    required this.id,
    required this.name,
    this.description,
    required this.clinicId,
    required this.patients,
    required this.active,
  });
}