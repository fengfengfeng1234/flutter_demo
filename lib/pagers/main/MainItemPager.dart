import 'package:flutter/cupertino.dart';
import 'package:flutter_module/data/info/MainItemInfo.dart';

import 'MainListItemWidget.dart';

class MainItemPager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainItemPagerState();
  }
}

class MainItemPagerState extends State<MainItemPager> {
  final List<MainItemInfo> Lists = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: Lists.length,
          shrinkWrap: true,
          itemBuilder: (ctx, index) {
            return MainListItemWidget(Lists[index]);
          }),
    );
  }

}
