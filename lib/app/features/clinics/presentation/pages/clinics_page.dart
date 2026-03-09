import 'package:brasil_fields/brasil_fields.dart';
import 'package:cga_app/app/core/constants/text_constants.dart';
import 'package:cga_app/app/core/enums/entity_status_enum.dart';
import 'package:cga_app/app/core/enums/entity_status_filter_enum.dart';
import 'package:cga_app/app/core/ui/models/app_crud_item.dart';
import 'package:cga_app/app/core/ui/widgets/app_combo_box.dart';
import 'package:cga_app/app/core/ui/widgets/app_crud_form_dialog.dart';
import 'package:cga_app/app/features/clinics/domain/entities/clinic.dart';
import 'package:cga_app/app/features/clinics/presentation/controllers/clinics_controller.dart';
import 'package:flutter/material.dart';
import 'package:cga_app/app/core/ui/widgets/app_crud_layout.dart';
import 'package:cga_app/app/core/ui/widgets/app_text_form_field.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

class ClinicsPage extends StatefulWidget {
  const ClinicsPage({super.key});

  @override
  State<ClinicsPage> createState() => _ClinicsPageState();
}

class _ClinicsPageState extends State<ClinicsPage> {
  final controller = Get.find<ClinicsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppCrudLayout(
        pageTitle: 'Clinicas',
        page: controller.page,
        totalPages: controller.totalPages,
        onPreviousPage: controller.previousPage,
        onNextPage: controller.nextPage,
        onFilterClean: () async => await controller.cleanFilter(),
        onSearch: controller.search,
        onNew: () {
          _showDialog();
        },
        filters: Column(
          children: [
            AppTextFormField(
              label: 'Nome',
              controller: controller.nameFilterEC,
            ),
            const SizedBox(height: 10),
            AppTextFormField(
              label: 'CNPJ',
              controller: controller.cnpjFilterEC,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CnpjInputFormatter(),
              ],
            ),
            const SizedBox(height: 10),
            AppComboBox<EntityStatusFilterEnum>(
              items: EntityStatusFilterEnum.values,
              itemLabel: (item) => item.description,
              initialValue: EntityStatusFilterEnum.values.first,
              hint: 'Status',
              onChanged: (value) {
                controller.activeFilter = value;
              },
            ),
          ],
        ),
        items: List.generate(controller.items.length, (index) {
          final clinic = controller.items[index];
          return AppCrudItem<Clinic>(
            title: clinic.name,
            subtitle: clinic.cnpj,
            data: clinic,
            active: clinic.active,
          );
        }),
        onItemTap: (item) {
          final clinic = item.data;
          controller.editingClinic = clinic;
          final entity = controller.editingClinic;
          controller.nameEC.text = entity!.name;
          controller.cnpjEC.text = entity.cnpj ?? '';
          controller.addressEC.text = entity.address ?? '';
          controller.phoneEC.text = entity.phone ?? '';
          controller.active = EntityStatusEnum.fromBoolean(entity.active);
          _showDialog();
        },
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (_) => AppCrudFormDialog(
        formKey: controller.formKey,
        title: controller.editingClinic != null
            ? controller.editingClinic!.name
            : 'Nova Clínica',
        onSave: () async => await controller.addClinic(),
        onEdit: () async => await controller.updateClinic(),
        editingEntity: controller.editingClinic,
        fields: [
          AppTextFormField(
            label: 'Nome',
            controller: controller.nameEC,
            validator: Validatorless.multiple([
              Validatorless.required(TextConstants.requiredField),
              Validatorless.min(6, TextConstants.completeName),
            ]),
          ),
          Row(
            spacing: 10,
            children: [
              Expanded(
                child: AppTextFormField(
                  label: 'CNPJ',
                  controller: controller.cnpjEC,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CnpjInputFormatter(),
                  ],
                ),
              ),
              Expanded(
                child: AppTextFormField(
                  label: 'Telefone',
                  controller: controller.phoneEC,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter(),
                  ],
                ),
              ),
            ],
          ),
          AppTextFormField(label: 'Endereço', controller: controller.addressEC),
          AppComboBox<EntityStatusEnum>(
            items: EntityStatusEnum.values,
            itemLabel: (item) => item.description,
            initialValue: EntityStatusEnum.fromBoolean(
              controller.active ?? true,
            ),
            hint: 'Status',
            onChanged: (value) {
              controller.active = value!;
            },
          ),
        ],
      ),
    );
  }
}
