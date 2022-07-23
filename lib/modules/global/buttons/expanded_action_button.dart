import 'package:flutter/material.dart';
import 'dart:math' as math;

@immutable
class ExpandedActionButton extends StatelessWidget {
  const ExpandedActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
    this.top,
    this.bottom,
    this.left,
    this.right,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 200.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: (right ?? 4.0) + offset.dx,
          top: (top ?? 35.0) + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}
