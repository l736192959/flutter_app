import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TransInfoPageState();
  }
}

class _TransInfoPageState extends State<TransInfoPage>
    with TickerProviderStateMixin {
  final _titles = ["科目一", "科目二", "科目三", "科目四"];
  TabController _tabController;
  var _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _titles.length, vsync: this)
      ..addListener(_tabControllerListener);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _tabControllerListener() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  List<Widget> _getTabBars() {
    var tabBars = <Widget>[];
    for (int i = 0; i < _titles.length; i++) {
      final tabBar = Text(
        _titles[i],
        style: _currentIndex == i ? TextStyle(color: Colors.yellow[800],fontSize: 18) : null,
      );
      tabBars.add(tabBar);
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
          indicatorColor: Colors.yellow[800],
          controller: _tabController,
          tabs: _getTabBars(),
        ),
      ),
      body: Container(
        child: Center(
          child: RaisedButton(onPressed: () {
            demoPlugin.invokeMethod("interaction");
          }),
        ),
      ),
    );
  }
}
