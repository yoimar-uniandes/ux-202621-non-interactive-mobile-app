# Fakto Mobile

Prototipo Flutter para Android que captura recordatorios de pago mediante foto o nota de voz. No usa backend, cámara, micrófono, permisos ni red reales.

## Stack

- Android solamente; Flutter 3.47.4, Dart 3.13.3+, JDK 17.
- `go_router: 18.0.1` y `flutter_lints: 6.0.0` (Pub requiere versiones exactas sin el operador npm `~`).

```bash
flutter pub get
flutter analyze
flutter test
flutter build apk --debug
```

La paleta procede exclusivamente de `../mockups/Paleta de colores.pdf`; se ignora la paleta de `../support/Design System.pdf`.
