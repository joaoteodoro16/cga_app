import 'package:cga_app/app/core/ui/models/app_crud_item.dart';
import 'package:cga_app/app/core/ui/widgets/app_combo_box.dart';
import 'package:cga_app/app/core/ui/widgets/app_crud_layout.dart';
import 'package:cga_app/app/core/ui/widgets/app_text_form_field.dart';
import 'package:cga_app/app/features/patients/domain/entities/patient.dart';
import 'package:flutter/material.dart';

class PatientsPage extends StatelessWidget {
  const PatientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCrudLayout(
      pageTitle: 'Pacientes',
      page: 1,
      totalPages: 10,
      onPreviousPage: () {},
      onNextPage: () {},
      onSearch: () {},
      onNew: () {},
      onFilterClean: () {},
      filters: Column(
        spacing: 10,
        children: [
          AppTextFormField(label: 'Nome', controller: TextEditingController()),
          AppTextFormField(
            label: 'Telefone',
            controller: TextEditingController(),
          ),
          AppComboBox(
            items: ['Nenhum', 'Grupo1', 'Grupo2', 'Grupo3', 'Grupo4'],
            itemLabel: (item) => item,
            initialValue: 'Grupo1',
            hint: 'Grupos',
          ),
          AppComboBox(
            items: ['Nenhum', 'Clinica1', 'Clinica2', 'Clinica3', 'Clinica4'],
            itemLabel: (item) => item,
            initialValue: 'Clinica1',
            hint: 'Clinicas',
          ),
        ],
      ),
      items: List.generate(
        20,
        (index) => AppCrudItem<Patient>(
          title: 'Paciente $index',
          subtitle: 'Descrição do paciente $index',
          active: true,
          data: Patient(id: 'id', name: 'name', groups: [], startDate: DateTime.now(), endDate: DateTime.now(), startingWeight: 1)
        ),
      ),
      onItemTap: (item) {},
    );
  }
}
