import 'package:fakto_mobile/features/capture/presentation/camera_capture_page.dart';
import 'package:fakto_mobile/features/capture/presentation/read_summary_page.dart';
import 'package:fakto_mobile/features/capture/presentation/audio_capture_page.dart';
import 'package:fakto_mobile/features/home/presentation/home_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: HomePage.routePath,
  routes: <RouteBase>[
    GoRoute(
      path: HomePage.routePath,
      name: HomePage.routeName,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: CameraCapturePage.routePath,
      name: CameraCapturePage.routeName,
      builder: (context, state) => const CameraCapturePage(),
    ),
    GoRoute(
      path: ReadSummaryPage.routePath,
      name: ReadSummaryPage.routeName,
      builder: (context, state) => ReadSummaryPage(
        isFromAudio: state.uri.queryParameters['source'] == 'audio',
      ),
    ),
    GoRoute(
      path: AudioCapturePage.routePath,
      name: AudioCapturePage.routeName,
      builder: (context, state) => const AudioCapturePage(),
    ),
  ],
);
