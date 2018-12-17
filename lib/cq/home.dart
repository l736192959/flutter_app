import 'package:flutter/material.dart';
import 'package:flutter_app/cq/transtime.dart';
import 'package:flutter_app/cq/uercenter.dart';

class Home extends StatefulWidget {
  static const String routeName = '/home';

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  int _currentIndex = 0;
  String _title = "培训学时";
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

  Widget _getBody() {
    if (_currentIndex == 0) {
      return TransInfoPage();
    } else if (_currentIndex == 1) {
      return UserCenterPage();
    }
  }

  void _change(int value) {
    if (value != _currentIndex) {
      setState(() {
        _currentIndex = value;
//        _pageController.jumpToPage(value);
        _pageController.animateToPage(value,
            duration: Duration(milliseconds: 1000), curve: Curves.easeIn);
        _title = _currentIndex == 0 ? "培训学时" : _currentIndex == 1 ? "个人中心" : "";
      });
    }
  }

  void _pageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: PageView.builder(
        itemCount: 3,
        onPageChanged: _pageChanged,
        controller: _pageController,
        itemBuilder: (_, index) {
           switch(index){
             case 0:
               return TransInfoPage();
             case 1:
               return UserCenterPage();
             default:
               throw Exception("error");
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Color(0xFFFABE00),
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(_currentIndex == 0
                  ? "asset/icon/ic_tran_info_select.png"
                  : "asset/icon/ic_tran_info_unselect.png")),
              title: Text(
                "培训学时",
                style: TextStyle(),
              )),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(_currentIndex == 1
                  ? "asset/icon/ic_user_center_select.png"
                  : "asset/icon/ic_user_center_unselect.png")),
              title: Text("个人中心")),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(_currentIndex == 2
                  ? "asset/icon/ic_user_center_select.png"
                  : "asset/icon/ic_user_center_unselect.png")),
              title: Text(
                "个人中心",
                style: TextStyle(fontSize: 10.0),
              )),
        ],
        onTap: _change,
      ),
    );
  }
}
