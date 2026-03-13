import 'package:cga_app/app/core/controller/base_dialog_pagination_controller.dart';
import 'package:cga_app/app/core/ui/models/app_crud_item.dart';
import 'package:cga_app/app/core/ui/models/base_search_filter_item.dart';
import 'package:cga_app/app/core/ui/widgets/search/app_search_entity_dialog.dart';
import 'package:cga_app/app/core/ui/widgets/search/select_entity_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSearchSelectorWidget<
  T,
  C extends BaseDialogPaginationController<T>
>
    extends StatefulWidget {
  final String label;
  final String dialogTitle;
  final String tag;
  final String? initialId;
  final IconData? icon;
  final List<BaseSearchFilterItem> filterItems;
  final bool Function(String tag) isControllerRegistered;
  final void Function(String tag) registerDependencies;
  final C Function(String tag) findController;
  final String Function(T item) selectedLabel;
  final AppCrudItem<T> Function(T item) itemBuilder;
  final void Function(T?) onItemTap;
  final Widget Function(BuildContext context, AppCrudItem<T> item)? itemContentBuilder;

  const AppSearchSelectorWidget({
    super.key,
    required this.label,
    required this.dialogTitle,
    required this.tag,
    this.initialId,
    this.icon,
    required this.filterItems,
    required this.isControllerRegistered,
    required this.registerDependencies,
    required this.findController,
    required this.selectedLabel,
    required this.itemBuilder,
    required this.onItemTap, this.itemContentBuilder,
  });

  @override
  State<AppSearchSelectorWidget<T, C>> createState() =>
      _AppSearchSelectorWidgetState<T, C>();
}

class _AppSearchSelectorWidgetState<
  T,
  C extends BaseDialogPaginationController<T>
>
    extends State<AppSearchSelectorWidget<T, C>> {
  late final C controller;

  @override
  void initState() {
    super.initState();

    if (!widget.isControllerRegistered(widget.tag)) {
      widget.registerDependencies(widget.tag);
    }

    controller = widget.findController(widget.tag);
    _syncInitialId(widget.initialId);
  }

  @override
  void didUpdateWidget(covariant AppSearchSelectorWidget<T, C> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialId != widget.initialId) {
      _syncInitialId(widget.initialId);
    }
  }

  void _syncInitialId(String? id) {
    if (id != null && id.isNotEmpty) {
      controller.loadById(id);
      return;
    }

    controller.select(null);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selected = controller.selected.value;

      return SelectEntityWidget(
        label: widget.label,
        icon: widget.icon,
        value: selected != null ? widget.selectedLabel(selected) : null,
        onTap: () async {
          await Get.dialog(
            Obx(
              () => AppSearchEntityDialog<T>(
                controller: controller,
                filterItems: widget.filterItems,
                title: widget.dialogTitle,
                items: controller.items.map(widget.itemBuilder).toList(),
                onItemTap: (item) {
                  controller.select(item);
                  widget.onItemTap(item);
                },
                itemContentBuilder: widget.itemContentBuilder,
              ),
            ),
          );
        },
      );
    });
  }
}