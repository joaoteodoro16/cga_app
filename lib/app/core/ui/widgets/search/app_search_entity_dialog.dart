import 'package:cga_app/app/core/controller/base_dialog_pagination_controller.dart';
import 'package:cga_app/app/core/ui/models/app_crud_item.dart';
import 'package:cga_app/app/core/ui/models/base_search_filter_item.dart';
import 'package:cga_app/app/core/ui/widgets/app_button.dart';
import 'package:cga_app/app/core/ui/styles/app_colors.dart';
import 'package:cga_app/app/core/ui/styles/app_text_styles.dart';
import 'package:cga_app/app/core/ui/widgets/app_combo_box.dart';
import 'package:cga_app/app/core/ui/widgets/app_text_form_field.dart';
import 'package:cga_app/app/core/util/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

class AppSearchEntityDialog<T> extends StatefulWidget {
  final void Function(T?) onItemTap;
  final String title;
  final BaseDialogPaginationController controller;
  final List<AppCrudItem<T>> items;
  final List<BaseSearchFilterItem> filterItems;

  const AppSearchEntityDialog({
    super.key,
    required this.onItemTap,
    required this.title,
    required this.controller,
    required this.items,
    required this.filterItems,
  });

  @override
  State<AppSearchEntityDialog<T>> createState() =>
      _AppSearchEntityDialogState<T>();
}

class _AppSearchEntityDialogState<T> extends State<AppSearchEntityDialog<T>> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await widget.controller.load();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ScreenUtils.isMobile(context);
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800, maxHeight: 1000),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  IconButton(
                    onPressed: () {
                      widget.controller.clearFilter();
                      Get.back();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(20),
                child: Flex(
                  direction: isMobile ? Axis.vertical : Axis.horizontal,
                  children: [
                    isMobile
                        ? AppTextFormField(
                            label: 'Pesquisar',
                            controller: widget.controller.searchText,
                            enabled: !widget.controller.isLoading,
                          )
                        : Expanded(
                            child: AppTextFormField(
                              label: 'Pesquisar',
                              controller: widget.controller.searchText,
                              enabled: !widget.controller.isLoading,
                            ),
                          ),
                    SizedBox(
                      width: isMobile ? double.infinity : 250,
                      child: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: AppComboBox<BaseSearchFilterItem>(
                          items: widget.filterItems,
                          itemLabel: (item) => item.label,
                          initialValue: widget.controller.filterSelected,
                          hint: "Filtrar por",
                          onChanged: (value) {
                            widget.controller.filterSelected = value;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: AppButton(
                    title: 'Pesquisar',
                    onPressed: !widget.controller.isLoading
                        ? () async {
                            await widget.controller.search();
                          }
                        : null,
                    width: 180,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (widget.controller.isLoading) {
                return const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: widget.items.isEmpty
                          ? const Center(
                              child: Text('Nenhum registro encontrado'),
                            )
                          : ListView.separated(
                              itemCount: widget.items.length,
                              separatorBuilder: (_, _) => Divider(
                                height: .1,
                                color: AppColors.borderColor,
                              ),
                              itemBuilder: (context, index) {
                                final item = widget.items[index];
                                return ListTile(
                                  tileColor: item.active
                                      ? AppColors.white
                                      : AppColors.lightGrey,
                                  title: Text(
                                    item.title,
                                    style: context.textStyles.textRegular
                                        .copyWith(fontSize: 16),
                                  ),
                                  subtitle: item.subtitle != null
                                      ? Text(
                                          item.subtitle!,
                                          style: context.textStyles.textRegular
                                              .copyWith(fontSize: 14),
                                        )
                                      : null,
                                  trailing: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: item.active
                                          ? AppColors.activeTileEntityColor
                                          : AppColors.inactiveTileEntityColor,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    child: Center(
                                      child: Text(
                                        item.active ? 'A' : 'I',
                                        style: context.textStyles.textRegular
                                            .copyWith(color: AppColors.white),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    widget.onItemTap.call(item.data);
                                    Get.back();
                                  },
                                );
                              },
                            ),
                    ),
                    _buildPagination(context),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildPagination(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.lightGrey)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: widget.controller.page > 1
                ? widget.controller.previousPage
                : null,
            icon: const Icon(Icons.chevron_left),
          ),
          Text(
            'Página ${widget.controller.page} de ${widget.controller.totalPages}',
            style: context.textStyles.textRegular,
          ),
          IconButton(
            onPressed: widget.controller.page < widget.controller.totalPages
                ? widget.controller.nextPage
                : null,
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
