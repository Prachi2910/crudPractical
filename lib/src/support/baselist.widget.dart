import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practical/src/constants/colors.constants.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:practical/src/extensions/pixel.x.dart';

class BaseList extends StatefulWidget {
  BaseListState state;

  @override
  BaseListState createState() => state;

  BaseList(this.state);
}

class BaseListState extends State<BaseList> {
  BaseListState(this.refresherKey,
      {this.noDataMsg,
      this.noDataDesc,
      this.refreshBtn,
      this.imagePath,
      this.textColor,
      this.onPullToRefress,
      this.onLoadMore,
      this.onRefress,
      this.listCount = 0,
      this.totalCount = 0,
      this.isApiCalling = true,
      this.enablePullDown = false,
      this.enablePullUp = false});

  late Widget listItems;

  int listCount, totalCount;
  String? noDataMsg, noDataDesc, refreshBtn, imagePath;
  bool enablePullDown;
  bool enablePullUp;
  bool isApiCalling;
  VoidCallback? onPullToRefress;
  VoidCallback? onLoadMore;
  VoidCallback? onRefress;
  Color? textColor;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  GlobalKey? refresherKey;

  void hideProgress() {
    refreshController.refreshToIdle();
    refreshController.loadComplete();
  }

  void setApiCalling(bool isApiCall) {
    if (!isApiCall) {
      hideProgress();
    }
    new Future.delayed(
        const Duration(microseconds: 100),
        () => setState(() {
              isApiCalling = isApiCall;
            }));
  }

  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        key: refresherKey,
        header: const ClassicHeader(),
        footer: const ClassicFooter(),
        enablePullDown: enablePullDown,
        enablePullUp: enablePullUp && listCount > 0 && listCount < totalCount,
        controller: refreshController,
        onRefresh: onPullToRefress,
        onLoading: onLoadMore,
        child: isApiCalling && (listCount == 0)
            ? Container()
            : (listCount > 0
                ? listItems
                : noDataWidget(context,
                    noDataMsg: noDataMsg,
                    noDataDesc: noDataDesc,
                    imagePath: imagePath,
                    refreshBtn: refreshBtn,
                    textColor: textColor != null ? textColor : complimentry80,
                    onRefress: onRefress)));
  }

  noDataWidget(
    context, {
    String? noDataMsg,
    String? noDataDesc,
    String? imagePath,
    String? refreshBtn,
    Color? textColor,
    VoidCallback? onRefress,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (imagePath != null)
          Image.asset(
            imagePath,
            fit: BoxFit.fill,
            width: 120.dp,
            height: 120.dp,
          ),
        if (imagePath != null)
          SizedBox(
            height: 16.dp,
          ),
        if (noDataMsg != null)
          Text(noDataMsg,
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontWeight: FontWeight.bold, color: textColor),
              textAlign: TextAlign.center),
        if (noDataMsg != null)
          SizedBox(
            height: 16.dp,
          ),
        if (noDataDesc != null)
          Text(noDataDesc,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.normal, color: textColor),
              textAlign: TextAlign.center),
        if (noDataDesc != null)
          SizedBox(
            height: 16.dp,
          ),
        if (refreshBtn != null)
          TextButton(
            onPressed: () {
              if (onRefress != null) {
                onRefress();
              }
            },
            child: Text(refreshBtn),
          )
      ],
    );
  }
}
