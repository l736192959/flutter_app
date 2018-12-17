import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransInfoPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    const demoPlugin = const MethodChannel('demo.plugin');
    return Container(
      child: Center(
        child: RaisedButton(onPressed: () {
          demoPlugin.invokeMethod("interaction");
        }),
      ),
    );
  }
}
