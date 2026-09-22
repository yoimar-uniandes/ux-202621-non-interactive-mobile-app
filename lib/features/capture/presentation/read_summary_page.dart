import 'package:fakto_mobile/design/app_colors.dart';
import 'package:fakto_mobile/features/capture/presentation/camera_capture_page.dart';
import 'package:fakto_mobile/features/home/presentation/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class ReadSummaryPage extends StatelessWidget {
  const ReadSummaryPage({super.key});

  static const routeName = 'read-summary';
  static const routePath = '/capture/read-summary';

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _CloseButton(onPressed: () => context.go(HomePage.routePath)),
              const SizedBox(height: 8),
              Text(
                'Revisa lo que leímos',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Confirma o corrige los datos antes de crear el recordatorio.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              const _ReadPhotoCard(),
              const SizedBox(height: 16),
              const _ReadField(label: 'Emisor', value: 'EPM'),
              const SizedBox(height: 16),
              const _ReadField(label: 'Concepto', value: 'Servicio público'),
              const SizedBox(height: 16),
              const _ReadField(label: 'Valor', value: r'$ 800.000'),
              const SizedBox(height: 16),
              const _ReadField(label: 'Fecha límite', value: '28/09/2026'),
              const SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _SummaryButton(
                      label: 'Corregir',
                      onPressed: () => context.go(CameraCapturePage.routePath),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _SummaryButton(
                      label: 'Confirmar',
                      isPrimary: true,
                      onPressed: () => context.go(HomePage.routePath),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _CloseButton extends StatelessWidget {
  const _CloseButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: 'Cerrar revisión',
    child: Material(
      color: AppColors.surface,
      shape: const CircleBorder(
        side: BorderSide(color: AppColors.neutral500),
      ),
      child: InkWell(
        key: const Key('read-summary-close-button'),
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: const SizedBox.square(
          dimension: 48,
          child: Icon(Icons.close, size: 24, color: AppColors.textPrimary),
        ),
      ),
    ),
  );
}

class _ReadPhotoCard extends StatelessWidget {
  const _ReadPhotoCard();

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
                'factura-epm-septiembre.jpg',
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