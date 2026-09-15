import 'package:fakto_mobile/design/app_colors.dart';
import 'package:flutter/material.dart';

class FaktoReminderCard extends StatelessWidget {
  const FaktoReminderCard({
    required this.dueLabel,
    required this.serviceName,
    required this.amount,
    this.isUrgent = false,
    super.key,
  });

  final String dueLabel;
  final String serviceName;
  final String amount;
  final bool isUrgent;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: 108,
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isUrgent ? AppColors.warning100 : AppColors.surface,
        border: Border.all(color: AppColors.neutral300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            dueLabel,
            style: (isUrgent ? textTheme.labelSmall : textTheme.bodySmall)
                ?.copyWith(
                  color: isUrgent
                      ? AppColors.warning900
                      : AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: 4),
          Text(serviceName, style: textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(amount, style: textTheme.titleLarge),
        ],
      ),
    );
  }
}
