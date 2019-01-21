import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/cq/transinfo.dart';
import 'package:flutter_app/cq/uercenter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  static const String routeName = '/home';

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  DateTime _lastPressedAt; //上次点击时间
  int _currentIndex = 0;
  PageController _pageController;
  AnimationController _animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _animationController = AnimationController(vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
  }

  void _change(int value) {
    if (value != _currentIndex) {
      setState(() {
        _currentIndex = value;
        _pageController.jumpToPage(value);
       /* _pageController.animateToPage(value,
            duration: Duration(milliseconds: 500), curve: Curves.ease);*/
      });
    }
  }

  void _pageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<bool> _willPop() async {
    if (_lastPressedAt == null ||
        DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
      //两次点击间隔超过1秒则重新计时
      _lastPressedAt = DateTime.now();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 375, height: 667)..init(context);
    return WillPopScope(
      child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.white),
        home: Scaffold(
          body: PageView.builder(
            itemCount: 2,
            onPageChanged: _pageChanged,
            controller: _pageController,
            itemBuilder: (_, index) {
              switch (index) {
                case 0:
                  return TransInfoPage();
                case 1:
                  return UserCenterPage();
              }
            },
          ),
          bottomNavigationBar: CupertinoTabBar(
            activeColor: Colors.yellow[700],
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage(_currentIndex == 0
                      ? "asset/icon/ic_tran_info_select.png"
                      : "asset/icon/ic_tran_info_unselect.png")),
                  title: Text(
                    "培训学时",
                  )),
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage(_currentIndex == 1
                      ? "asset/icon/ic_user_center_select.png"
                      : "asset/icon/ic_user_center_unselect.png")),
                  title: Text("个人中心")),
            ],
            onTap: _change,
          ),
        ),
      ),
      onWillPop: _willPop,
    );
  }
}
