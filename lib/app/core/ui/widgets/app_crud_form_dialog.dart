import 'package:cga_app/app/core/ui/styles/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class AppCrudFormDialog<T> extends StatelessWidget {
  final String title;
  final List<Widget> fields;
  final Future<void> Function() onSave;
  final Future<void> Function() onEdit;
  final T? editingEntity;
  final bool isLoading;
  final GlobalKey<FormState> formKey;

  const AppCrudFormDialog({
    super.key,
    required this.title,
    required this.fields,
    required this.onSave,
    this.isLoading = false,
    required this.formKey,
    this.editingEntity,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleLarge),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: fields
                      .map(
                        (field) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: field,
                        ),
                      )
                      .toList(),
                ),
              ),
              const Divider(height: 1),
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppButton(
                      title: 'Cancelar',
                      width: 120,
                      onPressed: () => Navigator.pop(context),
                      type: AppButtonType.primaryOutline,
                    ),
                    const SizedBox(width: 12),
                    AppButton(
                      title: 'Salvar',
                      width: 120,
                      onPressed: () async {
                        final validate = formKey.currentState?.validate() ?? false;

                        if(!validate) return;
                        
                        if (editingEntity != null) {
                          await onEdit();
                        } else {
                          await onSave();
                        }
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
