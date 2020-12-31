import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/data/apis/Apis.dart';
import 'package:flutter_module/data/info/ProjectList.dart';
import 'package:flutter_module/http/DioManager.dart';

import 'NoticeVecAnimationWidget.dart';

class HeaderItem extends StatefulWidget {
  final EdgeInsetsGeometry margin;
  final GestureTapCallback onTap;
  final IconData leftIcon;
  final Color titleColor;
  final String title;
  static Widget hGap10 = new SizedBox(width: 10);

  static List<String> _HomeSearchValues = ["1111111111111111"];

  const HeaderItem(
      {Key key,
      this.margin,
      this.onTap,
      this.leftIcon,
      this.titleColor,
      this.title})
      : super(key: key);

  @override
  HeaderItemState createState() {
    return HeaderItemState();
  }
}


class HeaderItemState extends State<HeaderItem> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 56.0,
      margin: widget.margin ?? EdgeInsets.only(top: 0.0),
      child: new ListTile(
          onTap: widget.onTap,
          title: new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Icon(
                widget.leftIcon ?? Icons.whatshot,
                color: widget.titleColor ?? Colors.blueAccent,
              ),
              HeaderItem.hGap10,
              new Expanded(
                  child: new Text(
                "推荐项目",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: widget.titleColor ?? Colors.blueAccent,
                    fontSize: 18),
              )),
              Expanded(
                child: NoticeVecAnimationWidget(
                  messages: HeaderItem._HomeSearchValues,
                ),
              )
            ],
          ),
          trailing: new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "更多",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
              )
            ],
          )),
      decoration: new BoxDecoration(
          border: new Border(
              bottom: new BorderSide(width: 0.33, color: Color(0xffe5e5e5)))),
    );
  }

  @override
  void initState() {
    super.initState();
    requestHttp();
  }

  requestHttp() {
    DioManager().requestPager<ProjectList>(
        Method.GET, WanAndroidApi.PROJECT_LIST_API + "/0/json",
        success: (result) {
      if (result != null) {
        HeaderItem._HomeSearchValues.clear();
        result.datas.forEach((element) {
          HeaderItem._HomeSearchValues.add(element.title);
        });
        setState(() {});
      }
    }, error: (error) {});
  }
}
