import 'package:fakto_mobile/design/app_colors.dart';
import 'package:fakto_mobile/features/home/presentation/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CameraCapturePage extends StatelessWidget {
  const CameraCapturePage({super.key});

  static const routeName = 'camera-capture';
  static const routePath = '/capture/camera';

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
        child: LayoutBuilder(
          builder: (context, constraints) => Stack(
            key: const Key('camera-capture-page'),
            children: <Widget>[
              Positioned(
                top: 16,
                left: 16,
                child: Semantics(
                  button: true,
                  label: 'Cerrar cámara',
                  child: Material(
                    color: AppColors.surface,
                    shape: const CircleBorder(
                      side: BorderSide(color: AppColors.neutral500),
                    ),
                    child: InkWell(
                      key: const Key('camera-close-button'),
                      onTap: () => context.go(HomePage.routePath),
                      customBorder: const CircleBorder(),
                      child: SizedBox.square(
                        dimension: 48,
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/camera/close.svg',
                            width: 14,
                            height: 14,
                            excludeFromSemantics: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 88,
                left: 16,
                right: 16,
                height: 456,
                child: SvgPicture.asset(
                  'assets/camera/camera-placeholder.svg',
                  fit: BoxFit.fill,
                  excludeFromSemantics: true,
                ),
              ),
              const _FramingGuide(
                left: 24,
                top: 96,
                assetName: 'assets/camera/frame-top-right.svg',
              ),
              const _FramingGuide(
                right: 24,
                top: 96,
                assetName: 'assets/camera/frame-top-left.svg',
              ),
              const _FramingGuide(
                left: 24,
                top: 496,
                assetName: 'assets/camera/frame-bottom-right.svg',
              ),
              const _FramingGuide(
                right: 24,
                top: 496,
                assetName: 'assets/camera/frame-bottom-left.svg',
              ),
              const Positioned(
                left: 16,
                right: 16,
                bottom: 172,
                child: Text(
                  'Encuadra la factura dentro del marco',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    height: 20 / 14,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 56,
                child: Center(
                  child: Semantics(
                    button: true,
                    label: 'Tomar foto',
                    child: Material(
                      color: Colors.transparent,
                      shape: const CircleBorder(),
                      child: InkWell(
                        key: const Key('camera-shutter-button'),
                        onTap: _simulateShutter,
                        customBorder: const CircleBorder(),
                        child: SizedBox.square(
                          dimension: 72,
                          child: SvgPicture.asset(
                            'assets/camera/shutter.svg',
                            excludeFromSemantics: true,
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
    ),
  );

  static void _simulateShutter() {}
}

class _FramingGuide extends StatelessWidget {
  const _FramingGuide({
    required this.top,
    required this.assetName,
    this.left,
    this.right,
  });

  final double top;
  final double? left;
  final double? right;
  final String assetName;

  @override
  Widget build(BuildContext context) => Positioned(
    top: top,
    left: left,
    right: right,
    width: 40,
    height: 40,
    child: SvgPicture.asset(assetName, fit: BoxFit.fill),
  );
}
