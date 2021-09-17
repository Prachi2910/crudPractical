import 'package:flutter/material.dart';
import 'package:practical/src/extensions/pixel.x.dart';

final Size sm = Size(8.dp, 4.dp);
final Size md = Size(16.dp, 8.dp);
final Size wd = Size(26.dp, 8.dp);
final Size lg = Size(24.dp, 14.dp);

final double kSpaceZero = 0.dp;
final double kSpaceTiny = 1.dp;
final double kSpaceSmall = 4.dp;
final double kSpaceNormal = 8.dp;
final double kSpaceLittleBig = 12.dp;
final double kSpaceBig = 16.dp;
final double kSpaceLarge = 24.dp;
final double kSpaceHuge = 32.dp;
final double kSpaceGiant = 44.dp;

final double kCardPadding = 16.dp;
final double kListPadding = 14.dp;
final double kInternalPadding = 12.dp;
final double kContentPadding = 26.dp;

final double kCardRadiusExtraSmall = 4.dp;
final double kCardRadiusSmall = 8.dp;
final double kCardRadius = 16.dp;
final double kCardRadiusBig = 32.dp;

class VerticalSpace extends StatelessWidget {
  final num space;
  const VerticalSpace(this.space);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(size: Size(0, space.toDouble()));
  }
}

class HorizontalSpace extends StatelessWidget {
  final num space;
  const HorizontalSpace(this.space);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(size: Size(space.toDouble(), 0));
  }
}
