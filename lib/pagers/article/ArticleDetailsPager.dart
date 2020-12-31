import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/utils/NavigatorUtil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// 文章详情
class ArticleDetailsPager extends StatefulWidget {
  final String title;


  final String url;

  const ArticleDetailsPager({Key key, this.title, this.url})
      : super(key: key);

  @override
  ArticleDetailsState createState() {
    return ArticleDetailsState();
  }
}

class ArticleDetailsState extends State<ArticleDetailsPager> {

  void _onPopSelect(String value) {
    switch (value) {
      case "browser":
        NavigatorUtil.launchInBrowser(widget.url, title: widget.title);
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text(
          widget.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
              padding: const EdgeInsets.all(0.0),
              onSelected: _onPopSelect,
              itemBuilder: (BuildContext context) =>
              <PopupMenuItem<String>>[
                PopupMenuItem<String>(
                    value: "browser",
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0.0),
                      dense: false,
                      title: new Container(
                        alignment: Alignment.center,
                        child: new Row(
                          children: <Widget>[
                            Icon(
                              Icons.language,
                              color: Color(0xFF666666),
                              size: 22.0,
                            ),
                            Text("浏览器", style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF666666)
                            ),)
                          ],
                        ),
                      ),
                    ))
              ])
        ],

      ),
      body: new WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}


