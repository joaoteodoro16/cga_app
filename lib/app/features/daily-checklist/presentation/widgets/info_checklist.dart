import 'package:cga_app/app/core/ui/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class InfoChecklist extends StatelessWidget {
  const InfoChecklist({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildInfoItem(context, 'Pacintes hoje', '13'),
        _buildInfoItem(context, 'Concluidos', '2'),
        _buildInfoItem(context, 'Pendentes', '100'),
        _buildInfoItem(context, 'Pesagens hoje', '100'),
      ],
    );
  }

  Widget _buildInfoItem(BuildContext context, String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: context.textStyles.textMedium.copyWith(fontSize: 14),
        ),
        Text(
          value,
          style: context.textStyles.textMedium.copyWith(
            fontSize: 24,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}
