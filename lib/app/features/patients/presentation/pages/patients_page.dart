import 'package:brasil_fields/brasil_fields.dart';
import 'package:cga_app/app/core/constants/text_constants.dart';
import 'package:cga_app/app/core/enums/entity_status_enum.dart';
import 'package:cga_app/app/core/enums/entity_status_filter_enum.dart';
import 'package:cga_app/app/core/ui/models/app_crud_item.dart';
import 'package:cga_app/app/core/ui/styles/app_text_styles.dart';
import 'package:cga_app/app/core/ui/widgets/app_combo_box.dart';
import 'package:cga_app/app/core/ui/widgets/app_crud_form_dialog.dart';
import 'package:cga_app/app/core/ui/widgets/app_crud_layout.dart';
import 'package:cga_app/app/core/ui/widgets/app_date_picker_form_field.dart';
import 'package:cga_app/app/core/ui/widgets/app_text_form_field.dart';
import 'package:cga_app/app/core/util/date_util.dart';
import 'package:cga_app/app/features/clinics/presentation/widgets/search_clinics_widget.dart';
import 'package:cga_app/app/features/groups/presentation/widgets/search_groups_widget.dart';
import 'package:cga_app/app/features/patients/domain/entities/patient.dart';
import 'package:cga_app/app/features/patients/presentation/controllers/patients_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:validatorless/validatorless.dart';

class PatientsPage extends StatefulWidget {
  const PatientsPage({super.key});

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  final controller = Get.find<PatientsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppCrudLayout(
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
            AppTextFormField(
              label: 'Nome',
              controller: controller.nameFilterEC,
            ),
            AppTextFormField(
              label: 'Telefone',
              controller: controller.phoneFilterEC,
            ),
            SearchClinicsWidget(
              tag: 'clinicFilter',
              onItemTap: (clinic) {
                controller.clinicFilterSelected = clinic;
              },
              initialId: controller.clinicFilterSelected?.id,
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
            title: item.nome,
            subtitle: item.telefone,
            active: item.ativo,
            secondSubtitle: 'Clínica: ${item.grupo.clinic.name}',
            data: item,
          );
        }),
        onItemTap: (item) {
          final patient = item.data;
          controller.editingPatient = patient;
          final entity = controller.editingPatient;
          controller.nameEC.text = entity!.nome;
          controller.phoneEC.text = entity.telefone;
          controller.startDateEC.text = DateUtil.dateTimeToPTBRDate(
            entity.dataInicio,
          );
          controller.endDateEC.text = DateUtil.dateTimeToPTBRDate(
            entity.dataEncerramento,
          );
          controller.startWeightEC.text = entity.pesoInicial.toString();
          controller.groupSelected = entity.grupo;
          controller.active = EntityStatusEnum.fromBoolean(entity.ativo);
          _showDialog();
        },
        itemContentBuilder: (context, item) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Telefone: ${item.data.telefone}',
                style: context.textStyles.textMedium,
              ),
              Row(
                spacing: 10,
                children: [
                  Text(
                    'Clínica: ${item.data.grupo.clinic.name}',
                    style: context.textStyles.textMedium,
                  ),
                  Text(
                    '/',
                    style: context.textStyles.textMedium,
                  ),
                  Text(
                    'Grupo: ${item.data.grupo.name}',
                    style: context.textStyles.textMedium,
                  ),
                ],
              ),
              Row(
                spacing: 10,
                children: [
                  Text(
                    'Data início: ${DateUtil.dateTimeToPTBRDate(item.data.dataInicio)}',
                    style: context.textStyles.textMedium,
                  ),
                  Text(
                    '- Data fim: ${DateUtil.dateTimeToPTBRDate(item.data.dataEncerramento)}',
                    style: context.textStyles.textMedium,
                  ),
                ],
              ),
              Text(
                'Peso inicial: ${item.data.pesoInicial}',
                style: context.textStyles.textBold,
              ),
            ],
          );
        },
      ),
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
              validator: Validatorless.required(TextConstants.requiredField),
            ),
            AppTextFormField(
              label: 'Telefone',
              controller: controller.phoneEC,
              isRequired: true,
              validator: Validatorless.required(TextConstants.requiredField),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                TelefoneInputFormatter(),
              ],
            ),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: AppDatePickerFormField(
                    label: 'Data início',
                    controller: controller.startDateEC,
                    isRequired: true,
                    validator: Validatorless.required(
                      TextConstants.requiredField,
                    ),
                  ),
                ),
                Expanded(
                  child: AppDatePickerFormField(
                    label: 'Data fim',
                    controller: controller.endDateEC,
                    isRequired: true,
                    validator: Validatorless.required(
                      TextConstants.requiredField,
                    ),
                  ),
                ),
              ],
            ),
            AppTextFormField(
              label: 'Peso inicial',
              controller: controller.startWeightEC,
              isRequired: true,
              validator: Validatorless.required(TextConstants.requiredField),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                PesoInputFormatter(),
              ],
            ),
            SearchGroupsWidget(
              tag: 'form',
              isRequired: true,
              onItemTap: (group) {
                controller.groupSelected = group;
              },
              initialId: controller.groupSelected?.id,
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
          onSave: () async => controller.addPatient(),
          formKey: controller.formKey,
          onEdit: () async => controller.updatePatient(),
        );
      },
    );
    controller.clearForm();
  }
}
