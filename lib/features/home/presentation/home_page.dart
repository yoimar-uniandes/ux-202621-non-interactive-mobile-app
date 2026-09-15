import 'package:fakto_mobile/design/app_colors.dart';
import 'package:fakto_mobile/design/widgets/fakto_bottom_navigation_bar.dart';
import 'package:fakto_mobile/design/widgets/fakto_reminder_card.dart';
import 'package:fakto_mobile/features/home/presentation/widgets/monthly_summary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = 'home';
  static const routePath = '/';

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
    value: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.surface,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
    child: Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Hola, Claudia',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 24),
              const MonthlySummaryCard(),
              const SizedBox(height: 24),
              Text(
                'Recordatorios',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const FaktoReminderCard(
                key: Key('epm-reminder-card'),
                dueLabel: 'Vence mañana',
                serviceName: 'EPM',
                amount: r'$ 800.000',
                isUrgent: true,
              ),
              const SizedBox(height: 16),
              const FaktoReminderCard(
                key: Key('administration-reminder-card'),
                dueLabel: 'En 2 días',
                serviceName: 'Administración',
                amount: r'$ 450.000',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const ColoredBox(
        color: AppColors.surface,
        child: SafeArea(
          top: false,
          child: FaktoBottomNavigationBar(onAddPressed: _simulateAdd),
        ),
      ),
    ),
  );

  static void _simulateAdd() {}
}
