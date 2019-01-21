import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class CanvasPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CanvasPageState();
}

class _CanvasPageState extends State<CanvasPage>
    with SingleTickerProviderStateMixin {
  double percentage = 25;
  AnimationController _controller;
  Animation<double> tween;
  List<Offset> _points = <Offset>[];

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 10), vsync: this);
    var curve = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    tween = Tween(begin: 25.0, end: 100.0).animate(curve);
    tween.addListener(() {
      setState(() {
        percentage = tween.value;
      });
    });
  }

  void _onTap() {
    setState(() {
      if (percentage <= 90) {
        percentage += 1;
      } else {
        percentage = 100;
      }
    });
  }

  void _onLongPress() {
    _controller.forward();
  }

  void _onTapDetails(DragUpdateDetails details) {
    setState(() {
      RenderBox referenceBox = context.findRenderObject();
      Offset localPosition =
      referenceBox.globalToLocal(details.globalPosition);
      _points.add(localPosition);
    });
  }

  Widget _buildSignerPaint() {
    return Container(
      width: 380,
      height: 500,
      decoration: BoxDecoration(color: Colors.black),
      child: GestureDetector(
        onPanUpdate: _onTapDetails,
        onPanEnd: (DragEndDetails details) => _points.add(null),//抬起来
        child: CustomPaint(
          painter: _SignerPainter(points: _points),
        ),
      ),
    );
  }

  Widget _buildChatWidget() {
    return InkWell(
        onTap: _onTap,
        onLongPress: _onLongPress,
        child: SinglePercentChatWidget(
          percentage: percentage,
          percentageColor: Colors.green[300],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: _buildChatWidget(),
    ));
  }
}

class SinglePercentChatWidget extends StatelessWidget {
  final double percentage;
  final Color percentageColor;
  final Widget title;
  final Widget subTitle;
  final double strokeWidth;
  final double width;
  final double height;

  SinglePercentChatWidget(
      {Key key,
      this.width = 340,
      this.height = 340,
      @required this.percentage,
      this.title,
      this.subTitle,
      this.percentageColor,
      this.strokeWidth})
      : super(key: key);

  Widget _buildCenterColumn() {
    if (this.title != null && this.subTitle != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[title, subTitle],
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
    );
  }

  Widget _buildCustomPaint() {
    return CustomPaint(
//              painter:_FivePainter(),
      painter: _CircularPainter(
          percentage: percentage,
          strokeWidth: strokeWidth,
          percentageColor: percentageColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.circle,
      color: Colors.white,
      elevation: 5.0,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SizedBox(
            width: width,
            height: height,
            child: _buildCustomPaint(),
          ),
          _buildCenterColumn()
        ],
      ),
    );
  }
}

class _SignerPainter extends CustomPainter {
  List<Offset> points;

  _SignerPainter({@required this.points}) : super();

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint() //设置笔的属性
      ..color = Colors.blue[200]
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..strokeWidth = 5
      ..strokeJoin = StrokeJoin.bevel;

    for (int i = 0; i < points.length; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _FivePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double eWidth = size.width / 15;
    double eHeight = size.height / 15;

    //画棋盘背景
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill //填充
      ..color = Color(0x77cdb175); //背景为纸黄色
    canvas.drawRect(Offset.zero & size, paint);

    //画棋盘网格
    paint
      ..style = PaintingStyle.stroke //线
      ..color = Colors.black87
      ..strokeWidth = 1.0;

    for (int i = 0; i <= 15; ++i) {
      double dy = eHeight * i;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }

    for (int i = 0; i <= 15; ++i) {
      double dx = eWidth * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }

    //画一个黑子
    paint
      ..style = PaintingStyle.fill
      ..color = Colors.black;
    canvas.drawCircle(
      Offset(size.width / 2 - eWidth / 2, size.height / 2 - eHeight / 2),
      min(eWidth / 2, eHeight / 2) - 2,
      paint,
    );

    //画一个白子
    paint.color = Colors.white;
    canvas.drawCircle(
      Offset(size.width / 2 + eWidth / 2, size.height / 2 - eHeight / 2),
      min(eWidth / 2, eHeight / 2) - 2,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _CircularPainter extends CustomPainter {
  final double percentage;
  final double strokeWidth;
  final Color percentageColor;

  _CircularPainter(
      {this.percentage = 0,
      this.strokeWidth = 1,
      this.percentageColor = Colors.red})
      : super();

  static final _angel = 2 * pi;
  final _otherColor = Colors.grey[100];
  final _startAngel = -(_angel * 0.25);

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.width / 2 / 3;
    final sweepAngel = (_angel * percentage) / 100;
    final Paint percentPaint = Paint()
      ..color = percentageColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Paint otherPaint = Paint()
      ..color = _otherColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    var rect = Rect.fromLTRB(strokeWidth / 2, strokeWidth / 2,
        size.width - strokeWidth / 2, size.height - strokeWidth / 2);
    canvas.drawArc(rect, _startAngel, sweepAngel, false, percentPaint);
    canvas.drawArc(rect, _startAngel + (_angel * percentage) / 100,
        (_angel * (100 - percentage)) / 100, false, otherPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return percentage <= 100;
  }
}
