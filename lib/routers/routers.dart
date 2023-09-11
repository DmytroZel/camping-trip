import 'package:camp_trip/feature/account/account_view.dart';
import 'package:camp_trip/feature/account/account_vm.dart';
import 'package:camp_trip/feature/create_trip/create_trip_vm.dart';
import 'package:camp_trip/feature/ingredients/add_ingredients/add_ingredients_view.dart';
import 'package:camp_trip/feature/ingredients/add_ingredients/add_ingredients_vm.dart';
import 'package:camp_trip/feature/login/login_page.dart';
import 'package:camp_trip/feature/login/login_vm.dart';
import 'package:camp_trip/feature/login/register/register_view.dart';
import 'package:camp_trip/feature/main/main_page.dart';
import 'package:camp_trip/feature/main/main_vm.dart';
import 'package:camp_trip/feature/trip/trip_vm.dart';
import 'package:camp_trip/feature/user_list/user_list_view.dart';
import 'package:camp_trip/routers/screen_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../feature/create_trip/create_trip_view.dart';
import '../feature/initial/initial_page.dart';
import '../feature/initial/initila_vm.dart';
import '../feature/login/register/register_vm.dart';
import '../feature/trip/trip_view.dart';
import '../feature/user_list/user_list_vm.dart';
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
      name: ScreenNames.register,
      path: ScreenNames.register,
      pageBuilder: (context, state) {
        return _buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: ChangeNotifierProvider(
            create: (context) => serviceLocator<RegisterVM>(),
            child: const RegisterView(),
          ),
        );
      },
    ),
    GoRoute(
      name: ScreenNames.userList,
      path: ScreenNames.userList,
      pageBuilder: (context, state) {
        return _buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: ChangeNotifierProvider(
            create: (context) => serviceLocator<UserListVm>(),
            child: const UserListView(),
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
      name: ScreenNames.ingredients,
      path: ScreenNames.ingredients,
      pageBuilder: (context, state) {
        return _buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: ChangeNotifierProvider(
            create: (context) => serviceLocator<AddIngredientsVM>(),
            child: const AddIngredientsView(),
          ),
        );
      },
    ),
    GoRoute(
      name: ScreenNames.trip,
      path: ScreenNames.trip,
      pageBuilder: (context, state) {
        return _buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: ChangeNotifierProvider(
            create: (context) => serviceLocator<TripVM>(param1: state.extra),
            child: const TripView(),
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
    GoRoute(
      name: ScreenNames.createTrip,
      path: ScreenNames.createTrip,
      pageBuilder: (context, state) {
        return _buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: ChangeNotifierProvider(
            create: (context) => serviceLocator<CreateTripVm>(),
            child: const CreateTrioView(),
          ),
        );
      },
    ),
    GoRoute(
      name: ScreenNames.account,
      path: ScreenNames.account,
      pageBuilder: (context, state) {
        return _buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: ChangeNotifierProvider(
            create: (context) => serviceLocator<AccountVM>(),
            child: const AccountView(),
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
