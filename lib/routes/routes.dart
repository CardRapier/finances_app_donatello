import 'package:finances_app_donatello/modules/auth/views/auth_view.dart';
import 'package:finances_app_donatello/modules/auth/views/register_view.dart';
import 'package:finances_app_donatello/modules/debts/views/debts_view.dart';
import 'package:finances_app_donatello/modules/home/views/add_expense.dart';
import 'package:finances_app_donatello/modules/home/views/home_view.dart';
import 'package:finances_app_donatello/routes/routes_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static final GoRouter router = GoRouter(
      initialLocation: RoutesConstants.home,
      routes: <GoRoute>[
        GoRoute(
          name: RoutesConstants.home,
          path: RoutesConstants.home,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              customTransition(childWidget: HomeView()),
        ),
        GoRoute(
          name: RoutesConstants.login,
          path: RoutesConstants.login,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              customTransition(childWidget: AuthView()),
        ),
        GoRoute(
          name: RoutesConstants.register,
          path: RoutesConstants.register,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              customTransition(childWidget: RegisterView()),
        ),
        GoRoute(
          name: RoutesConstants.addExpense,
          path: RoutesConstants.addExpense,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              customTransition(childWidget: AddExpense()),
        ),
        GoRoute(
          name: RoutesConstants.debts,
          path: RoutesConstants.debts,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              customTransition(childWidget: DebtsView()),
        ),
      ],
      redirect: (state) {
        bool isAuthenticating =
            state.subloc == RoutesConstants.login ||
            state.subloc == RoutesConstants.register;

        bool isLoggedIn =
            FirebaseAuth.instance.currentUser != null ? true : false;

        if (!isLoggedIn) {
          return isAuthenticating ? null : RoutesConstants.login;
        }

        return null;
      });

  static CustomTransitionPage<void> customTransition(
      {required Widget childWidget}) {
    return CustomTransitionPage<void>(
      child: childWidget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }
}
