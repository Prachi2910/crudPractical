import 'package:flutter/material.dart';
import 'package:practical/src/constants/dimens.constants.dart';
import 'package:practical/src/constants/misc.constants.dart';

/// Builds a background with a gradient from top to bottom.
///
/// The [colors] default to the [AppTheme.backgroundColors] if omitted.
class PrimaryContainer extends StatelessWidget {
  Widget? child;
  BorderRadius? borderRadius = BorderRadius.circular(kCardRadius);

  PrimaryContainer(
      {this.child,
      Duration duration: const Duration(seconds: 1),
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    final backgroundColors = Colors.white;

    return AnimatedContainer(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: backgroundColors,
      ),
      duration: kThemeAnimationDuration,
      child: Material(
        color: Colors.transparent,
        child: Directionality(
            textDirection: deviceTextDirection, child: child ?? Container()),
      ),
    );
  }
}
