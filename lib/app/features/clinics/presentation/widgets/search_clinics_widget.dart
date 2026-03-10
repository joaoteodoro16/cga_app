import 'package:cga_app/app/core/ui/models/app_crud_item.dart';
import 'package:cga_app/app/core/ui/widgets/search/app_search_selector_widget.dart';
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
  @override
  Widget build(BuildContext context) {
    return AppSearchSelectorWidget<Clinic, SearchClinicsController>(
      tag: widget.tag,
      label: 'Clínica',
      dialogTitle: 'Pesquisar clínicas',
      initialId: widget.initialId,
      filterItems: SearchClinicFilterItem.items,
      isControllerRegistered: (tag) => Get.isRegistered<SearchClinicsController>(tag: tag),
      registerDependencies: (tag) => SearchClinicsBindings(tag).dependencies(),
      findController: (tag) => Get.find<SearchClinicsController>(tag: tag),
      selectedLabel: (clinic) => clinic.name,
      itemBuilder: (clinic) => AppCrudItem(
        title: clinic.name,
        active: clinic.active,
        subtitle: clinic.cnpj,
        data: clinic,
      ),
      onItemTap: widget.onItemTap,
    );
  }
}
