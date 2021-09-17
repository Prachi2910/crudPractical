import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:practical/src/constants/colors.constants.dart';
import 'package:practical/src/constants/dimens.constants.dart';
import 'package:practical/src/constants/drawable.constants.dart';
import 'package:practical/src/model/users_model.response.dart';
import 'package:practical/src/extensions/pixel.x.dart';
import 'package:practical/src/extensions/context.x.dart';
import 'package:practical/src/services/api.service.dart';
import 'package:practical/src/ui/home/dashboard/widgets/update_bottom_sheet.widget.dart';

class UserTile extends StatelessWidget {
  final UserModel? user;
  static const String FirstItem = 'Update';
  static const String SecondItem = 'Delete';
  static const List<String> choices = <String>[FirstItem, SecondItem];

  UserTile({this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: complimentry,
      ),
      child: Padding(
        padding:
            EdgeInsets.only(top: 19.dp, bottom: 19.dp, left: 4.dp, right: 8.dp),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            HorizontalSpace(kSpaceBig),
            Container(
              height: 30.dp,
              width: 30.dp,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kCardRadius),
                  image: user?.avatar != null
                      ? DecorationImage(
                          image: NetworkImage(user!.avatar!), fit: BoxFit.cover)
                      : DecorationImage(
                          image: AssetImage(icn_placeHolder),
                          fit: BoxFit.cover)),
            ),
            HorizontalSpace(kSpaceNormal),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  (user?.firstName ?? '') + " " + (user?.lastName ?? ""),
                  style: TextStyle(
                      fontSize: 16.dp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                HorizontalSpace(kSpaceSmall),
                Text(
                  user?.email ?? '',
                  style: TextStyle(
                      fontSize: 14.dp,
                      color: complimentry80,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            Spacer(),
            PopupMenuButton<String>(
              icon: SvgPicture.asset(
                icn_dot_menu,
                color: Colors.grey,
                height: 20,
                width: 15,
              ),
              onSelected: (choice) {
                choiceAction(choice, context);
              },
              itemBuilder: (BuildContext context) {
                return choices.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
      ),
    );
  }

  void choiceAction(String choice, BuildContext context) async {
    if (choice == FirstItem) {
      await _modalBottomSheetMenu(context);
    } else if (choice == SecondItem) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Alert!"),
          content: Text("Do you want to delete user?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("yes"),
              onPressed: () async {
                Api().deleteUsers(user!.id!).then((value) async {
                  await context.showMessage("User deleted Successfully!");
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        ),
      );
    }
  }

  Future _modalBottomSheetMenu(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(kCardRadius),
              topLeft: Radius.circular(kCardRadius)),
        ),
        backgroundColor: Colors.white,
        isScrollControlled: true,
        builder: (builder) {
          return UpdateUserWidget(
            user: user,
          );
        });
  }
}
