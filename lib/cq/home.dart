import 'package:flutter/material.dart';
import 'package:flutter_app/cq/transtime.dart';
import 'package:flutter_app/cq/uercenter.dart';

class Home extends StatefulWidget {
  static const String routeName = '/home';

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  String _title = "培训学时";

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
        _title = _currentIndex == 0 ? "培训学时" : _currentIndex == 1 ? "个人中心" : "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Container(
        child: _getBody(),
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
              title: Text("培训学时")),
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
