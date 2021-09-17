import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:practical/src/constants/colors.constants.dart';
import 'package:practical/src/support/flash.widget.dart';
import 'package:practical/src/extensions/pixel.x.dart';

extension BuildContextX on BuildContext {
  Future showMessage(
    String message, {
    String title = "Alert!",
  }) {
    return showFlash(
      context: this,
      duration: const Duration(seconds: 2),
      builder: (_, controller) {
        return Flash(
          controller: controller,
          brightness: Brightness.dark,
          boxShadows: [BoxShadow(blurRadius: 4)],
          alignment: Alignment.bottomRight,
          forwardAnimationCurve: Curves.easeIn,
          reverseAnimationCurve: Curves.easeOut,
          child: FlashBar(
            title: Text(
              title,
              style: TextStyle(
                  fontSize: 16.dp,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            content: Text(
              message,
              style: TextStyle(
                  fontSize: 12.dp,
                  color: complimentry80,
                  fontWeight: FontWeight.w600),
            ),
          ),
        );
      }, //
    );
  }
}
