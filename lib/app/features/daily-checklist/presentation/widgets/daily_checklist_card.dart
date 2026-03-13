import 'package:cga_app/app/features/daily-checklist/domain/entities/check_list.dart';
import 'package:cga_app/app/core/ui/styles/app_colors.dart';
import 'package:cga_app/app/core/util/screen_util.dart';
import 'package:flutter/material.dart';

class DailyChecklistCard extends StatelessWidget {
  const DailyChecklistCard({super.key, required this.checklist});

  final CheckList checklist;

  @override
  Widget build(BuildContext context) {
    final patient = checklist.patient;
    final groupName = patient.grupo?.name ?? patient.grupoId;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.screenBackgroundColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            patient.nome,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Peso inicial: ${_formatKg(patient.pesoInicial)} kg • $groupName',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.labelText,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 14),
          LayoutBuilder(
            builder: (context, constraints) {
              final items = [
                ('Cafe da manha', checklist.breakfast),
                ('Lanche manha', checklist.morningSnack),
                ('Almoco', checklist.lunch),
                ('Lanche tarde', checklist.afternoonSnack),
                ('Jantar', checklist.dinner),
                ('Treinou', checklist.training),
              ];

              final spacing = 12.0;
              final columns = ScreenUtils.isDesktop(context)
                  ? 6
                  : ScreenUtils.isTablet(context)
                  ? 3
                  : 2;
              final itemWidth =
                  (constraints.maxWidth - (spacing * (columns - 1))) / columns;

              return Wrap(
                spacing: spacing,
                runSpacing: 14,
                children: [
                  for (final item in items)
                    SizedBox(
                      width: itemWidth,
                      child: _ChecklistToggle(label: item.$1, checked: item.$2),
                    ),
                ],
              );
            },
          ),
          if (checklist.scale) ...[
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                'Dia de balanca',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.secondary,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 108,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: Text(
                _formatKg(checklist.weight ?? patient.pesoInicial),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  height: 1,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryText,
                ),
              ),
            ),
            if (_resolveDifference() != null) ...[
              const SizedBox(height: 6),
              Text(
                _differenceLabel(_resolveDifference()!),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _resolveDifference()! <= 0
                      ? AppColors.success
                      : AppColors.error,
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }

  double? _resolveDifference() {
    if (checklist.weightDifference != null) {
      return checklist.weightDifference;
    }

    if (checklist.weight == null) {
      return null;
    }

    return checklist.weight! - checklist.patient.pesoInicial;
  }

  String _differenceLabel(double difference) {
    final prefix = difference < 0 ? '▼' : '▲';
    final textValue = _formatKg(difference.abs());
    return '$prefix $textValue kg desde inicio';
  }

  String _formatKg(double value) {
    return value.toStringAsFixed(1).replaceAll('.', ',');
  }
}

class _ChecklistToggle extends StatelessWidget {
  const _ChecklistToggle({required this.label, required this.checked});

  final String label;
  final bool checked;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.labelText,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            color: checked ? AppColors.primary : AppColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Icon(
            Icons.check,
            size: 18,
            color: checked ? AppColors.white : AppColors.transparent,
          ),
        ),
      ],
    );
  }
}
