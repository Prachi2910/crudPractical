import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practical/src/constants/colors.constants.dart';
import 'package:practical/src/constants/drawable.constants.dart';
import 'package:practical/src/support/anim/BounceInAnimation.dart';
import 'package:practical/src/support/primary_container.widget.dart';
import 'package:practical/src/extensions/pixel.x.dart';
import 'package:practical/src/ui/auth/signUp/screen/create_profile.screen.dart';
import 'package:practical/src/ui/home/dashboard/screen/dashboard.screen.dart';
import 'package:practical/src/utils/pref.util.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    callHandler();
  }

  Future openNextScreen() async {
    if (PrefUtils().getUserData()?.email != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Dashboard()),
          (Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => SignUp()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(50.dp),
                child: Container(
                  child: BounceInAnimation(
                    delay: Duration(milliseconds: 1000),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            icn_logo,
                            fit: BoxFit.contain,
                            height: 250.dp,
                            width: double.infinity,
                          ),
                          Text(
                            "Demo App",
                            style: TextStyle(
                                fontSize: 38.dp,
                                color: accent,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0.dp,
                right: 0.dp,
                child: Padding(
                  padding: EdgeInsets.all(26.dp),
                  child: Text(
                    "v0.0.1",
                    style: TextStyle(
                        fontSize: 12.dp,
                        color: complimentry80,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              )
            ],
          )),
    );
  }

  void callHandler() {
    Timer(
      Duration(seconds: 3),
      () => (openNextScreen()),
    );
  }
}
