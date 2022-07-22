import 'package:finances_app_donatello/modules/global/buttons/speed_dial_button.dart';
import 'package:finances_app_donatello/modules/global/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Layout extends StatelessWidget {
  static Size? size;
  final Widget child;
  final List<SpeedDialChild>? options;
  const Layout({Key? key, required this.child, this.options}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
        body: Stack(
      children: [
        child,
        const NavBar(),
        options != null
            ? SpeedDialButton(
                positionRight: size!.width * 0.05,
                positionTop: size!.height * 0.05,
                options: options!,
              )
            : const SizedBox()
      ],
    ));
  }
}
