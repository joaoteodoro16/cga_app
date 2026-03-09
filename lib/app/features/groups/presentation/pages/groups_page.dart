import 'package:cga_app/app/core/ui/models/app_crud_item.dart';
import 'package:cga_app/app/core/ui/widgets/app_crud_layout.dart';
import 'package:cga_app/app/core/ui/widgets/app_text_form_field.dart';
import 'package:cga_app/app/features/clinics/presentation/widgets/search_clinics_widget.dart';
import 'package:cga_app/app/features/groups/domain/entities/group.dart';
import 'package:cga_app/app/features/groups/presentation/controllers/groups_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';

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
        page: 1,
        totalPages: 10,
        onPreviousPage: () {},
        onNextPage: () {},
        onSearch: () {},
        onNew: () {},
        onFilterClean: () {},
        filters: Column(
          children: [
            AppTextFormField(
              label: 'Nome',
              controller: TextEditingController(),
            ),
            const SizedBox(height: 10),
            Obx(
              () => SearchClinicsWidget(
                description: _controller.clinicSelected?.name,
                onItemTap: (clinic) {
                  _controller.clinicSelected = clinic;
                },
              ),
            ),
          ],
        ),
        items: List.generate(_controller.items.length, (index) {
          final item = _controller.items[index];
          return AppCrudItem<Group>(
            title: 'Grupo $index',
            subtitle: 'Descrição do grupo $index',
            active: item.active,
            data: item,
          );
        }),
        onItemTap: (item) {},
      ),
    );
  }
}
