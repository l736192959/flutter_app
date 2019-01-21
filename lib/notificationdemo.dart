import 'package:flutter/material.dart';

class MyNotification extends Notification {
  final String msg;
  MyNotification(this.msg);

  @override
  void dispatch(BuildContext target) {
    super.dispatch(target);
    var renderObj = target.findRenderObject();
    renderObj.visitChildren((RenderObject object){

    });
  }
}
