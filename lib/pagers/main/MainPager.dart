import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_module/data/apis/Apis.dart';
import 'package:flutter_module/data/info/BannerInfo.dart';
import 'package:flutter_module/data/info/MainItemInfo.dart';
import 'package:flutter_module/http/DioManager.dart';
import 'package:flutter_module/itemWidget/HeaderItem.dart';

import 'BannerItemPager.dart';
import 'MainListItemWidget.dart';

class MainPager extends StatefulWidget {

  const MainPager({Key key}) : super(key: key);

  @override
  SellCarPagerState createState() {
    return SellCarPagerState();
  }
}

// MainBanner
class SellCarPagerState extends State<MainPager> with AutomaticKeepAliveClientMixin {
  int pager = 1;

  final List<MainItemInfo> Lists = [];

  final List<BannerInfo> bannerLists = [];

  EasyRefreshController _controller = EasyRefreshController();

  var bannerReq;

  @override
  Widget build(BuildContext context) {
    return  EasyRefresh.custom(
      header: BallPulseHeader(),
      controller: _controller,
      onRefresh: () async {
        requestHttp();
      },
      onLoad: () async {
        requestMainList(false);
      },
      slivers: <Widget>[
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              if (index == 0) {
                return MainBanner(
                  bannerLists: bannerLists,
                );
              } else if (index == 1) {
                return HeaderItem(
                  leftIcon: Icons.book,
                  onTap: (){

                  },
                );
              }
              return MainListItemWidget(Lists[index - 2]);
            }, childCount: Lists.length + 2))
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    requestHttp();
  }

  Future<void> requestBanner(bool refresh) {
    return Future.delayed(
        Duration(seconds: 0), () => {requestBannerHttp(refresh)});
  }

  Future<void> requestMainLists(bool refresh) {
    return Future.delayed(
        Duration(seconds: 0), () => {requestMainList(refresh)});
  }

  requestBannerHttp(bool refresh) {
    DioManager().requestList<BannerInfo>(Method.GET, WanAndroidApi.BANNER,
        success: (result) {
      if (result != null) {
        if (refresh) {
          bannerLists.clear();
        }
        bannerLists.addAll(result.data);
        setState(() {});
      }
    }, error: (error) {});
  }

  /// 封装 pager 组件
  requestMainList(bool refresh) {
    if (refresh) {
      pager = 1;
    } else {
      pager++;
    }
    DioManager().requestPager<MainItemInfo>(
        Method.GET, WanAndroidApi.MAIN_LIST + pager.toString() + "/json",
        success: (result) {
      _controller.finishRefresh(success: true);
      _controller.finishLoad(success: true);
      if (refresh) {
        Lists.clear();
      }
      Lists.addAll(result.datas);
      setState(() {});
    }, error: (error) {
      _controller.finishRefresh(success: true);
      _controller.finishLoad(success: true);
    });
  }

  ///
  ///   为什么在这个地方 用 setState 没有反应
  ///
  requestHttp() async {
    await Future.wait<void>([requestBanner(true), requestMainLists(true)])
        .then((List<void> response) => {

    })
        .catchError((error) {});
  }

  @override
  bool get wantKeepAlive => true;
}
