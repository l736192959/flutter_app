import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/canvaspage.dart';
import 'package:flutter_app/resource.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TransInfoPageState();
  }
}

class _TransInfoPageState extends State<TransInfoPage>
    with TickerProviderStateMixin {
  final _titles = ["第一部分", "第二部分", "第三部分", "第四部分"];
  TabController _tabController;
  var _currentIndex = 0;
  Animation<Color> _valueColor;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _titles.length, vsync: this)
      ..addListener(_tabControllerListener);
    AnimationController _animationController = AnimationController(vsync: this);
    _valueColor =
        ColorTween(begin: blue_69, end: blue_69).animate(_animationController);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  void _tabControllerListener() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  List<Widget> _getTabBars() {
    var tabBars = <Widget>[];
    for (int i = 0; i < _titles.length; i++) {
      final point = Container(
        margin: EdgeInsets.only(right: 4),
        child: Offstage(
          offstage: i != 0,
          child: Icon(
            Icons.brightness_1,
            color: green_ff,
            size: ScreenUtil().setWidth(7),
          ),
        ),
      );
      final tabBar = Text(
        _titles[i],
        style: _currentIndex == i
            ? TextStyle(color: yellow_fa, fontSize: 16)
            : TextStyle(fontSize: 16),
      );

      final column = Padding(
          padding: EdgeInsets.only(bottom: 9, top: 9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [point, tabBar],
          ));
      tabBars.add(column);
    }
    return tabBars;
  }

  @override
  Widget build(BuildContext context) {
    const demoPlugin = const MethodChannel('demo.plugin');
    return Scaffold(
      appBar: AppBar(
        title: Text("培訓学时"),
        bottom: TabBar(
          indicatorPadding: EdgeInsets.only(right: 10, left: 10),
          indicatorWeight: 2,
          indicatorSize: TabBarIndicatorSize.label,
          labelPadding: EdgeInsets.zero,
          indicatorColor: Colors.yellow[800],
          controller: _tabController,
          tabs: _getTabBars(),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 22),
            alignment: Alignment.topCenter,
            child: SinglePercentChatWidget(
              width: 160,
              height: 160,
              percentage: 38.6,
              percentageColor: Colors.yellow,
              title: Text(
                "38.6%",
                style: TextStyle(
                    fontSize: 26,
                    color: yellow_fa,
                    fontWeight: FontWeight.bold),
              ),
              subTitle: Text(
                "本月合格率",
                style: TextStyle(color: gray_b2, fontSize: 12),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 4),
            alignment: Alignment.topCenter,
            child: RichText(
                text: TextSpan(text: "本月有", style: GrayB2S14Style, children: [
              TextSpan(
                  text: "80.6%", style: TextStyle(color: red_ff, fontSize: 14)),
              TextSpan(text: "的学员", style: GrayB2S14Style),
            ])),
          ),
          Center(
            child: Text(
              "无法一次性通过本科目考试",
              style: GrayB2S14Style,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 63, right: 63),
            child: Table(
              columnWidths: <int, FlexColumnWidth>{
                0: FlexColumnWidth(0.3),
                1: FlexColumnWidth(0.6),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder.all(color: Colors.black),
              children: [
                TableRow(children: [
                  Text(
                    "学习进度",
                    style: GrayB2S14Style,
                  ),
                  LinearProgressIndicator(
                    value: 0.7,
                    valueColor: _valueColor,
                    backgroundColor: white_ee,
                  ),
                ])
              ],
            ),
          ),
          Row(
            children: <Widget>[],
          ),
        ],
      ),
    );
  }
}
