import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 获取手机电量插件
/// see also：
///   * https://flutter.dev/docs/development/packages-and-plugins/developing-packages
///   * https://flutter.dev/docs/development/platform-integration/platform-channels
///   * https://flutter.dev/docs/development/packages-and-plugins/plugin-api-migration
class GetBatteryLevelPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _GetBatteryLevelPageState();

}

class _GetBatteryLevelPageState extends State<GetBatteryLevelPage> {

  static const _batteryMethodChannel = MethodChannel("com.example.flutter_demo/battery");

  String _batteryLevel = "Unknown battery lever";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('查看手机电量'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_batteryLevel),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              child: Text('Get battery level'),
              onPressed: _getBatteryLevel,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await _batteryMethodChannel.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result %';
    } on Exception catch (e) {
      batteryLevel = "Failed to get battery level: '$e'";
    }
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

}