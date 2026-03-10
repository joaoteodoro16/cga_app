import 'package:cga_app/app/core/ui/models/app_crud_item.dart';
import 'package:cga_app/app/core/ui/widgets/search/app_search_selector_widget.dart';
import 'package:cga_app/app/features/groups/bindings/search_group_bindings.dart';
import 'package:cga_app/app/features/groups/data/enums/search_group_filter_item.dart';
import 'package:cga_app/app/features/groups/domain/entities/group.dart';
import 'package:cga_app/app/features/groups/presentation/controllers/search_groups_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  @override
  Widget build(BuildContext context) {
    return AppSearchSelectorWidget<Group, SearchGroupsController>(
      tag: widget.tag,
      label: 'Grupos',
      dialogTitle: 'Pesquisar Grupos',
      initialId: widget.initialId,
      filterItems: SearchGroupFilterItem.items,
      isControllerRegistered: (tag) =>
          Get.isRegistered<SearchGroupsController>(tag: tag),
      registerDependencies: (tag) =>
          SearchGroupBindings(tag: tag).dependencies(),
      findController: (tag) => Get.find<SearchGroupsController>(tag: tag),
      selectedLabel: (group) => group.name,
      itemBuilder: (group) => AppCrudItem(
        title: group.name,
        active: group.active,
        subtitle: group.description,
        data: group,
      ),
      onItemTap: widget.onItemTap,
    );
  }
}
