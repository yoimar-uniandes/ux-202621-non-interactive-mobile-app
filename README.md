# Fakto Mobile

[![Flutter](https://img.shields.io/badge/Flutter-3.47.4-02569B?logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.13.3-0175C2?logo=dart&logoColor=white)](https://dart.dev/)
[![Android](https://img.shields.io/badge/Target-Android-3DDC84?logo=android&logoColor=white)](https://www.android.com/)
[![Tests](https://img.shields.io/badge/tests-18%20passing-2E7D32)](#verificacion)

Aplicación Flutter para la captura visual de recordatorios de pago mediante foto o nota de voz. Es un prototipo no funcional: navegación, formularios, validaciones y datos simulados viven en el cliente, sin backend, red, permisos ni captura física de cámara o micrófono.

## Requisitos

- Flutter `3.47.4` y Dart `3.13.3`.
- Android SDK con un emulador o dispositivo Android disponible.
- JDK 17 o superior para el toolchain de Android.

## Ejecución local

Instale las dependencias de forma reproducible:

```bash
flutter pub get
```

Para identificar un emulador o dispositivo conectado, ejecute:

```bash
flutter devices
```

Durante el desarrollo, inicie la aplicación en un dispositivo disponible:

```bash
flutter run
```

Para una verificación equivalente al artefacto que se instala localmente, genere la APK de depuración:

```bash
flutter build apk --debug
flutter install
```

La APK se genera en `build/app/outputs/flutter-apk/app-debug.apk`.

## Verificación

Antes de generar la APK, ejecute las comprobaciones de calidad y comportamiento:

```bash
flutter analyze
flutter test
flutter build apk --debug
```

La suite cubre el estado simulado de recordatorios, navegación de captura, confirmación, descarte y reemplazo de facturas por foto y audio.

## Decisiones base

- Flutter estable, Dart y Material 3 para Android.
- GoRouter para rutas de los flujos de captura.
- Estado local compartido mediante `ChangeNotifier` e `InheritedNotifier`; no hay persistencia ni servicios remotos.
- `flutter_svg` para los íconos y guías de captura incluidos localmente.
- Tokens visuales, tema y componentes reutilizables centralizados en `lib/design/`.
- Lotes dummy deterministas: la última factura confirmada reemplaza la tarjeta capturada anterior y recalcula el resumen desde el estado base.

## Estructura

```text
lib/
├── app/       # composición, estado compartido y rutas
├── design/    # tema, tokens y componentes reutilizables
└── features/  # inicio, recordatorios y captura por foto o audio

assets/
├── camera/    # marco, obturador y recursos de captura
└── icons/     # iconografía de navegación

test/          # pruebas de estado, navegación y widgets
```

## Alcance de vistas

Las seis vistas mobile del prototipo están implementadas:

1. **Inicio:** resumen mensual y recordatorios simulados.
2. **Añadir:** menú animado para elegir captura por foto o audio.
3. **Captura por foto:** marco visual y obturador simulado.
4. **Resumen de foto:** confirmación o corrección de los datos leídos.
5. **Grabación de audio:** temporizador y control de detener simulados.
6. **Resumen de audio:** transcripción y confirmación de los datos leídos.

Las tres primeras vistas corresponden a Yoimar; las tres últimas, a Tatiana. El flujo conserva un único recordatorio capturado adicional: cada nueva confirmación reemplaza el anterior y actualiza los valores del resumen mensual.
