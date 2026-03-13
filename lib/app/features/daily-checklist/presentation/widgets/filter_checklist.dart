import 'package:cga_app/app/core/ui/styles/app_colors.dart';
import 'package:cga_app/app/core/ui/styles/app_text_styles.dart';
import 'package:cga_app/app/core/ui/widgets/app_date_picker_form_field.dart';
import 'package:cga_app/app/core/util/screen_util.dart';
import 'package:cga_app/app/features/clinics/presentation/widgets/search_clinics_widget.dart';
import 'package:cga_app/app/features/groups/presentation/widgets/search_groups_widget.dart';
import 'package:flutter/material.dart';

class FilterChecklist extends StatefulWidget {
  const FilterChecklist({
    super.key,
    this.expandable = true,
    this.initiallyExpanded = true,
  });

  final bool expandable;
  final bool initiallyExpanded;

  @override
  State<FilterChecklist> createState() => _FilterChecklistState();
}

class _FilterChecklistState extends State<FilterChecklist> {
  late final TextEditingController _dateController;
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
    _isExpanded = !widget.expandable || widget.initiallyExpanded;
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ScreenUtils.isMobile(context);
    final dateField = AppDatePickerFormField(
      label: 'Data',
      controller: _dateController,
    );
    final clinicField = SearchClinicsWidget(onItemTap: (p0) {}, tag: 'filter');
    final groupField = SearchGroupsWidget(onItemTap: (p0) {}, tag: 'filter');

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.menuButtonShadow005,
            blurRadius: 4,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Filtros',
                    style: context.textStyles.textMedium.copyWith(
                      color: AppColors.primaryText,
                      fontSize: 19,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                if (widget.expandable)
                  IconButton(
                    onPressed: () => setState(() => _isExpanded = !_isExpanded),
                    icon: Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                    ),
                    tooltip: _isExpanded
                        ? 'Recolher filtros'
                        : 'Expandir filtros',
                  ),
              ],
            ),
            if (_isExpanded) ...[
              const SizedBox(height: 8),
              if (isMobile)
                Column(
                  children: [
                    dateField,
                    const SizedBox(height: 8),
                    clinicField,
                    const SizedBox(height: 8),
                    groupField,
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(child: dateField),
                    const SizedBox(width: 10),
                    Expanded(child: clinicField),
                    const SizedBox(width: 10),
                    Expanded(child: groupField),
                  ],
                ),
            ],
          ],
        ),
      ),
    );
  }
}
