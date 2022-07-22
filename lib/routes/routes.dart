import 'package:finances_app_donatello/modules/auth/views/auth_view.dart';
import 'package:finances_app_donatello/modules/home/home_view.dart';
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
        name: RoutesConstants.addExpense,
        path: '/add-expense',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            customTransition(childWidget: HomeView()),
      ),
    ],
    redirect: (state) {
        bool isAuthenticating = state.subloc == '/login';
        bool isOnBoard = state.subloc == '/';
        bool isLoggedIn =
            FirebaseAuth.instance.currentUser != null ? true : false;

        if (isLoggedIn) {
          // return null if the current location is already OnboardScreen to prevent looping
          return isOnBoard ? null : '/';
        }
        // only authenticate if a user is not logged in
        // #4
        else if (!isLoggedIn) {
          return isAuthenticating ? null : '/login'; // #5
        }

        return null;
      }
  );

  static CustomTransitionPage<void> customTransition(
      {required Widget childWidget}) {
    return CustomTransitionPage<void>(
      child: childWidget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }
}
