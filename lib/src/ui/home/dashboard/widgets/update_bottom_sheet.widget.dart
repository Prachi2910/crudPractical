import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practical/src/constants/dimens.constants.dart';
import 'package:practical/src/constants/misc.constants.dart';
import 'package:practical/src/constants/validation.constants.dart';
import 'package:practical/src/model/users_model.response.dart';
import 'package:practical/src/services/api.service.dart';
import 'package:practical/src/support/textfield.widget.dart';
import 'package:practical/src/support/visual_handler.widget.dart';
import 'package:practical/src/utils/empty.util.dart';
import 'package:practical/src/extensions/context.x.dart';
import 'package:practical/src/extensions/pixel.x.dart';
import 'package:practical/src/utils/string.utils.dart';

class UpdateUserWidget extends StatefulWidget {
  const UpdateUserWidget({Key? key, required this.user}) : super(key: key);
  final UserModel? user;

  @override
  _UpdateUserWidgetState createState() => _UpdateUserWidgetState();
}

class _UpdateUserWidgetState extends State<UpdateUserWidget> {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  var _focusFirst = FocusNode();
  var _focusLast = FocusNode();
  var _focusEmail = FocusNode();
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _firstnameController.text = widget.user!.firstName!;
      _lastnameController.text = widget.user!.lastName!;
      _emailController.text = widget.user!.email!;
    }
    setState(() {});
  }

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
              "Update User",
              style: TextStyle(
                  fontSize: 22.dp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            VerticalSpace(kSpaceBig),
            getNameField(),
            VerticalSpace(kSpaceBig),
            getEmailTextField(),
            VerticalSpace(kSpaceHuge),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: textButtonStyle(),
                onPressed: () {
                  updateUserToDb();
                },
                child: Text(
                  'Update',
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

  updateUserToDb() {
    if (isButtonEnabled) {
      Map<String, dynamic> req = HashMap<String, dynamic>();
      req["first_name"] = _firstnameController.text;
      req["last_name"] = _lastnameController.text;
      req["email"] = _emailController.text;
      req["id"] = widget.user!.id;
      Api().updateUsers(req).then((value) async {
        print(value.toJson());
        await context.showMessage("User updated Successfully!");
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
    } else if (isEmpty(_lastnameController.text)) {
      isButtonEnabled = false;
      return false;
    } else if (isEmpty(_emailController.text) ||
        !validateEmail(_emailController.text)) {
      isButtonEnabled = false;
      return false;
    }
    isButtonEnabled = true;
    return true;
  }

  getNameField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: getFirstNameTextField(),
        ),
        Container(width: 16.dp),
        Expanded(
          child: getLastNameTextField(),
        )
      ],
    );
  }

  getFirstNameTextField() {
    return CommonTextfield(
      focusNode: _focusFirst,
      textOption: TextFieldOption(
        labelText: "First Name",
        hintText: "First Name",
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
        setFocus(node: _focusLast, context: context);
      },
    );
  }

  getLastNameTextField() {
    return CommonTextfield(
      focusNode: _focusLast,
      textOption: TextFieldOption(
        labelText: "Last Name",
        hintText: "Last Name",
        maxLine: 1,
        keyboardType: TextInputType.text,
        inputController: _lastnameController,
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
        setFocus(node: _focusEmail, context: context);
      },
    );
  }

  getEmailTextField() {
    return CommonTextfield(
      autoCorrect: false,
      focusNode: _focusEmail,
      textOption: TextFieldOption(
        labelText: "Email",
        hintText: "Email",
        maxLine: 1,
        keyboardType: TextInputType.emailAddress,
        inputController: _emailController,
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
