import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practical/src/constants/colors.constants.dart';
import 'package:practical/src/constants/dimens.constants.dart';
import 'package:practical/src/constants/drawable.constants.dart';
import 'package:practical/src/constants/misc.constants.dart';
import 'package:practical/src/constants/validation.constants.dart';
import 'package:practical/src/extensions/pixel.x.dart';
import 'package:practical/src/extensions/context.x.dart';
import 'package:practical/src/model/login.response.dart';
import 'package:practical/src/support/primary_container.widget.dart';
import 'package:practical/src/support/textfield.widget.dart';
import 'package:practical/src/ui/auth/signIn/screen/login.screen.dart';
import 'package:practical/src/ui/auth/signUp/widget/header.widget.dart';
import 'package:practical/src/utils/empty.util.dart';
import 'package:practical/src/utils/pref.util.dart';
import 'package:practical/src/utils/string.utils.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  var _focusFirst = FocusNode();
  var _focusUser = FocusNode();
  var _focusLast = FocusNode();
  var _focusEmail = FocusNode();
  var _focusPassword = FocusNode();
  var _focusConfirmPassword = FocusNode();
  bool isButtonEnabled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (kDebugMode) {
      _lastnameController.text = 'TestLast';
      _firstnameController.text = 'TestFirst';
      _usernameController.text = 'TestFirst TestLast';
      _emailController.text = 'developerdev2509@gmail.com';
      _passwordController.text = 'tester';
      _confirmPasswordController.text = 'tester';
    }
    setState(() {
      isButtonEnabled = checkValidation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Column(
              children: [
                HeaderWidget(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: kContentPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getNameField(),
                      Padding(
                        padding: EdgeInsets.only(top: 16.dp),
                        child: getUserNameTextField(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16.dp),
                        child: getEmailTextField(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16.dp),
                        child: getPasswordTextField(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16.dp),
                        child: getRepeatPasswordTextField(),
                      ),
                      VerticalSpace(kSpaceHuge),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: textButtonStyle(),
                          onPressed: () {
                            callApiForRegistration(context);
                          },
                          child: Text(
                            'SignUp',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      VerticalSpace(kSpaceHuge)
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
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

  getUserNameTextField() {
    return CommonTextfield(
      focusNode: _focusUser,
      textOption: TextFieldOption(
        labelText: "User Name",
        hintText: "User Name",
        maxLine: 1,
        keyboardType: TextInputType.text,
        inputController: _usernameController,
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
        setFocus(node: _focusUser, context: context);
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
      inputAction: TextInputAction.next,
      onNextPress: () {
        setFocus(node: _focusPassword, context: context);
      },
    );
  }

  getPasswordTextField() {
    return CommonTextfield(
      focusNode: _focusPassword,
      textOption: TextFieldOption(
        labelText: "Password",
        hintText: "Password",
        maxLine: 1,
        keyboardType: TextInputType.text,
        isSecureTextField: true,
        inputController: _passwordController,
        formatter: [FilteringTextInputFormatter.deny(RegExp(RegexForEmoji))],
      ),
      textCallback: (text) {
        setState(() {
          checkValidation();
        });
      },
      inputAction: TextInputAction.done,
      onNextPress: () {
        setFocus(node: _focusConfirmPassword, context: context);
      },
    );
  }

  getRepeatPasswordTextField() {
    return CommonTextfield(
      focusNode: _focusConfirmPassword,
      textOption: TextFieldOption(
          hintText: "Confirm Password",
          labelText: "Confirm Password",
          maxLine: 1,
          keyboardType: TextInputType.text,
          inputController: _confirmPasswordController,
          isSecureTextField: true),
      textCallback: (text) {
        setState(() {
          checkValidation();
        });
      },
      inputAction: TextInputAction.done,
      onNextPress: () {
        setFocus(context: context);
        callApiForRegistration(context);
      },
    );
  }

  callApiForRegistration(BuildContext context) {
    if (isButtonEnabled) {
      if (checkConditionalValidation(context)) {
        PrefUtils().saveUser(UserData(
            email: _emailController.text,
            firstName: _firstnameController.text,
            lastName: _lastnameController.text,
            password: _passwordController.text,
            userName: _usernameController.text));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Login()),
            (Route<dynamic> route) => false);
      }
    } else {
      context.showMessage("All fields are mandatory!");
    }
  }

  bool checkValidation() {
    if (isEmpty(_firstnameController.text)) {
      isButtonEnabled = false;
      return false;
    } else if (isEmpty(_lastnameController.text)) {
      isButtonEnabled = false;
      return false;
    } else if (isEmpty(_usernameController.text)) {
      isButtonEnabled = false;
      return false;
    } else if (isEmpty(_confirmPasswordController.text)) {
      isButtonEnabled = false;
      return false;
    } else if (isEmpty(_emailController.text)) {
      isButtonEnabled = false;
      return false;
    } else if (isEmpty(_passwordController.text)) {
      isButtonEnabled = false;
      return false;
    }
    isButtonEnabled = true;
    return true;
  }

  bool checkConditionalValidation(BuildContext context) {
    if (!validateEmail(_emailController.text)) {
      context.showMessage("Please enter valid email!");
      return false;
    } else if (_passwordController.text.length < 6) {
      context.showMessage("Password must be atleast 6 character long!");
      return false;
    } else if (_passwordController.text != _confirmPasswordController.text) {
      context.showMessage("Password and confirm password must be same!");
      return false;
    }
    return true;
  }
}
