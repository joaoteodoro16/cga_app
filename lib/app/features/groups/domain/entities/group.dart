import 'package:cga_app/app/features/clinics/domain/entities/clinic.dart';
import 'package:cga_app/app/features/patients/domain/entities/patient.dart';

class Group {
  final String id;
  final String name;
  final String? description;
  final Clinic clinic;
  final List<Patient> patients;
  final bool active;

  Group({
    required this.id,
    required this.name,
    this.description,
    required this.clinic,
    required this.patients,
    required this.active,
  });
}