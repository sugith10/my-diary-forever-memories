import 'package:flutter/material.dart';

class SizeTransitionPageRoute<T> extends PageRouteBuilder<T> {
  final Widget child;
  final Alignment alignment;
  final Curve curve;
  final Duration duration;
  final bool fullscreenDialog;

  SizeTransitionPageRoute({
    required this.child,
    required this.alignment,
    this.curve = Curves.linear,
    this.duration = const Duration(milliseconds: 200),
    this.fullscreenDialog = false,
  }) : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return child;
          },
          transitionDuration: duration,
          fullscreenDialog: fullscreenDialog,
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return Align(
      alignment: alignment,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: animation,
          curve: curve,
        ),
        child: child,
      ),
    );
  }
}


