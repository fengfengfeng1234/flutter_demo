import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/data/info/MainItemInfo.dart';
import 'package:flutter_module/pagers/article/ArticleDetailsPager.dart';

class MainListItemWidget extends StatelessWidget {
  final MainItemInfo data;

  MainListItemWidget(this.data);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return ArticleDetailsPager(title: data.title, url: data.link);
          }));
        },
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 8, color: Color(0xffcccccc)))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              listRow1(),
              SizedBox(height: 6),
              listRow2(),
              SizedBox(height: 6),
              listRow3()
            ],
          ),
        ));
  }

  //列表第一行
  Widget listRow1() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(data.shareUser, style: TextStyle(color: Colors.grey)),
        ),
        Text(data.niceShareDate, style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  //列表第一行
  Widget listRow2() {
    return Text(data.title, style: TextStyle(fontSize: 16));
  }

  //列表第三行
  Widget listRow3() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(data.superChapterName + "/" + data.chapterName,
              style: TextStyle(color: Colors.grey)),
        ),
        Icon(
          Icons.favorite,
          color: Color(0xffBFBFBF),
          size: 18,
        ),
      ],
    );
  }
}
