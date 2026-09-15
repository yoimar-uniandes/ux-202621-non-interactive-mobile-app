import 'package:fakto_mobile/design/app_colors.dart';
import 'package:flutter/material.dart';

class MonthlySummaryCard extends StatelessWidget {
  const MonthlySummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      key: const Key('monthly-summary-card'),
      width: double.infinity,
      height: 208,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.secondary700,
        border: Border.all(color: AppColors.secondary700),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Total del mes',
            style: textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
          Text(
            r'$ 1.250.000',
            maxLines: 1,
            overflow: TextOverflow.clip,
            style: textTheme.displayMedium?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, thickness: 1, color: AppColors.neutral300),
          const SizedBox(height: 15),
          const Row(
            children: <Widget>[
              Expanded(
                child: _SummaryMetric(
                  label: 'Pendiente',
                  value: r'$ 1.250.000',
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _SummaryMetric(label: 'Pagado', value: r'$ 0'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            r'Incluye $ 120.000 arrastrados del mes anterior.',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodySmall?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _SummaryMetric extends StatelessWidget {
  const _SummaryMetric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: textTheme.bodySmall?.copyWith(color: Colors.white)),
        Text(
          value,
          maxLines: 1,
          style: textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
      ],
    );
  }
}
