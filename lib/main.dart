import 'package:flutter/material.dart';
import 'package:flutter_module/OnePage.dart';
import 'package:flutter_module/TwoPage.dart';
import 'package:flutter_module/pagers/main/MainPager.dart';
import 'package:flutter_module/pagers/me/MePager.dart';

import 'data/apis/Apis.dart';
import 'http/DioManager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /**
     * init 网络请求
     */
    DioManager().setConfig(WanAndroidApi.wan_android_base_api);

    final RouteObserver<PageRoute> routeObserver = RouteObserver();

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyStatefulWidget(),
      routes: {
        'one_page': (BuildContext context) => OnePage(),
        'two_pager': (BuildContext context) => TwoPage(),
      },
      navigatorObservers: [routeObserver],
    );
  }
}

class MyStatefulWidget extends StatefulWidget  {
  static const List<String> titles = ["主页", "我的"];

  @override
  MyStatefulWidgetState createState() {
    return MyStatefulWidgetState();
  }
}

class MyStatefulWidgetState extends State<MyStatefulWidget> with RouteAware {
  var _selectedIndex = 0;

  final pageController = PageController();

  final List<Widget> children = <Widget>[MainPager(), MePager()];


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(MyStatefulWidget.titles[_selectedIndex]),
      // ),
      body: PageView(
        children: children,
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "person")
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
