import 'package:flutter/material.dart';

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  final AxisDirection direction;

  SlideRightRoute({required this.page, child, required this.direction})
      : super(
          transitionDuration: const Duration(milliseconds: 400),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: getDirection(direction),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

Offset getDirection(AxisDirection direction) {
  switch (direction) {
    case AxisDirection.up:
      return const Offset(0, 1);

    case AxisDirection.down:
      return const Offset(0, -1);

    case AxisDirection.right:
      return const Offset(-1, 0);

    case AxisDirection.left:
      return const Offset(1, 0);
  }
}
