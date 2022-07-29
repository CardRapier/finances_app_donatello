import 'package:finances_app_donatello/modules/global/buttons/expandable_fab.dart';
import 'package:finances_app_donatello/modules/global/nav_bar.dart';
import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  late Size size;
  final Widget child;
  final List<Widget>? options;
  final GlobalKey<ExpandableFabState>? menuKey;
  Layout({Key? key, required this.child, this.options, this.menuKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(

        body: SizedBox(
      child: Stack(
        children: [
          child,
          optionList(),
          const NavBar(),
        ],
      ),
    ));
  }

  Widget optionList() {
    return options != null
        ? Positioned(
            child: ExpandableFab(
              key: menuKey,
              distance: 100.0,
              children: options!,
            ),
          )
        : Container();
  }
}
