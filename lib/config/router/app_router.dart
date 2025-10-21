import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rika_morti_mobile/config/router/app_route_names.dart';
import 'package:rika_morti_mobile/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:rika_morti_mobile/features/home/presentation/bloc/home_bloc.dart';
import 'package:rika_morti_mobile/features/injection_container.dart';
import 'package:rika_morti_mobile/features/main/presentation/bloc/main_bloc.dart';
import 'package:rika_morti_mobile/features/main/presentation/screens/main_screen.dart';

final rootKey = GlobalKey<NavigatorState>();
final GoRouter router = GoRouter(
  navigatorKey: rootKey,
  initialLocation: AppRouteNames.main,
  observers: [GoRouterObserver()],
  routes: <RouteBase>[
    GoRoute(
      path: AppRouteNames.main,
      name: AppRouteNames.main,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider<MainBloc>(create: (context) => sl<MainBloc>()),
          BlocProvider<HomeBloc>(
            create: (context) => sl<HomeBloc>()..add(GetCharactersEvent()),
          ),
          BlocProvider<FavoritesBloc>(
            create: (context) => sl<FavoritesBloc>()..add(LoadFavoritesEvent()),
          ),
        ],
        child: MainScreen(),
      ),
    ),
  ],
);

class GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('didPush: ${route.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('didPop: ${route.settings.name}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('didRemove: ${route.settings.name}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    debugPrint('didReplace: ${newRoute?.settings.name}');
  }
}
