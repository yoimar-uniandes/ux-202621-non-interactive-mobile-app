import 'package:fakto_mobile/app/fakto_app_scope.dart';
import 'package:fakto_mobile/design/app_colors.dart';
import 'package:fakto_mobile/features/capture/presentation/audio_capture_page.dart';
import 'package:fakto_mobile/features/capture/presentation/camera_capture_page.dart';
import 'package:fakto_mobile/features/home/presentation/home_page.dart';
import 'package:fakto_mobile/features/reminders/domain/reminder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class ReadSummaryPage extends StatelessWidget {
  const ReadSummaryPage({this.isFromAudio = false, super.key});

  static const routeName = 'read-summary';
  static const routePath = '/capture/read-summary';

  final bool isFromAudio;

  @override
  Widget build(BuildContext context) {
    final appState = FaktoAppScope.of(context);
    final source = isFromAudio ? CaptureSource.audio : CaptureSource.photo;
    final selectedBatch = appState.selectedBatch;
    final selectedReminder =
        selectedBatch != null && selectedBatch.source == source
        ? selectedBatch.reminders.single
        : null;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          appState.discardSelectedBatch();
          context.go(HomePage.routePath);
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.canvas,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Revisa lo que leímos',
                    style: Theme.of(context).textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Confirma o corrige los datos antes de crear el recordatorio.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  isFromAudio
                      ? _ReadAudioCard(
                          transcript:
                              selectedBatch?.sourceReference ??
                              _ReadAudioCard.fallbackTranscript,
                        )
                      : _ReadPhotoCard(
                          fileName:
                              selectedBatch?.sourceReference ??
                              _ReadPhotoCard.fallbackFileName,
                        ),
                  const SizedBox(height: 16),
                  _ReadField(
                    label: 'Emisor',
                    value: selectedReminder?.issuer ?? 'EPM',
                  ),
                  const SizedBox(height: 16),
                  _ReadField(
                    label: 'Concepto',
                    value: selectedReminder?.concept ?? 'Servicio público',
                  ),
                  const SizedBox(height: 16),
                  _ReadField(
                    label: 'Valor',
                    value: selectedReminder == null
                        ? r'$ 800.000'
                        : formatPesos(selectedReminder.amountCents),
                  ),
                  const SizedBox(height: 16),
                  _ReadField(
                    label: 'Fecha límite',
                    value: selectedReminder == null
                        ? '28/09/2026'
                        : _formatDate(selectedReminder.dueDate),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: _SummaryButton(
                          label: 'Corregir',
                          onPressed: () => context.go(
                            isFromAudio
                                ? AudioCapturePage.routePath
                                : CameraCapturePage.routePath,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _SummaryButton(
                          label: 'Confirmar',
                          isPrimary: true,
                          onPressed: () {
                            appState.confirmSelectedBatch();
                            context.go(HomePage.routePath);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
}

class _ReadPhotoCard extends StatelessWidget {
  const _ReadPhotoCard({required this.fileName});

  static const fallbackFileName = 'factura-epm-septiembre.jpg';

  final String fileName;

  @override
  Widget build(BuildContext context) => Container(
    key: const Key('read-photo-card'),
    height: 72,
    padding: const EdgeInsets.all(11),
    decoration: BoxDecoration(
      color: AppColors.info100,
      border: Border.all(color: AppColors.secondary900),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 48,
          height: 48,
          color: AppColors.surface,
          alignment: Alignment.center,
          child: const Icon(
            Icons.image_outlined,
            size: 28,
            color: AppColors.neutral500,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Leído de la foto',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                fileName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _ReadField extends StatelessWidget {
  const _ReadField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(label, style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 8),
      Container(
        width: double.infinity,
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: AppColors.canvas,
          border: Border.all(color: AppColors.neutral500),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(value, style: Theme.of(context).textTheme.bodyLarge),
      ),
    ],
  );
}

class _SummaryButton extends StatelessWidget {
  const _SummaryButton({
    required this.label,
    required this.onPressed,
    this.isPrimary = false,
  });

  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 48,
    child: Material(
      color: isPrimary ? AppColors.primary500 : AppColors.surface,
      shape: StadiumBorder(
        side: BorderSide(
          color: isPrimary ? AppColors.primary500 : AppColors.secondary900,
        ),
      ),
      child: InkWell(
        key: Key('${label.toLowerCase()}-read-summary-button'),
        onTap: onPressed,
        customBorder: const StadiumBorder(),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: isPrimary ? Colors.black : AppColors.secondary900,
            ),
          ),
        ),
      ),
    ),
  );
}

class _ReadAudioCard extends StatelessWidget {
  const _ReadAudioCard({required this.transcript});

  static const fallbackTranscript =
      '«EPM, ochocientos mil pesos, vence el veintiocho de septiembre.»';

  final String transcript;

  @override
  Widget build(BuildContext context) => Container(
    key: const Key('read-audio-card'),
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(15, 14, 15, 14),
    decoration: BoxDecoration(
      color: AppColors.info100,
      border: Border.all(color: AppColors.secondary900),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Nota de voz · 00:12 · grabada hoy',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        Text(transcript, style: Theme.of(context).textTheme.bodyMedium),
      ],
    ),
  );
}
