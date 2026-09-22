import 'package:fakto_mobile/app/fakto_app_scope.dart';
import 'package:fakto_mobile/app/router.dart';
import 'package:fakto_mobile/design/app_theme.dart';
import 'package:fakto_mobile/features/reminders/application/fakto_app_state.dart';
import 'package:flutter/material.dart';

class FaktoApp extends StatefulWidget {
  const FaktoApp({super.key});

  @override
  State<FaktoApp> createState() => _FaktoAppState();
}

class _FaktoAppState extends State<FaktoApp> {
  late final FaktoAppState _appState;

  @override
  void initState() {
    super.initState();
    _appState = FaktoAppState();
  }

  @override
  void dispose() {
    _appState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FaktoAppScope(
    notifier: _appState,
    child: MaterialApp.router(
      title: 'Fakto',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      routerConfig: appRouter,
    ),
  );
}
