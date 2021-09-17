import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practical/src/constants/colors.constants.dart';
import 'package:practical/src/constants/dimens.constants.dart';
import 'package:practical/src/constants/drawable.constants.dart';
import 'package:practical/src/constants/misc.constants.dart';
import 'package:practical/src/constants/validation.constants.dart';
import 'package:practical/src/services/api.service.dart';
import 'package:practical/src/support/textfield.widget.dart';
import 'package:practical/src/support/visual_handler.widget.dart';
import 'package:practical/src/utils/empty.util.dart';
import 'package:practical/src/extensions/context.x.dart';
import 'package:practical/src/extensions/pixel.x.dart';

class AddNewUser extends StatefulWidget {
  const AddNewUser({
    Key? key,
  }) : super(key: key);

  @override
  _AddNewUserState createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUser> {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();

  var _focusFirst = FocusNode();
  var _focusJob = FocusNode();
  bool isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 80),
      curve: Curves.easeInOut,
      child: Container(
        padding: EdgeInsets.all(kContentPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            VisualHandle(),
            VerticalSpace(kSpaceLarge),
            Text(
              "Add New User",
              style: TextStyle(
                  fontSize: 22.dp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            VerticalSpace(kSpaceBig),
            getFirstNameTextField(),
            VerticalSpace(kSpaceBig),
            getJobTextField(),
            VerticalSpace(kSpaceHuge),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: textButtonStyle(),
                onPressed: () {
                  addUserToDb();
                },
                child: Text(
                  'Add User',
                  style: TextStyle(
                      fontSize: 14.dp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  addUserToDb() {
    if (isButtonEnabled) {
      Map<String, dynamic> req = HashMap<String, dynamic>();
      req["name"] = _firstnameController.text;
      req["job"] = _jobController.text;
      Api().addUsers(req).then((value) async {
        print(value.toJson());
        await context.showMessage("User Added Successfully!");
        Navigator.of(context).pop();
      });
    } else {
      context.showMessage("Something went wrong!");
    }
  }

  bool checkValidation() {
    if (isEmpty(_firstnameController.text)) {
      isButtonEnabled = false;
      return false;
    } else if (isEmpty(_jobController.text)) {
      isButtonEnabled = false;
      return false;
    }
    isButtonEnabled = true;
    return true;
  }

  getFirstNameTextField() {
    return CommonTextfield(
      focusNode: _focusFirst,
      textOption: TextFieldOption(
        labelText: "Name",
        hintText: "Name",
        maxLine: 1,
        keyboardType: TextInputType.text,
        inputController: _firstnameController,
        formatter: [
          FilteringTextInputFormatter.deny(RegExp(RegexForTextField))
        ],
      ),
      textCallback: (text) {
        setState(() {
          checkValidation();
        });
      },
      inputAction: TextInputAction.next,
      onNextPress: () {
        setFocus(node: _focusJob, context: context);
      },
    );
  }

  getJobTextField() {
    return CommonTextfield(
      autoCorrect: false,
      focusNode: _focusJob,
      textOption: TextFieldOption(
        labelText: "Job",
        hintText: "Job",
        maxLine: 1,
        keyboardType: TextInputType.emailAddress,
        inputController: _jobController,
        formatter: [FilteringTextInputFormatter.deny(RegExp(RegexForEmoji))],
      ),
      textCallback: (text) {
        setState(() {
          checkValidation();
        });
      },
      inputAction: TextInputAction.done,
      onNextPress: () {
        setFocus(context: context);
      },
    );
  }
}
