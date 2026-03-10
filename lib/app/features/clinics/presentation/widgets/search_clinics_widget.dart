import 'package:cga_app/app/core/ui/models/app_crud_item.dart';
import 'package:cga_app/app/core/ui/widgets/search/app_search_entity_dialog.dart';
import 'package:cga_app/app/core/ui/widgets/search/select_entity_widget.dart';
import 'package:cga_app/app/features/clinics/bindings/search_clinics_bindings.dart';
import 'package:cga_app/app/features/clinics/data/enums/search_clinic_filter_item.dart';
import 'package:cga_app/app/features/clinics/domain/entities/clinic.dart';
import 'package:cga_app/app/features/clinics/presentation/controllers/search_clinics_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchClinicsWidget extends StatefulWidget {
  final void Function(Clinic?) onItemTap;
  final String? initialId;
  final String tag;

  const SearchClinicsWidget({
    super.key,
    required this.onItemTap,
    this.initialId,
    required this.tag,
  });

  @override
  State<SearchClinicsWidget> createState() => _SearchClinicsWidgetState();
}

class _SearchClinicsWidgetState extends State<SearchClinicsWidget> {
  late SearchClinicsController controller;

  @override
  void initState() {
    super.initState();

    if (!Get.isRegistered<SearchClinicsController>(tag: widget.tag)) {
      SearchClinicsBindings(widget.tag).dependencies();
    }

    controller = Get.find<SearchClinicsController>(tag: widget.tag);

    if (widget.initialId != null && widget.initialId!.isNotEmpty) {
      controller.loadClinicById(widget.initialId!);
    } else {
      controller.selectClinic(null);
    }
  }

  @override
  void didUpdateWidget(covariant SearchClinicsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialId != widget.initialId) {
      if (widget.initialId != null && widget.initialId!.isNotEmpty) {
        controller.loadClinicById(widget.initialId!);
      } else {
        controller.selectClinic(null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SelectEntityWidget(
        label: 'Clínica',
        value: controller.clinicSelected.value?.name,
        onTap: () async {
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
                onItemTap: (clinic) {
                  controller.selectClinic(clinic);
                  widget.onItemTap(clinic);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
