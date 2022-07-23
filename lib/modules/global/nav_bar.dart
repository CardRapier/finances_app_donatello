import 'package:finances_app_donatello/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavBar extends StatelessWidget {
  static Size? size;
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    final router = GoRouter.of(context);

    return Positioned(
      left: size!.width * 0.15,
      height: size!.height * 0.08,
      width: size!.width * 0.7,
      top: size!.height * 0.9,
      child: Container(
        decoration: BoxDecoration(
            color: ColorConstants.primaryWhite,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                spreadRadius: 3,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(30))),
        padding: const EdgeInsets.all(10),
        height: size!.height * 0.08,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          navBarButton(
              icon: Icons.home_rounded,
              selected: router.location == '/',
              onTap: () => context.go('/')),
          const SizedBox(
            width: 10,
          ),
          navBarButton(
              icon: Icons.attach_money_rounded,
              selected: router.location == '/random',
              onTap: () => context.go('/random')),
        ]),
      ),
    );
  }

  Widget navBarButton({required IconData icon, bool selected = false, onTap}) {
    return Expanded(
        child: GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: selected
                ? ColorConstants.primaryGrey
                : ColorConstants.primaryWhite,
            borderRadius: const BorderRadius.all(Radius.circular(30))),
        child: SizedBox(
          height: 40,
          child: Icon(
            icon,
            size: 25,
            color: selected ? ColorConstants.primaryColor : Colors.black,
          ),
        ),
      ),
    ));
  }
}
