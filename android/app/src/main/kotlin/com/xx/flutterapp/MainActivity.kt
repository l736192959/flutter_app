package com.xx.flutterapp

import android.content.Intent
import android.os.Bundle
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // 自定义插件
        val CHANNEL = "demo.plugin"
        MethodChannel(flutterView, CHANNEL).setMethodCallHandler(
                object : MethodCallHandler {
                    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
                        if (call.method == "interaction") {
                            val intent = Intent(this@MainActivity, TestActivity::class.java)
                            this@MainActivity.startActivity(intent)
                            result.success("success")
                        } else {
                            result.notImplemented()
                        }
                    }
                })
        GeneratedPluginRegistrant.registerWith(this)
    }
}
