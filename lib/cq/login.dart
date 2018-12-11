import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginSate();
}

class _LoginSate extends State<Login> with TickerProviderStateMixin {
  AnimationController controller;
  CurvedAnimation curve;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    curve = new CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }

  Widget _buildBody() {
    return Container(
      margin: EdgeInsets.only(top: 82),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 80,
              height: 80,
              child: Image.asset("asset/images/ic_launcher.png"),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                "山城交通",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 20),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Text(
                "驾驶培训学时查询",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getRotationTransition() {
    return GestureDetector(
      child: RotationTransition(
        turns: curve,
        child: FlutterLogo(
          size: 200,
        ),
      ),
      onDoubleTap: () {
        if (controller.isCompleted) {
          controller.reverse();
        } else {
          controller.forward();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.white),
        home: Scaffold(
          body: _buildBody(),
        ));
  }
}

class ClearEditText extends StatefulWidget {
  final IconData icon;
  final String placeHolder;
  final double height;
  final double topMargin;
  final double drawLeftPadding;

  ClearEditText(
      {Key key,
      this.icon,
      this.placeHolder,
      this.height,
      this.topMargin,
      this.drawLeftPadding})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ClearEditTextState();
}

class _ClearEditTextState extends State<ClearEditText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: widget.topMargin),
      child: SizedBox(
        height: 40.0,
        child: Card(
          child: Row(
            children: <Widget>[
              Icon(widget.icon),
              Container(
                margin: EdgeInsets.only(left: widget.drawLeftPadding),
                child: TextField(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
