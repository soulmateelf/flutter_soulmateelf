import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:soulmate/utils/plugin/plugin.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..tween(
        "opacity",
        Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 500),
      ).thenTween(
        "translateY",
        Tween(begin: 20.0, end: 0.0),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInSine,
      );
    return PlayAnimationBuilder(
      tween: tween,
      duration: tween.duration,
      delay: Duration(milliseconds: (500 * delay).round()),
      child: child,
      builder: (_, movie, child) {
        return Opacity(
          opacity: movie.get("opacity"),
          child: Transform.translate(
            offset: Offset(

              movie.get("translateY"),0.0,
            ),
            child: child,
          ),
        );
      },
    );
  }
}
