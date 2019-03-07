package com.lemon.flutterapp;

import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    private static final String MESSAGE_CHANNEL = "com.lemon.flutter/message";
    private static final String CHARGING_CHANNEL = "com.lemon.flutter/charging";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        //Flutter端 调用 Native端
        new MethodChannel(getFlutterView(), MESSAGE_CHANNEL).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                        if (methodCall.method.equals("getMessage")) {
                            result.success("hi,i'm from native!");
                            return;
                        }
                        if (methodCall.method.equals("getMessage1")) {
                            String name = methodCall.argument("name");
                            Integer age = methodCall.argument("age");
                            result.success("name:" + name + ",age:" + age);
                            return;
                        }
                        result.notImplemented();
                    }
                }
        );
        //Native端调用 Flutter 端
        new EventChannel(getFlutterView(), CHARGING_CHANNEL).setStreamHandler(
                new EventChannel.StreamHandler() {
                    @Override
                    public void onListen(Object o, EventChannel.EventSink eventSink) {
                        eventSink.success("hi,Flutter!give you");
                    }

                    @Override
                    public void onCancel(Object o) {

                    }
                });
    }
}
