package com.example.flutter_demo;

import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    super.configureFlutterEngine(flutterEngine);
    GeneratedPluginRegistrant.registerWith(flutterEngine);
    registerBatteryPlugin(flutterEngine);
    registerVersionPlugin(flutterEngine);
  }

  private void registerBatteryPlugin(FlutterEngine flutterEngine) {
    MethodChannel _batteryMethodChannel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), "com.example.flutter_demo/battery");
    _batteryMethodChannel.setMethodCallHandler(new MethodChannel.MethodCallHandler() {
      @Override
      public void onMethodCall(@NonNull MethodCall methodCall, @NonNull MethodChannel.Result result) {
        if (methodCall.method.equals("getBatteryLevel")) {
          int batteryLevel = getBatteryLevel();
          if (batteryLevel != -1) {
            result.success(batteryLevel);
          } else {
            result.error("UNAVAILABLE", "Battery level not available.", null);
          }
        } else {
          result.notImplemented();
        }
      }
    });
  }

  private void registerVersionPlugin(FlutterEngine flutterEngine) {
    Pigeon.PlatformVersionApi.setup(flutterEngine.getDartExecutor().getBinaryMessenger(), new Pigeon.PlatformVersionApi() {
      @Override
      public String getPlatformVersion() {
        return getVersion();
      }
    });
  }

  private int getBatteryLevel() {
    int batteryLevel;
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
      BatteryManager batteryManager = (BatteryManager) getSystemService(Context.BATTERY_SERVICE);
      batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
    }else {
      Intent intent = (new ContextWrapper(getApplicationContext())).registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
      batteryLevel = intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
    }
    return batteryLevel;
  }

  private String getVersion() {
    return "Android " + android.os.Build.VERSION.RELEASE;
  }
}
