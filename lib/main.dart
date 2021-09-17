import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practical/src/app.dart';
import 'package:practical/src/utils/pref.util.dart';

Future runDependents() async {
  await PrefUtils().initialize();
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom])
      .then((value) => {
            SystemChrome.setPreferredOrientations(
                [DeviceOrientation.portraitUp]).then((value) {
              runDependents().then((value) {
                runApp(App());
              });
            })
          });
}
