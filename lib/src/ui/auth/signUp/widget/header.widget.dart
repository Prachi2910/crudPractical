import 'package:flutter/material.dart';
import 'package:practical/src/constants/colors.constants.dart';
import 'package:practical/src/constants/drawable.constants.dart';
import 'package:practical/src/extensions/pixel.x.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: -30.dp,
            top: -200.dp,
            child: Hero(
              tag: "BigCircle",
              child: Container(
                height: 399.dp,
                width: 399.dp,
                decoration: BoxDecoration(
                    color: accent, borderRadius: BorderRadius.circular(200.dp)),
              ),
            ),
          ),
          Positioned(
            right: -40.dp,
            top: -120.dp,
            child: Hero(
              tag: "SmallCircle",
              child: Container(
                width: 260.dp,
                height: 260.dp,
                decoration: BoxDecoration(
                  color: secondary,
                  borderRadius: BorderRadius.circular(150.dp),
                ),
              ),
            ),
          ),
          Positioned(
            left: 35.dp,
            top: 40.dp,
            child: Hero(
              tag: "header",
              child: Text("SignUp",
                  style: TextStyle(
                      fontSize: 28.dp,
                      color: complimentry,
                      fontWeight: FontWeight.w600)),
            ),
          ),
          Hero(
            tag: "logo",
            child: Center(
              child: Container(
                padding: EdgeInsets.only(top: 130.dp, bottom: 8.dp),
                child: Image.asset(
                  icn_logo,
                  width: double.infinity,
                  height: 180.dp,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
