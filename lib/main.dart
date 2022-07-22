import 'package:finances_app_donatello/modules/auth/providers/auth_provider.dart';
import 'package:finances_app_donatello/modules/home/provider/home_provider.dart';
import 'package:finances_app_donatello/routes/routes.dart';
import 'package:finances_app_donatello/utils/theme_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
            ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
          ],
          child: Builder(
        builder: (context) {
          return MaterialApp.router(
            theme: ThemeUtils.getTheme(),
            debugShowCheckedModeBanner: false,
            routeInformationProvider: Routes.router.routeInformationProvider,
            routeInformationParser: Routes.router.routeInformationParser,
            routerDelegate: Routes.router.routerDelegate,
          );
        },
      ),
    );
  }
}
