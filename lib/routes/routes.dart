import 'package:finances_app_donatello/modules/auth/views/auth_view.dart';
import 'package:finances_app_donatello/modules/auth/views/register_view.dart';
import 'package:finances_app_donatello/modules/home/views/add_expense.dart';
import 'package:finances_app_donatello/modules/home/views/home_view.dart';
import 'package:finances_app_donatello/routes/routes_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static final GoRouter router = GoRouter(
      initialLocation: '/',
      routes: <GoRoute>[
        GoRoute(
          name: RoutesConstants.home,
          path: '/',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              customTransition(childWidget: HomeView()),
        ),
        GoRoute(
          name: RoutesConstants.login,
          path: '/login',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              customTransition(childWidget: AuthView()),
        ),
        GoRoute(
          name: RoutesConstants.register,
          path: '/register',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              customTransition(childWidget: RegisterView()),
        ),
        GoRoute(
          name: RoutesConstants.addExpense,
          path: '/add-expense',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              customTransition(childWidget: AddExpense()),
        ),
      ],
      redirect: (state) {
        bool isAuthenticating =
            state.subloc == '/login' || state.subloc == '/register';
        bool isLoggedIn =
            FirebaseAuth.instance.currentUser != null ? true : false;

        if (!isLoggedIn) {
          return isAuthenticating ? null : '/login';
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
