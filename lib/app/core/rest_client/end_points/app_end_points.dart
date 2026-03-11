import 'package:cga_app/app/core/config/env.dart';

class AppEndPoints {
  AppEndPoints._();

  static String get _baseUrl => Env.apiUrl;

  //Auth
  static String get auth => "$_baseUrl/Usuario/auth";
  //Clinic
  static String get _clinicBase => "$_baseUrl/Clinica";
  static String get getClinics => "$_clinicBase/buscar";
  static String get getCliniById => "$_clinicBase/id";
  static String get addClinic => _clinicBase;
  static String get updateClinic => _clinicBase;

  //Group
  static String get _groupBase => "$_baseUrl/Grupo";
  static String get getGroups => "$_groupBase/buscar";
  static String get addGroups => _groupBase;
  static String get updateGroups => _groupBase;

  //Patients
  static String get _patientBase => "$_baseUrl/Paciente";
  static String get getPatients => "$_patientBase/buscar";
  static String get addPatients => _patientBase;
  static String get updatePatients => _patientBase;

}
