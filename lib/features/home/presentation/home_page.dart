import 'package:fakto_mobile/app/fakto_app_scope.dart';
import 'package:fakto_mobile/design/app_colors.dart';
import 'package:fakto_mobile/design/widgets/fakto_bottom_navigation_bar.dart';
import 'package:fakto_mobile/design/widgets/fakto_reminder_card.dart';
import 'package:fakto_mobile/features/capture/presentation/camera_capture_page.dart';
import 'package:fakto_mobile/features/capture/presentation/audio_capture_page.dart';
import 'package:fakto_mobile/features/capture/presentation/widgets/capture_menu_overlay.dart';
import 'package:fakto_mobile/features/home/presentation/widgets/monthly_summary_card.dart';
import 'package:fakto_mobile/features/reminders/domain/reminder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = 'home';
  static const routePath = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  static const _menuEnterDuration = Duration(milliseconds: 300);
  static const _menuExitDuration = Duration(milliseconds: 220);

  late final AnimationController _captureMenuController;
  bool _isCaptureMenuMounted = false;
  bool _isCaptureMenuClosing = false;

  @override
  void initState() {
    super.initState();
    _captureMenuController = AnimationController(
      vsync: this,
      duration: _menuEnterDuration,
      reverseDuration: _menuExitDuration,
    );
  }

  @override
  void dispose() {
    _captureMenuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
    value: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.surface,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
    child: Stack(
      children: <Widget>[
        Scaffold(
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
                  MonthlySummaryCard(
                    summary: FaktoAppScope.of(context).monthlySummary,
                  ),
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
                  if (FaktoAppScope.of(context).capturedReminder
                      case final Reminder capturedReminder) ...<Widget>[
                    const SizedBox(height: 16),
                    FaktoReminderCard(
                      key: const Key('captured-reminder-card'),
                      dueLabel: _formatDueLabel(capturedReminder.dueDate),
                      serviceName: capturedReminder.issuer,
                      amount: formatPesos(capturedReminder.amountCents),
                    ),
                  ],
                ],
              ),
            ),
          ),
          bottomNavigationBar: ColoredBox(
            color: AppColors.surface,
            child: SafeArea(
              top: false,
              child: FaktoBottomNavigationBar(onAddPressed: _openCaptureMenu),
            ),
          ),
        ),
        if (_isCaptureMenuMounted)
          Positioned.fill(
            child: CaptureMenuOverlay(
              animation: _captureMenuController,
              isClosing: _isCaptureMenuClosing,
              onDismiss: () {
                _dismissCaptureMenu();
              },
              onRecordAudio: _goToAudio,
              onTakePhoto: () {
                _goToCamera();
              },
            ),
          ),
      ],
    ),
  );

  void _openCaptureMenu() {
    if (_isCaptureMenuMounted) return;

    setState(() {
      _isCaptureMenuMounted = true;
      _isCaptureMenuClosing = false;
    });

    if (_prefersReducedMotion) {
      _captureMenuController.value = 1;
    } else {
      _captureMenuController.forward(from: 0);
    }
  }

  Future<void> _dismissCaptureMenu() async {
    if (!_isCaptureMenuMounted || _isCaptureMenuClosing) return;

    setState(() => _isCaptureMenuClosing = true);

    if (_prefersReducedMotion) {
      _captureMenuController.value = 0;
    } else {
      await _captureMenuController.reverse();
    }

    if (!mounted) return;

    setState(() {
      _isCaptureMenuMounted = false;
      _isCaptureMenuClosing = false;
    });
  }

  Future<void> _goToCamera() async {
    await _dismissCaptureMenu();
    if (mounted) context.go(CameraCapturePage.routePath);
  }

  Future<void> _goToAudio() async {
    await _dismissCaptureMenu();
    if (mounted) context.go(AudioCapturePage.routePath);
  }

  bool get _prefersReducedMotion =>
      MediaQuery.maybeOf(context)?.disableAnimations ?? false;

  String _formatDueLabel(DateTime dueDate) =>
      'Vence el ${dueDate.day.toString().padLeft(2, '0')}/${dueDate.month.toString().padLeft(2, '0')}/${dueDate.year}';
}
