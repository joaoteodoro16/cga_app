import 'package:cga_app/app/core/routes/app_routes.dart';
import 'package:cga_app/app/features/auth/bindings/login_binding.dart';
import 'package:cga_app/app/features/auth/presentation/login/login_page.dart';
import 'package:cga_app/app/features/clinics/bindings/clinics_bindings.dart';
import 'package:cga_app/app/features/clinics/presentation/pages/clinics_page.dart';
import 'package:cga_app/app/features/groups/bindings/groups_bindings.dart';
import 'package:cga_app/app/features/groups/presentation/pages/groups_page.dart';
import 'package:cga_app/app/features/home/bindings/home_binding.dart';
import 'package:cga_app/app/features/home/presentation/pages/home_page.dart';
import 'package:cga_app/app/features/patients/presentation/pages/patients_page.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.clinics,
      page: () => ClinicsPage(),
      binding: ClinicsBindings()
    ),
    GetPage(
      name: AppRoutes.groups,
      page: () => GroupsPage(),
       binding: GroupsBindings()
    ),
    GetPage(
      name: AppRoutes.patients,
      page: () => PatientsPage(),
    ),
  ];
}
