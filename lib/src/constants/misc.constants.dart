import 'package:flutter/material.dart';
import 'package:practical/src/constants/dimens.constants.dart';

TextDirection deviceTextDirection = TextDirection.ltr;

const int DEFAULT_PAGE = 0;
const int DEFAULT_LIMIT = 10;

List<BoxShadow> getDefaultBoxShadow(
    {List<Color> color = const [Colors.black26], double elevation = 1}) {
  return color
      .map(
        (e) => BoxShadow(
          color: e,
          offset: Offset(0 * elevation, 2 * elevation),
          blurRadius: 2.0 * elevation,
        ),
      )
      .toList();
}

// Constant For
const screenDictKeyType = "type";
const screenDictKeyOtpType = "otpType";
const screenDictKeyEmail = "email";
const screenDictKeyPhone = "phone";
const screenDictKeyItem = "item";

const welcome = [
  "Anything I can help with?",
  "How can I help you today?",
  "What can I do for you?",
  "Tell me what do you want!"
];

void setFocus({required BuildContext context, FocusNode? node}) {
  if (node == null) {
    Focus.of(context).dispose();
  }
  FocusScope.of(context).requestFocus(node);
}

ButtonStyle textButtonStyle() {
  return ElevatedButton.styleFrom(
    primary: Colors.deepOrange,
    padding: EdgeInsets.all(kListPadding),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(kCardRadiusSmall),
    ),
  );
}
