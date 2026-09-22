import 'package:fakto_mobile/design/app_colors.dart';
import 'package:fakto_mobile/features/capture/presentation/read_summary_page.dart';
import 'package:fakto_mobile/features/home/presentation/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class AudioCapturePage extends StatelessWidget {
  const AudioCapturePage({super.key});

  static const routeName = 'audio-capture';
  static const routePath = '/capture/audio';

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
    value: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.canvas,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
    child: Scaffold(
      body: SafeArea(
        child: Stack(
          key: const Key('audio-capture-page'),
          children: <Widget>[
            Positioned(
              top: 16,
              left: 16,
              child: Semantics(
                button: true,
                label: 'Cerrar grabación',
                child: Material(
                  color: AppColors.surface,
                  shape: const CircleBorder(
                    side: BorderSide(color: AppColors.neutral500),
                  ),
                  child: InkWell(
                    key: const Key('audio-close-button'),
                    onTap: () => context.go(HomePage.routePath),
                    customBorder: const CircleBorder(),
                    child: const SizedBox.square(
                      dimension: 48,
                      child: Icon(
                        Icons.close,
                        size: 24,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 204,
              left: 16,
              right: 16,
              child: Text(
                'Grabando...',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Positioned(
              top: 280,
              left: 16,
              right: 16,
              height: 120,
              child: _AudioWavePlaceholder(),
            ),
            Positioned(
              top: 424,
              left: 0,
              right: 0,
              child: Text(
                '00:12',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 184,
              child: Text(
                'Di el emisor, el valor y la fecha límite.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 88,
              child: Center(
                child: Semantics(
                  button: true,
                  label: 'Detener grabación',
                  child: Material(
                    color: AppColors.error500,
                    shape: const CircleBorder(),
                    child: InkWell(
                      key: const Key('audio-stop-button'),
                      onTap: () => context.go(
                        '${ReadSummaryPage.routePath}?source=audio',
                      ),
                      customBorder: const CircleBorder(),
                      child: const DecoratedBox(
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: SizedBox.square(
                          dimension: 72,
                          child: Center(
                            child: Icon(
                              Icons.stop,
                              size: 28,
                              color: AppColors.secondary900,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _AudioWavePlaceholder extends StatelessWidget {
  const _AudioWavePlaceholder();

  @override
  Widget build(BuildContext context) => CustomPaint(
    painter: _AudioWavePainter(),
    child: const SizedBox.expand(),
  );
}

class _AudioWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()..color = const Color(0xFFFFDFD5);
    final linePaint = Paint()
      ..color = AppColors.primary500
      ..strokeWidth = 1;

    canvas.drawRect(Offset.zero & size, backgroundPaint);
    canvas.drawLine(Offset.zero, Offset(size.width, size.height), linePaint);
    canvas.drawLine(
      Offset(0, size.height),
      Offset(size.width, 0),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}