import 'package:fakto_mobile/design/app_colors.dart';
import 'package:flutter/material.dart';

class CaptureMenuOverlay extends StatelessWidget {
  const CaptureMenuOverlay({
    required this.animation,
    required this.isClosing,
    required this.onDismiss,
    required this.onRecordAudio,
    required this.onTakePhoto,
    super.key,
  });

  final Animation<double> animation;
  final bool isClosing;
  final VoidCallback onDismiss;
  final VoidCallback onRecordAudio;
  final VoidCallback onTakePhoto;

  @override
  Widget build(BuildContext context) {
    final scrimAnimation = CurvedAnimation(
      parent: animation,
      curve: const Interval(0, 0.65, curve: Curves.easeOutCubic),
    );
    final closeAnimation = CurvedAnimation(
      parent: animation,
      curve: const Interval(0, 0.55, curve: Curves.easeOutCubic),
    );
    final photoAnimation = CurvedAnimation(
      parent: animation,
      curve: const Interval(0.18, 0.78, curve: Curves.easeOutCubic),
    );
    final audioAnimation = CurvedAnimation(
      parent: animation,
      curve: const Interval(0.36, 1, curve: Curves.easeOutCubic),
    );

    return AbsorbPointer(
      absorbing: isClosing,
      child: BlockSemantics(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalOrigin = constraints.maxWidth / 2 - 88;
            final safeBottom = MediaQuery.paddingOf(context).bottom;

            return Stack(
              key: const Key('capture-menu-overlay'),
              children: <Widget>[
                Positioned.fill(
                  child: FadeTransition(
                    key: const Key('capture-menu-scrim-transition'),
                    opacity: scrimAnimation,
                    child: Semantics(
                      button: true,
                      label: 'Cerrar menú de captura',
                      child: GestureDetector(
                        key: const Key('capture-menu-scrim'),
                        behavior: HitTestBehavior.opaque,
                        onTap: onDismiss,
                        child: const ColoredBox(
                          color: AppColors.captureMenuScrim,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: safeBottom + 40,
                  height: 184,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: horizontalOrigin,
                        top: 0,
                        child: _AnimatedCaptureControl(
                          key: const Key('record-audio-transition'),
                          animation: audioAnimation,
                          child: _CaptureOption(
                            key: const Key('record-audio-option'),
                            circleKey: const Key('record-audio-icon'),
                            width: 153,
                            label: 'Grabar audio',
                            icon: Icons.mic_none,
                            onTap: onRecordAudio,
                          ),
                        ),
                      ),
                      Positioned(
                        left: horizontalOrigin,
                        top: 72,
                        child: _AnimatedCaptureControl(
                          key: const Key('take-photo-transition'),
                          animation: photoAnimation,
                          child: _CaptureOption(
                            key: const Key('take-photo-option'),
                            circleKey: const Key('take-photo-icon'),
                            width: 142,
                            label: 'Tomar foto',
                            icon: Icons.photo_camera_outlined,
                            onTap: onTakePhoto,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 128,
                        child: Center(
                          child: _AnimatedCaptureControl(
                            key: const Key('close-button-transition'),
                            animation: closeAnimation,
                            travel: 0,
                            minimumScale: 0.82,
                            child: Semantics(
                              button: true,
                              label: 'Cerrar',
                              child: Material(
                                color: AppColors.primary500,
                                shape: const CircleBorder(),
                                child: InkWell(
                                  key: const Key('close-capture-menu-button'),
                                  onTap: onDismiss,
                                  customBorder: const CircleBorder(),
                                  child: const SizedBox.square(
                                    dimension: 56,
                                    child: Icon(
                                      Icons.close,
                                      size: 24,
                                      color: AppColors.secondary900,
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
              ],
            );
          },
        ),
      ),
    );
  }
}

class _AnimatedCaptureControl extends StatelessWidget {
  const _AnimatedCaptureControl({
    required this.animation,
    required this.child,
    this.travel = 16,
    this.minimumScale = 0.94,
    super.key,
  });

  final Animation<double> animation;
  final Widget child;
  final double travel;
  final double minimumScale;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: animation,
    child: child,
    builder: (context, child) {
      final progress = animation.value;

      return Opacity(
        opacity: progress,
        child: Transform.translate(
          offset: Offset(0, travel * (1 - progress)),
          child: Transform.scale(
            alignment: Alignment.centerLeft,
            scale: minimumScale + (1 - minimumScale) * progress,
            child: child,
          ),
        ),
      );
    },
  );
}

class _CaptureOption extends StatelessWidget {
  const _CaptureOption({
    required this.circleKey,
    required this.width,
    required this.label,
    required this.icon,
    required this.onTap,
    super.key,
  });

  final Key circleKey;
  final double width;
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: label,
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: 56,
        child: Row(
          children: <Widget>[
            Container(
              key: circleKey,
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                color: AppColors.info100,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(icon, size: 24, color: AppColors.info700),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.visible,
                style: Theme.of(context).textTheme.labelLarge
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
