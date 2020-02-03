import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeIn extends StatelessWidget {
  const FadeIn({this.delay, this.child});

  final double delay;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final MultiTrackTween tween = MultiTrackTween(<Track<dynamic>>[
      Track<double>('opacity').add(const Duration(milliseconds: 500),
          Tween<double>(begin: 0.0, end: 1.0),
          curve: Curves.fastOutSlowIn),
      Track<double>('translateX').add(const Duration(milliseconds: 500),
          Tween<double>(begin: 130.0, end: 0.0),
          curve: Curves.easeOut)
    ]);

    // ignore: always_specify_types
    return ControlledAnimation(
      delay: Duration(milliseconds: (300 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild:
          (BuildContext context, Widget child, dynamic animation) => Opacity(
        // ignore: argument_type_not_assignable
        opacity: animation['opacity'],
        child: Transform.translate(
            // ignore: argument_type_not_assignable
            offset: Offset(animation['translateX'], 0),
            child: child),
      ),
    );
  }
}
