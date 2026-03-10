import 'package:cga_app/app/core/constants/text_constants.dart';
import 'package:cga_app/app/core/enums/entity_status_enum.dart';
import 'package:cga_app/app/core/ui/models/app_crud_item.dart';
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
          children: [
            AppTextFormField(
              label: 'Nome',
              controller: _controller.nameFilterEC,
            ),
            const SizedBox(height: 10),
            SearchClinicsWidget(
              tag: 'clinic_filter',
              initialId: _controller.clinicFilterSelected?.id,
              onItemTap: (clinic) {
                _controller.clinicFilterSelected = clinic;
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
            data: item,
          );
        }),
        onItemTap: (item) {
          final group = item.data;
          _controller.editingGroup = group;
          _controller.nameEC.text = group.name;
          _controller.descriptionEC.text = group.description ?? '';
          _controller.active = EntityStatusEnum.fromBoolean(group.active);
          _controller.clinicSelected = null;
          _showDialog();
        },
      ),
    );
  }

  Future<void> _showDialog() async {
    showDialog(
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
