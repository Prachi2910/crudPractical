import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practical/src/constants/colors.constants.dart';
import 'package:practical/src/constants/dimens.constants.dart';
import 'package:practical/src/constants/misc.constants.dart';
import 'package:practical/src/constants/validation.constants.dart';
import 'package:practical/src/model/login.response.dart';
import 'package:practical/src/support/primary_container.widget.dart';
import 'package:practical/src/support/textfield.widget.dart';
import 'package:practical/src/ui/auth/signIn/widget/sign_header.widget.dart';
import 'package:practical/src/ui/home/dashboard/screen/dashboard.screen.dart';
import 'package:practical/src/utils/empty.util.dart';
import 'package:practical/src/utils/pref.util.dart';
import 'package:practical/src/utils/string.utils.dart';
import 'package:practical/src/extensions/pixel.x.dart';
import 'package:practical/src/extensions/context.x.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  var _focusEmail = FocusNode();
  var _focusPassword = FocusNode();
  bool isButtonEnabled = false;

  @override
  void dispose() {
    _focusEmail.dispose();
    _focusPassword.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (kDebugMode || kProfileMode) {
      _emailController.text = 'developerdev2509@gmail.com';
      _passwordController.text = 'tester';
    }

    setState(() {
      isButtonEnabled = enableDisableSigninButton();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SignInHeaderWidget(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kContentPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 16.dp),
                      child: getEmailTextField(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.dp),
                      child: getPasswordTextField(),
                    ),
                    getForgotPassword(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: textButtonStyle(),
                        onPressed: () {
                          callApiForLogin(context);
                        },
                        child: Text(
                          'SignIn',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              VerticalSpace(kSpaceHuge)
            ],
          ),
        ),
      ),
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
          isButtonEnabled = enableDisableSigninButton();
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
          inputController: _passwordController,
          isSecureTextField: true),
      textCallback: (text) {
        setState(() {
          isButtonEnabled = enableDisableSigninButton();
        });
      },
      inputAction: TextInputAction.done,
      onNextPress: () {
        setFocus(context: context);
        //callApiForLogin(context);
      },
    );
  }

  getForgotPassword() {
    return Container(
      alignment: Alignment.centerRight,
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.only(top: 12.dp, bottom: 28.dp),
          child: Text("Forget Password?",
              style: TextStyle(
                  fontSize: 14.dp,
                  color: complimentry80,
                  fontWeight: FontWeight.w600)),
        ),
        onTap: () {},
      ),
    );
  }

  bool enableDisableSigninButton() {
    if (isEmpty(_emailController.text) == true) {
      return false;
    } else if (validateEmail(_emailController.text) == false) {
      return false;
    } else if (isEmpty(_passwordController.text) == true) {
      return false;
    }
    return true;
  }

  callApiForLogin(BuildContext context) {
    if (enableDisableSigninButton()) {
      UserData? userData = PrefUtils().getUserData();
      if (userData != null &&
          userData.email == _emailController.text &&
          userData.password == _passwordController.text) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Dashboard()),
            (Route<dynamic> route) => false);
      } else {
        context.showMessage("User Don't exists!");
      }
    } else {
      context.showMessage("All fields are mandatory!");
    }
  }
}
