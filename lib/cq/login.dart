import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/cq/home.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginSate();
}

class _LoginSate extends State<Login> with TickerProviderStateMixin {
  final double _iconWidth = 20;
  final double _iconHeight = 20;
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _idCardController = TextEditingController();
  TextEditingController _verifyController = TextEditingController();
  AnimationController controller;
  CurvedAnimation curve;
  String _phone;
  String _idCard;
  String _verifyCode;
  String _transType;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    curve = new CurvedAnimation(parent: controller, curve: Curves.easeIn);
    _phoneController.addListener(_phoneControllerListener);
    _idCardController.addListener(_idCardControllerListener);
    _verifyController.addListener(_verifyControllerListener);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _idCardController.dispose();
    _verifyController.dispose();
    super.dispose();
  }

  void _phoneControllerListener() {
    this._phone = _phoneController.text;
    print("phone $_phone");
    setState(() {
      print("____phone $_phone  enable:${_loginEnable()}");
    });
  }

  void _idCardControllerListener() {
    this._idCard = _idCardController.text;
    setState(() {});
  }

  void _verifyControllerListener() {
    this._verifyCode = _verifyController.text;
    setState(() {});
  }

  bool _loginEnable() {
    return (_verifyCode != null && _verifyCode.isNotEmpty) &&
        (_phone != null && _phone.isNotEmpty) &&
        (_idCard != null && _idCard.isNotEmpty) &&
        (_transType != null && _transType.isNotEmpty);
  }

  Widget _buildDownSection() {
    final allTypes = ["A1", "A2", "A3", "A4", "C1", "C2", "C3", "C4"];
    return Container(
      height: 40,
      margin: EdgeInsets.only(right: 40, left: 40, top: 10),
      child: Card(
        margin: EdgeInsets.all(0),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 8, left: 10),
              child: Image.asset(
                "asset/icon/ic_up_down.png",
                width: _iconWidth,
                height: _iconHeight,
              ),
            ),
            Expanded(
              child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                iconSize: 0,
                hint: Text(
                  "请选择培训车型",
                  style: TextStyle(fontSize: 17.0, color: Color(0xFFC2C2C2)),
                ),
                value: _transType,
                onChanged: _transTypeSelect,
                items: allTypes.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
            ),
          ],
        ),
      ),
    );
  }

  void _transTypeSelect(String value) {
    _transType = value;
//    setState(() {});
  }

  Widget _buildTextField(
      {String photo,
      TextInputType keyboardType,
      double marginTop,
      String placeHolder,
      ValueChanged<String> onChanged,
      double marginRight: 40,
      TextEditingController controller}) {
    return Card(
        margin:
            EdgeInsets.only(top: marginTop ?? 10, right: marginRight, left: 40),
        child: SizedBox(
          height: 40,
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 4),
            child: CupertinoTextField(
              controller: controller,
              onChanged: onChanged,
              decoration: BoxDecoration(border: null),
              padding: EdgeInsets.only(right: 8, left: 8),
              keyboardType: keyboardType,
              prefix: Image.asset(
                photo ?? "asset/images/image.jpg",
//                width: _iconWidth,
//                height: _iconHeight,
              ),
              clearButtonMode: OverlayVisibilityMode.editing,
              placeholder: placeHolder,
            ),
          ),
        ));
  }

  Widget _buildVerifySection({TextEditingController controller}) {
    return Container(
      margin: EdgeInsets.only(right: 40, left: 40, top: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Card(
                margin: EdgeInsets.only(right: 5.0, left: 0.0),
                child: SizedBox(
                  height: 40,
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 4),
                    child: CupertinoTextField(
                      controller: controller,
                      decoration: BoxDecoration(border: null),
                      padding: EdgeInsets.only(right: 8, left: 8),
                      keyboardType: TextInputType.number,
                      prefix: Image.asset(
                        "asset/icon/ic_verify.png",
//                        width: _iconWidth,
//                        height: _iconHeight,
                      ),
                      clearButtonMode: OverlayVisibilityMode.editing,
                      placeholder: "请输入验证码",
                    ),
                  ),
                )),
          ),
          Expanded(
              child: Container(
                  height: 40,
                  child: Image.asset(
                    "asset/images/image.jpg",
                    fit: BoxFit.fill,
                  )))
        ],
      ),
    );
  }

  Widget _buildBottomButton(
      {String text,
      VoidCallback onPress,
      double marginTop,
      double marginRight: 40}) {
    return Container(
      height: 60,
      child: Card(
        margin:
            EdgeInsets.only(top: marginTop ?? 10, right: marginRight, left: 40),
        child: RawMaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0))),
            fillColor: Color(0XFF3E3A39),
            highlightColor: Colors.black,
            onPressed: _loginEnable() ? onPress : null,
            textStyle: TextStyle(
                fontSize: 18,
                color: Colors.white,
                wordSpacing: 2.0,
                letterSpacing: 4),
            child: Text(text)),
      ),
    );
  }

  void _login() {
    print("phone:${_phone} idCardCode:${_idCard} verifyCode:${_verifyCode}");
    Navigator.of(context)
//      ..pop()
      ..push(MaterialPageRoute(builder: (_) {
        return Home();
      }));
    /*Navigator.of(context)
    ..pop()
      ..push(PageRouteBuilder(
          pageBuilder: (context, _, __) {
            return Home();
          },
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) {
            return FadeTransition(
              opacity: animation,
              child: RotationTransition(
                turns: Tween(begin: 0.5, end: 1.0).animate(animation),
                child: child,
              ),
            );
          },
          transitionDuration: Duration(seconds: 5)));*/
  }

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
              photo: "asset/icon/ic_phone.png",
              keyboardType: TextInputType.number,
              placeHolder: "请输入手机号",
              marginTop: 20,
              controller: _phoneController),
          _buildTextField(
              photo: "asset/icon/ic_card.png",
              keyboardType: TextInputType.number,
              placeHolder: "请输入身份证号",
              controller: _idCardController),
          _buildDownSection(),
          _buildVerifySection(controller: _verifyController),
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
