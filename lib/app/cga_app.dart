import 'package:cga_app/app/core/bindings/app_bindings.dart';
import 'package:cga_app/app/core/routes/app_pages.dart';
import 'package:cga_app/app/core/routes/app_routes.dart';
import 'package:cga_app/app/core/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class CgaApp extends StatelessWidget {
  const CgaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: GetMaterialApp(
        title: 'CGA',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        locale: const Locale('pt', 'BR'),
        supportedLocales: const [Locale('pt', 'BR'), Locale('en', 'US')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        getPages: AppPages.pages,
        initialRoute: AppRoutes.login,
        initialBinding: AppBindings(),
      ),
    );
  }
}
