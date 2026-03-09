import 'package:cga_app/app/core/ui/models/app_crud_item.dart';
import 'package:cga_app/app/core/ui/widgets/search/app_search_entity_dialog.dart';
import 'package:cga_app/app/core/ui/widgets/search/select_entity_widget.dart';
import 'package:cga_app/app/features/clinics/bindings/search_clinics_bindings.dart';
import 'package:cga_app/app/features/clinics/data/enums/search_clinic_filter_item.dart';
import 'package:cga_app/app/features/clinics/domain/entities/clinic.dart';
import 'package:cga_app/app/features/clinics/presentation/controllers/search_clinics_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchClinicsWidget extends StatelessWidget {
  final void Function(Clinic?) onItemTap;
  final String? description;
  const SearchClinicsWidget({
    super.key,
    required this.onItemTap,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SelectEntityWidget(
      label: 'Clínica',
      value: description,
      onTap: () async {
        if (!Get.isRegistered<SearchClinicsController>()) {
          SearchClinicsBindings().dependencies();
        }

        final controller = Get.find<SearchClinicsController>();

        await Get.dialog(
          Obx(
            () => AppSearchEntityDialog<Clinic>(
              controller: controller,
              filterItems: SearchClinicFilterItem.items,
              title: 'Pesquisar clínicas',
              items: controller.items
                  .map(
                    (i) => AppCrudItem(
                      title: i.name,
                      active: i.active,
                      subtitle: i.cnpj,
                      data: i,
                    ),
                  )
                  .toList(),
              onItemTap: onItemTap,
            ),
          ),
        );
      },
    );
  }
}
