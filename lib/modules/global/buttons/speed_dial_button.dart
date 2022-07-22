import 'package:finances_app_donatello/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class SpeedDialButton extends StatelessWidget {
  final double positionRight;
  final double positionTop;
  final List<SpeedDialChild> options;
  const SpeedDialButton({
    Key? key,
    required this.positionRight,
    required this.positionTop,
    required this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: positionRight,
        top: positionTop,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                spreadRadius: 3,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: SpeedDial(
            backgroundColor: ColorConstants.primaryWhite,
            direction: SpeedDialDirection.down,
            animatedIcon: AnimatedIcons.menu_close,
            animatedIconTheme:
                IconThemeData(color: ColorConstants.primaryColor),
            children: options,
          ),
        ));
  }
}
