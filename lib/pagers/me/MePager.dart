import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'PageInfo.dart';

///
///  我的页面
///
class MePager extends StatefulWidget {
  @override
  MePagerState createState() {
    return MePagerState();
  }
}

class MePagerState extends State<MePager> with AutomaticKeepAliveClientMixin {
  List<PageInfo> _pageInfo = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageInfo.add(PageInfo("我的", Icons.refresh));
    _pageInfo.add(PageInfo("关于", Icons.refresh));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            padding: const EdgeInsets.all(0.0),
            itemCount: _pageInfo.length,
            itemBuilder: (BuildContext context, int index) {
              PageInfo pageInfo = _pageInfo[index];

              return ListTile(
                leading: Icon(pageInfo.iconData),
                title: Text(pageInfo.title),
                onTap: () {},
              );
            }));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
