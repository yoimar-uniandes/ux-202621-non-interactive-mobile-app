import 'package:fakto_mobile/features/capture/presentation/camera_capture_page.dart';
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
  ],
);
