import 'package:cga_app/app/core/routes/app_routes.dart';
import 'package:cga_app/app/core/ui/styles/app_colors.dart';
import 'package:cga_app/app/core/util/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import '../widgets/home_menu_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ScreenUtils.isMobile(context);
    final isTablet = ScreenUtils.isTablet(context);

    int crossAxisCount;

    if (isMobile) {
      crossAxisCount = 2; // 📱 2 por linha
    } else if (isTablet) {
      crossAxisCount = 3;
    } else {
      crossAxisCount = 4; // 💻 Desktop
    }

    return Scaffold(
      backgroundColor: AppColors.screenBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: const Text('Operador: Paty Moura'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.logout))],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: EdgeInsets.all(isMobile ? 16 : 32),
            child: GridView.count(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: isMobile ? 16 : 24,
              mainAxisSpacing: isMobile ? 16 : 24,
              childAspectRatio: isMobile ? 1.1 : 1.3, // 🔥 menor no mobile
              children: [
                HomeMenuButton(
                  title: 'Clínicas',
                  icon: Icons.local_hospital,
                  onTap: () => Get.toNamed(AppRoutes.clinics),
                ),
                HomeMenuButton(
                  title: 'Grupos',
                  icon: FontAwesomeIcons.whatsapp,
                  onTap: () => Get.toNamed(AppRoutes.groups),
                ),
                HomeMenuButton(
                  title: 'Pacientes',
                  icon: Icons.person,
                  onTap: () => Get.toNamed(AppRoutes.patients),
                ),
                HomeMenuButton(
                  title: 'Acompanhamentos',
                  icon: Icons.check_circle,
                  onTap: () {
                    Get.toNamed(AppRoutes.dailyChecklist);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
