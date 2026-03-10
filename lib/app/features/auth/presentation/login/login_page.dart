import 'package:cga_app/app/core/constants/text_constants.dart';
import 'package:cga_app/app/core/ui/widgets/app_button.dart';
import 'package:cga_app/app/core/ui/styles/app_colors.dart';
import 'package:cga_app/app/core/ui/styles/app_text_styles.dart';
import 'package:cga_app/app/core/ui/widgets/app_text_form_field.dart';
import 'package:cga_app/app/core/util/screen_util.dart';
import 'package:cga_app/app/features/auth/presentation/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _operatorEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _operatorEC.text = "joao.teodoro";
    _passwordEC.text = "123123";
    super.initState();
    
  }

  @override
  void dispose() {
    _operatorEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: ScreenUtils.isDesktop(context)
              ? ScreenUtils.width(context) * .2
              : ScreenUtils.width(context) * .7,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'CGA',
                    style: context.textStyles.textExtraBold.copyWith(
                      fontSize: 60,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    'Central de Gestão e\n Acompanhamento',
                    style: context.textStyles.textExtraBold.copyWith(
                      fontSize: 18,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppTextFormField(
                    label: 'Operador',
                    controller: _operatorEC,
                    validator: Validatorless.required(
                      TextConstants.requiredField,
                    ),
                  ),
                  const SizedBox(height: 10),
                  AppTextFormField(
                    label: 'Senha',
                    controller: _passwordEC,
                    validator: Validatorless.required(
                      TextConstants.requiredField,
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  AppButton(
                    title: 'ACESSAR',
                    onPressed: () async {
                      final validate =
                          _formKey.currentState?.validate() ?? false;
                      if (validate) {
                        await controller.login(
                          operator: _operatorEC.text,
                          password: _passwordEC.text,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
