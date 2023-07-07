import 'package:camp_trip/feature/login/login_page.dart';
import 'package:camp_trip/feature/login/login_vm.dart';
import 'package:camp_trip/feature/main/main_page.dart';
import 'package:camp_trip/feature/main/main_vm.dart';
import 'package:camp_trip/routers/screen_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../feature/initial/initial_page.dart';
import '../feature/initial/initila_vm.dart';
import '../main.dart';

class AppRouters {
  final r = GoRouter(initialLocation: ScreenNames.initial, routes: [
    GoRoute(
      name: ScreenNames.initial,
      path: ScreenNames.initial,
      pageBuilder: (context, state) {
        return _buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: ChangeNotifierProvider(
            create: (context) => serviceLocator<InitialVm>(),
            child: const InitialPage(),
          ),
        );
      },
    ),

    GoRoute(
      name: ScreenNames.logIn,
      path: ScreenNames.logIn,
      pageBuilder: (context, state) {
        return _buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: ChangeNotifierProvider(
            create: (context) => serviceLocator<LoginVm>(),
            child: const LoginPage(),
          ),
        );
      },
    ),

    GoRoute(
      name: ScreenNames.main,
      path: ScreenNames.main,
      pageBuilder: (context, state) {
        return _buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: ChangeNotifierProvider(
            create: (context) => serviceLocator<MainVm>(),
            child: const MainPage(),
          ),
        );
      },
    ),
  ]);

  static CustomTransitionPage<T> _buildPageWithDefaultTransition<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }
}
