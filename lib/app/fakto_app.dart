import 'package:fakto_mobile/app/router.dart';
import 'package:fakto_mobile/design/app_theme.dart';
import 'package:flutter/material.dart';

class FaktoApp extends StatelessWidget {
  const FaktoApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'Fakto',
    debugShowCheckedModeBanner: false,
    theme: buildAppTheme(),
    routerConfig: appRouter,
  );
}
