import 'package:flutter/material.dart';
import 'package:practical/src/constants/dimens.constants.dart';
import 'package:practical/src/ui/splash/splash.screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Practical',
        home: Splash(),
        builder: _builder,
      );
    });
  }

  Widget _builder(BuildContext context, Widget? child) {
    return Stack(
      children: <Widget>[
        ClipRRect(
            borderRadius: BorderRadius.circular(kSpaceZero), child: child),
      ],
    );
  }
}
