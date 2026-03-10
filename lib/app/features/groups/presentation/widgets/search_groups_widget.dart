import 'package:cga_app/app/core/ui/models/app_crud_item.dart';
import 'package:cga_app/app/core/ui/widgets/search/app_search_entity_dialog.dart';
import 'package:cga_app/app/core/ui/widgets/search/select_entity_widget.dart';
import 'package:cga_app/app/features/groups/bindings/search_group_bindings.dart';
import 'package:cga_app/app/features/groups/data/enums/search_group_filter_item.dart';
import 'package:cga_app/app/features/groups/domain/entities/group.dart';
import 'package:cga_app/app/features/groups/presentation/controllers/search_groups_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class SearchGroupsWidget extends StatefulWidget {
  final void Function(Group?) onItemTap;
  final String? initialId;
  final String tag;
  const SearchGroupsWidget({
    super.key,
    required this.onItemTap,
    this.initialId,
    required this.tag,
  });

  @override
  State<SearchGroupsWidget> createState() => _SearchGroupsWidgetState();
}

class _SearchGroupsWidgetState extends State<SearchGroupsWidget> {
  late SearchGroupsController controller;

  @override
  void initState() {
    super.initState();

    if (!Get.isRegistered<SearchGroupsController>(tag: widget.tag)) {
      SearchGroupBindings(tag: widget.tag).dependencies();
    }

    controller = Get.find<SearchGroupsController>(tag: widget.tag);

    if (widget.initialId != null && widget.initialId!.isNotEmpty) {
      controller.loadGroupById(widget.initialId!);
    } else {
      controller.selectGroup(null);
    }
  }

  @override
  void didUpdateWidget(covariant SearchGroupsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialId != widget.initialId) {
      if (widget.initialId != null && widget.initialId!.isNotEmpty) {
        controller.loadGroupById(widget.initialId!);
      } else {
        controller.selectGroup(null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SelectEntityWidget(
        label: 'Grupos',
        value: controller.groupSelected.value?.name,
        onTap: () async {
          await Get.dialog(
            Obx(
              () => AppSearchEntityDialog<Group>(
                controller: controller,
                filterItems: SearchGroupFilterItem.items,
                title: 'Pesquisar Grupos',
                items: controller.items
                    .map(
                      (i) => AppCrudItem(
                        title: i.name,
                        active: i.active,
                        subtitle: i.description,
                        data: i,
                      ),
                    )
                    .toList(),
                onItemTap: (group) {
                  controller.selectGroup(group);
                  widget.onItemTap(group);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
