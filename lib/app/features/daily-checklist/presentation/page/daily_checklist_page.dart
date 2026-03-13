import 'package:cga_app/app/features/daily-checklist/domain/entities/check_list.dart';
import 'package:cga_app/app/features/daily-checklist/presentation/widgets/filter_checklist.dart';
import 'package:cga_app/app/features/daily-checklist/presentation/widgets/info_checklist.dart';
import 'package:cga_app/app/features/daily-checklist/presentation/widgets/daily_checklist_card.dart';
import 'package:cga_app/app/features/patients/domain/entities/patient.dart';
import 'package:flutter/material.dart';

class DailyChecklistPage extends StatelessWidget {
  const DailyChecklistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CheckList> list = List.generate(
      5,
      (index) => CheckList(
        patient: Patient(
          id: 'patient-$index',
          nome: 'Paciente ${index + 1}',
          grupo: null,
          grupoId: 'grupo-${index + 1}',
          dataInicio: DateTime.now(),
          dataEncerramento: DateTime.now().add(const Duration(days: 30)),
          pesoInicial: 80 + index.toDouble(),
          telefone: '(00) 00000-000$index',
          ativo: true,
        ),
        breakfast: index % 2 == 0,
        morningSnack: index % 3 != 0,
        lunch: true,
        afternoonSnack: index % 2 != 0,
        dinner: index % 4 != 0,
        training: index % 3 == 0,
        scale: index != 3,
        weight: index != 3 ? 79.5 + index : null,
        weightDifference: index != 3 ? (-2.5 + (index * 0.4)) : null,
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Daily Checklist')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 10,
          children: [
            FilterChecklist(),
            const SizedBox(height: 10),
            InfoChecklist(),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final item = list[index];
                  return DailyChecklistCard(checklist: item);
                },
                itemCount: list.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
