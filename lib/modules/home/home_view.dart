import 'package:finances_app_donatello/modules/auth/providers/auth_provider.dart';
import 'package:finances_app_donatello/routes/routes_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  late AuthProvider authenticationInfo;
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    authenticationInfo = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: const Center(child: Text('Home')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await authenticationInfo.signOut();
          GoRouter.of(context).goNamed(RoutesConstants.login);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
