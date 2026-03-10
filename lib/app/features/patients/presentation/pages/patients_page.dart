import 'package:cga_app/app/core/enums/entity_status_enum.dart';
import 'package:cga_app/app/core/enums/entity_status_filter_enum.dart';
import 'package:cga_app/app/core/ui/models/app_crud_item.dart';
import 'package:cga_app/app/core/ui/widgets/app_combo_box.dart';
import 'package:cga_app/app/core/ui/widgets/app_crud_form_dialog.dart';
import 'package:cga_app/app/core/ui/widgets/app_crud_layout.dart';
import 'package:cga_app/app/core/ui/widgets/app_text_form_field.dart';
import 'package:cga_app/app/features/groups/presentation/widgets/search_groups_widget.dart';
import 'package:cga_app/app/features/patients/domain/entities/patient.dart';
import 'package:cga_app/app/features/patients/presentation/controllers/patients_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class PatientsPage extends StatefulWidget {
  const PatientsPage({super.key});

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  final controller = Get.find<PatientsController>();

  @override
  Widget build(BuildContext context) {
    return AppCrudLayout(
      pageTitle: 'Pacientes',
      page: controller.page,
      totalPages: controller.totalPages,
      onPreviousPage: controller.previousPage,
      onNextPage: controller.nextPage,
      onSearch: controller.search,
      onNew: _showDialog,
      onFilterClean: controller.clearFilters,
      filters: Column(
        spacing: 10,
        children: [
          AppTextFormField(label: 'Nome', controller: controller.nameFilterEC),
          AppTextFormField(
            label: 'Telefone',
            controller: controller.phoneFilterEC,
          ),
          SearchGroupsWidget(
            tag: 'filter',
            onItemTap: (group) {
              controller.groupFilterSelected = group;
            },
            initialId: controller.groupFilterSelected?.id,
          ),
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
        final item = controller.items[index];
        return AppCrudItem<Patient>(
          title: item.name,
          subtitle: item.pho,
          active: item.active,
          secondSubtitle: 'Clínica: ${item.clinic.name}',
          data: item,
        );
      }),
      onItemTap: (item) {
        _showDialog();
      },
    );
  }

  Future<void> _showDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AppCrudFormDialog(
          editingEntity: controller.editingPatient,
          title: 'Cadastrar Pacientes',
          fields: [
            AppTextFormField(
              label: 'Nome',
              controller: controller.nameEC,
              isRequired: true,
            ),
            AppTextFormField(
              label: 'Telefone',
              controller: controller.phoneEC,
              isRequired: true,
            ),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: AppTextFormField(
                    label: 'Data início',
                    controller: controller.startDateEC,
                    isRequired: true,
                  ),
                ),
                Expanded(
                  child: AppTextFormField(
                    label: 'Data fim',
                    controller: controller.endDateEC,
                    isRequired: true,
                  ),
                ),
              ],
            ),
            AppTextFormField(
              label: 'Peso inicial',
              controller: controller.startWeightEC,
              isRequired: true,
            ),
            SearchGroupsWidget(
              tag: 'form',
              isRequired: true,
              onItemTap: (group) {
                controller.groupFilterSelected = group;
              },
              initialId: controller.groupFilterSelected?.id,
            ),
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
          onSave: () async {},
          formKey: controller.formKey,
          onEdit: () async {},
        );
      },
    );
    controller.clearForm();
  }
}
