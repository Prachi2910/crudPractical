import 'package:flutter/material.dart';
import 'package:practical/src/constants/colors.constants.dart';
import 'package:practical/src/constants/dimens.constants.dart';
import 'package:practical/src/constants/misc.constants.dart';
import 'package:practical/src/model/login.response.dart';
import 'package:practical/src/model/users_model.response.dart';
import 'package:practical/src/services/api.service.dart';
import 'package:practical/src/support/baselist.widget.dart';
import 'package:practical/src/ui/home/dashboard/widgets/bottomSheet.widget.dart';
import 'package:practical/src/ui/home/dashboard/widgets/drawer.widget.dart';
import 'package:practical/src/ui/home/dashboard/widgets/user.widget.dart';
import 'package:practical/src/utils/pref.util.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  _DashboardState();

  UserData? userData;

  List<UserModel> list = [];
  late BaseList userList;
  GlobalKey? refresherKey;
  int page = DEFAULT_PAGE;

  @override
  void initState() {
    super.initState();
    userData = PrefUtils().getUserData();
    userList = BaseList(BaseListState(
      refresherKey,
      enablePullDown: true,
      enablePullUp: true,
      isApiCalling: true,
      onPullToRefress: () {
        callApi(true);
      },
      onRefress: () {
        callApi(false);
      },
      onLoadMore: () {
        callApi(false);
      },
    ));
    WidgetsBinding.instance!.addPostFrameCallback((_) => callApi(false));
  }

  Future<bool> _onWillPop(BuildContext context) async {
    if (Navigator.of(context).canPop()) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Alert!"),
          content: Text("Do you want to exit?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text("yes"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        ),
      ).then((result) => result == true);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => _onWillPop(context),
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: accent,
              title: Text(
                "Dashboard",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: accent,
              elevation: 1,
              onPressed: () async {
                await _modalBottomSheetMenu(context);
                callApi(true);
              },
              child: Icon(
                Icons.add,
                color: complimentry,
              ),
            ),
            drawer: NavigationDrawer(
              userData: userData,
            ),
            body: userList));
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
          return AddNewUser();
        });
  }

  void callApi(bool isRefress) async {
    if (isRefress) {
      page = DEFAULT_PAGE;
      list.clear();
    }
    print(page);
    UsersListModel user;
    Map<String, dynamic> req = <String, dynamic>{};
    req["page"] = page;
    req["per_page"] = DEFAULT_LIMIT;
    user = await Api().getUsers(req);

    user.data!.forEach((element) {
      list.add(element);
    });
    userList.state.listCount = list.length;
    userList.state.totalCount = list.length;
    fillArrayList(list);
    page = page + 1;
    userList.state.setApiCalling(false);
  }

  void fillArrayList(List<UserModel> data) {
    userList.state.listItems = ListView.separated(
      // padding: EdgeInsets.all(Dimens.listPadding),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return UserTile(
          user: list[index],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          thickness: 1,
          height: 3,
        );
      },
    );

    userList.state.setApiCalling(false);
  }
}
