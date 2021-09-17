import 'package:flutter/material.dart';
import 'package:practical/src/constants/colors.constants.dart';
import 'package:practical/src/constants/dimens.constants.dart';
import 'package:practical/src/model/login.response.dart';
import 'package:practical/src/extensions/pixel.x.dart';
import 'package:practical/src/ui/auth/signIn/screen/login.screen.dart';
import 'package:practical/src/utils/pref.util.dart';

class NavigationDrawer extends StatelessWidget {
  final UserData? userData;
  const NavigationDrawer({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          createDrawerHeader(userData),
          createDrawerBodyItem(
              icon: Icons.logout,
              text: 'SignOut',
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Login()),
                    (Route<dynamic> route) => false);
                PrefUtils().clearPreferenceAndDB();
              }),
        ],
      ),
    );
  }

  Widget createDrawerHeader(UserData? user) {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(color: accent),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 12.dp,
              left: 16.dp,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hi,",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.dp,
                          fontWeight: FontWeight.w500)),
                  VerticalSpace(kSpaceNormal),
                  Text(user?.userName ?? "",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.dp,
                          fontWeight: FontWeight.w500)),
                  VerticalSpace(kSpaceSmall),
                  Text(user?.email ?? "",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.dp,
                          fontWeight: FontWeight.w500)),
                ],
              )),
        ]));
  }

  Widget createDrawerBodyItem(
      {required IconData? icon,
      required String? text,
      GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              text!,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.dp,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
