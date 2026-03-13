import 'package:cga_app/app/features/patients/domain/entities/patient.dart';

class CheckList {
  final Patient patient;
  final bool breakfast;
  final bool morningSnack;
  final bool lunch;
  final bool afternoonSnack;
  final bool dinner;
  final bool training;
  final bool scale;
  final double? weight;
  final double? weightDifference;

  CheckList({
    required this.patient,
    this.breakfast = false,
    this.morningSnack = false,
    this.lunch = false,
    this.afternoonSnack = false,
    this.dinner = false,
    this.training = false,
    required this.scale,
    this.weight,
    this.weightDifference,
  });
}
