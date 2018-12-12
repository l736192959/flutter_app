import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginSate();
}

class _LoginSate extends State<Login> with TickerProviderStateMixin {
  AnimationController controller;
  CurvedAnimation curve;
  String _phone;
  String _idCard;
  String _verifyCode;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    curve = new CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }

  Widget _buildTextField(
      {String photo,
      TextInputType keyboardType,
      double marginTop,
      String placeHolder,
      ValueChanged<String> onChanged}) {
    return Card(
        margin: EdgeInsets.only(top: marginTop ?? 10, right: 40, left: 40),
        child: SizedBox(
          height: 40,
          child: Container(
            padding: EdgeInsets.only(left: 4, right: 4),
            child: CupertinoTextField(
              onChanged: onChanged,
              decoration: BoxDecoration(border: null),
              padding: EdgeInsets.only(right: 8, left: 8),
              keyboardType: keyboardType,
              prefix: Image.asset(
                photo ?? "asset/images/image.jpg",
                width: 20,
                height: 26,
              ),
              clearButtonMode: OverlayVisibilityMode.editing,
              placeholder: placeHolder,
            ),
          ),
        ));
  }

  Widget _buildBottomButton(
      {String text, VoidCallback onPress, double marginTop}) {
    return SizedBox(
      width: 1000,
      height: 60,
      child: Card(
        margin: EdgeInsets.only(top: marginTop ?? 10, right: 40, left: 40),
        child: RawMaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0))),
            fillColor: Colors.black,
            highlightColor: Colors.black,
            onPressed: onPress,
            textStyle: TextStyle(
                fontSize: 18,
                color: Colors.white,
                wordSpacing: 2.0,
                letterSpacing: 4),
            child: Text(text)),
      ),
    );
  }

  void _phoneChanged(String value) {
    this._phone = value;
  }

  void _idCardCodeChanged(String value) {
    this._idCard = value;
  }

  void _verifyCodeChanged(String value) {
    this._verifyCode = value;
  }

  void _login() {}

  Widget _buildBody() {
    return Container(
      margin: EdgeInsets.only(top: 82),
      child: ListView(
        children: <Widget>[
          SizedBox(
            width: 80,
            height: 80,
            child: Image.asset("asset/images/ic_launcher.png"),
          ),
          Center(
              child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "山城交通",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 20),
                  ))),
          Center(
              child: Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Text(
                    "驾驶培训学时查询",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 18),
                  ))),
          _buildTextField(
              photo: "asset/images/image.jpg",
              keyboardType: TextInputType.number,
              marginTop: 20,
              onChanged: _phoneChanged),
          _buildTextField(
              photo: "asset/images/image.jpg",
              keyboardType: TextInputType.number,
              placeHolder: "请输入身份证号",
              onChanged: _idCardCodeChanged),
          _buildTextField(
            photo: "asset/images/image.jpg",
            keyboardType: TextInputType.number,
          ),
          _buildTextField(
              photo: "asset/images/image.jpg",
              keyboardType: TextInputType.number,
              placeHolder: "请输入验证码",
              onChanged: _verifyCodeChanged),
          _buildBottomButton(text: "登录", onPress: _login, marginTop: 20)
        ],
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
    return Scaffold(
      body: _buildBody(),
    );
  }
}
