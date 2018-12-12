import 'package:flutter/material.dart';

class Third extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Third",
      theme: ThemeData(primaryColor: Colors.black),
      home: ThirdStateFul(),
    );
  }
}

class ThirdStateFul extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ThirdStateFulState();
  }
}

class _ThirdStateFulState extends State<ThirdStateFul> {
  var _count = 0;

  void iconPress() {
    setState(() {
      _count++;
    });
  }

  bool _active = false;

  void _handleChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildBody() {
      return Container(
        padding: EdgeInsets.all(18.0),
        child: Row(
          children: [
            IconButton(
                icon: Icon(
                  Icons.star,
                  color: Colors.purple,
                ),
                onPressed: iconPress),
            Text("$_count"),
          ],
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("ThirdStateFul"),
        ),
        body: TapBox(
          onChanged: _handleChanged,
          active: _active,
        ));
  }
}

class TapBox extends StatelessWidget {
  TapBox({Key key, this.active = false, @required this.onChanged})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  void _handleTap() {
    onChanged(!active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(active ? 'Active' : 'Inactive',
              style: new TextStyle(fontSize: 32.0, color: Colors.white)),
        ),
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}
