import 'package:flutter/material.dart';
import 'package:rika_morti_mobile/config/router/app_router.dart';
import 'package:rika_morti_mobile/core/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    themeMode: ThemeMode.system,
    theme: lightTheme,
    darkTheme: darkTheme,
    themeAnimationDuration: Duration.zero,
    themeAnimationCurve: Curves.linear,
    routerDelegate: router.routerDelegate,
    routeInformationParser: router.routeInformationParser,
    routeInformationProvider: router.routeInformationProvider,
  );
}
