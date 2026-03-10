import 'package:cga_app/app/core/ui/models/app_crud_item.dart';
import 'package:cga_app/app/core/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:cga_app/app/core/ui/styles/app_colors.dart';
import 'package:cga_app/app/core/ui/styles/app_text_styles.dart';

class AppCrudLayout extends StatefulWidget {
  final Widget filters;
  final List<AppCrudItem> items;
  final String pageTitle;
  final void Function(AppCrudItem)? onItemTap;

  final VoidCallback onSearch;
  final VoidCallback onNew;
  final VoidCallback onFilterClean;

  final int page;
  final int totalPages;
  final VoidCallback onPreviousPage;
  final VoidCallback onNextPage;

  const AppCrudLayout({
    super.key,
    required this.filters,
    required this.items,
    required this.onSearch,
    required this.onNew,
    required this.page,
    required this.totalPages,
    required this.onPreviousPage,
    required this.onNextPage,
    this.onItemTap,
    required this.pageTitle,
    required this.onFilterClean,
  });

  @override
  State<AppCrudLayout> createState() => _AppCrudLayoutState();
}

class _AppCrudLayoutState extends State<AppCrudLayout> {
  final ExpansibleController _filterController = ExpansibleController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 900;

        return Scaffold(
          appBar: AppBar(title: Text(widget.pageTitle)),
          floatingActionButton: isMobile
              ? FloatingActionButton(
                  backgroundColor: AppColors.secondary,
                  onPressed: widget.onNew,
                  child: const Icon(Icons.add),
                )
              : null,
          floatingActionButtonLocation: isMobile
              ? FloatingActionButtonLocation.startFloat
              : null,
          body: isMobile ? _buildMobile(context) : _buildDesktop(context),
        );
      },
    );
  }

  /// ---------------- DESKTOP ----------------
  Widget _buildDesktop(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: _buildFilters(context),
          ),
        ),
        Container(width: 1, color: AppColors.lightGrey),
        Expanded(flex: 2, child: _buildListSection(context)),
      ],
    );
  }

  Widget _buildMobile(BuildContext context) {
    return Column(
      children: [
        _buildMobileFilters(context),
        Expanded(child: _buildListSection(context)),
      ],
    );
  }

  /// ---------------- FILTROS ----------------
  Widget _buildFilters(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Filtros',
              style: context.textStyles.textMedium.copyWith(fontSize: 20),
            ),
            IconButton(
              onPressed: () {
                widget.onFilterClean();
              },
              icon: Icon(Icons.clear),
              tooltip: 'Limpar Filtros',
            ),
          ],
        ),
        const SizedBox(height: 16),
        widget.filters,
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: AppButton(onPressed: widget.onSearch, title: 'Pesquisar'),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AppButton(onPressed: widget.onNew, title: 'Novo Registro'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileFilters(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: ExpansionTile(
        controller: _filterController,
        initiallyExpanded: false,
        title: Row(
          children: [
            const Icon(Icons.filter_list),
            const SizedBox(width: 8),
            Text(
              'Filtros',
              style: context.textStyles.textMedium.copyWith(fontSize: 18),
            ),
          ],
        ),
        childrenPadding: const EdgeInsets.all(16),
        children: [
          widget.filters,
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  title: 'Limpar',
                  type: AppButtonType.primaryOutline,
                  onPressed: () {
                    widget.onFilterClean();
                    _filterController.collapse();
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: AppButton(
                  onPressed: () {
                    widget.onSearch();
                    _filterController.collapse();
                  },
                  title: 'Pesquisar',
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  /// ---------------- LISTA + PAGINAÇÃO ----------------
  Widget _buildListSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: widget.items.isEmpty
              ? const Center(child: Text('Nenhum registro encontrado'))
              : ListView.separated(
                  itemCount: widget.items.length,
                  separatorBuilder: (_, _) =>
                      Divider(height: .1, color: AppColors.borderColor),
                  itemBuilder: (context, index) {
                    final item = widget.items[index];
                    return ListTile(
                      tileColor: item.active
                          ? AppColors.white
                          : AppColors.lightGrey,
                      title: Text(
                        item.title,
                        style: context.textStyles.textRegular.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      subtitle: item.subtitle != null
                          ? Column(
                              spacing: 2,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.subtitle!,
                                  style: context.textStyles.textRegular
                                      .copyWith(fontSize: 14),
                                ),
                                Visibility(
                                  visible: item.secondSubtitle != null,
                                  child: Text(
                                    item.secondSubtitle ?? '',
                                    style: context.textStyles.textRegular
                                        .copyWith(
                                          fontSize: 14,
                                          color: AppColors.mediumGrey,
                                        ),
                                  ),
                                ),
                              ],
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
                            style: context.textStyles.textRegular.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                      onTap: () => widget.onItemTap?.call(item),
                    );
                  },
                ),
        ),
        _buildPagination(context),
      ],
    );
  }

  /// ---------------- PAGINAÇÃO ----------------
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
            onPressed: widget.page > 1 ? widget.onPreviousPage : null,
            icon: const Icon(Icons.chevron_left),
          ),
          Text(
            'Página ${widget.page} de ${widget.totalPages}',
            style: context.textStyles.textRegular,
          ),
          IconButton(
            onPressed: widget.page < widget.totalPages
                ? widget.onNextPage
                : null,
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
