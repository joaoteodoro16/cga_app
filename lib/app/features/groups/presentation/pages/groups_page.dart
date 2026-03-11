import 'package:cga_app/app/core/constants/text_constants.dart';
import 'package:cga_app/app/core/enums/entity_status_enum.dart';
import 'package:cga_app/app/core/enums/entity_status_filter_enum.dart';
import 'package:cga_app/app/core/ui/models/app_crud_item.dart';
import 'package:cga_app/app/core/ui/widgets/app_combo_box.dart';
import 'package:cga_app/app/core/ui/widgets/app_crud_form_dialog.dart';
import 'package:cga_app/app/core/ui/widgets/app_crud_layout.dart';
import 'package:cga_app/app/core/ui/widgets/app_text_form_field.dart';
import 'package:cga_app/app/features/clinics/presentation/widgets/search_clinics_widget.dart';
import 'package:cga_app/app/features/groups/domain/entities/group.dart';
import 'package:cga_app/app/features/groups/presentation/controllers/groups_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:validatorless/validatorless.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({super.key});

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  final _controller = Get.find<GroupsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppCrudLayout(
        pageTitle: 'Grupos',
        page: _controller.page,
        totalPages: _controller.totalPages,
        onPreviousPage: _controller.previousPage,
        onNextPage: _controller.nextPage,
        onSearch: _controller.search,
        onNew: () => _showDialog(),
        onFilterClean: _controller.cleanFilters,
        filters: Column(
          spacing: 10,
          children: [
            AppTextFormField(
              label: 'Nome',
              controller: _controller.nameFilterEC,
            ),
            SearchClinicsWidget(
              tag: 'clinic_filter',
              initialId: _controller.clinicFilterSelected?.id,
              onItemTap: (clinic) {
                _controller.clinicFilterSelected = clinic;
              },
            ),
            AppComboBox<EntityStatusFilterEnum>(
              items: EntityStatusFilterEnum.values,
              itemLabel: (item) => item.description,
              initialValue: EntityStatusFilterEnum.values.first,
              hint: 'Status',
              onChanged: (value) {
                _controller.activeFilter = value;
              },
            ),
          ],
        ),
        items: List.generate(_controller.items.length, (index) {
          final item = _controller.items[index];
          return AppCrudItem<Group>(
            title: item.name,
            subtitle: item.description,
            active: item.active,
            secondSubtitle: 'Clínica: ${item.clinic?.name ?? 'N/A'}',
            data: item,
          );
        }),
        onItemTap: (item) {
          final group = item.data;
          _controller.editingGroup = group;
          final editingGroup = _controller.editingGroup;
          _controller.nameEC.text = editingGroup?.name ?? '';
          _controller.descriptionEC.text = editingGroup?.description ?? '';
          _controller.active = EntityStatusEnum.fromBoolean(
            editingGroup?.active ?? false,
          );
          _controller.clinicSelected = null;
          _showDialog();
        },
      ),
    );
  }

  Future<void> _showDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AppCrudFormDialog(
          editingEntity: _controller.editingGroup,
          title: 'Cadastrar Grupo',
          fields: [
            AppTextFormField(
              label: 'Nome',
              isRequired: true,
              controller: _controller.nameEC,
              validator: Validatorless.multiple([
                Validatorless.required(TextConstants.requiredField),
              ]),
            ),
            AppTextFormField(
              label: 'Descrição',
              controller: _controller.descriptionEC,
            ),
            SearchClinicsWidget(
              tag: 'clinic_form_${_controller.editingGroup?.id ?? 'new'}',
              initialId: _controller.editingGroup?.clinicId,
              onItemTap: (clinic) {
                _controller.clinicSelected = clinic;
              },
            ),
            AppComboBox<EntityStatusEnum>(
              items: EntityStatusEnum.values,
              itemLabel: (item) => item.description,
              initialValue: EntityStatusEnum.fromBoolean(
                _controller.active ?? true,
              ),
              hint: 'Status',
              onChanged: (value) {
                _controller.active = value!;
              },
            ),
          ],
          onSave: _controller.addGroup,
          formKey: _controller.formKey,
          onEdit: _controller.updateGroup,
        );
      },
    );
    _controller.cleanForm();
  }
}
