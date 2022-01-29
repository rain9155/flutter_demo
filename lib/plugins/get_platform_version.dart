import 'package:flutter/material.dart';
import 'package:flutter_demo/plugins/pigeon.dart';

///使用pigeon生成获取平台版本的接口类：
///
///flutter pub run pigeon \
///   --input pigeons/message.dart \
///   --dart_out lib/plugins/pigeon.dart \
///   --objc_header_out ios/Runner/pigeon.h \
///   --objc_source_out ios/Runner/pigeon.m \
///   --java_out ./android/app/src/main/java/com/example/flutter_demo/Pigeon.java \
///   --java_package "com.example.flutter_demo"
///
/// see also:
///   * https://pub.dev/packages/pigeon
class GetPlatformVersionPage extends StatefulWidget {

  static const NAME = "get_platform_version_page";

  @override
  State createState() => _GetPlatformVersionPageState();

}

class _GetPlatformVersionPageState extends State<GetPlatformVersionPage> {

  String _platformVersion = "Unknown platform version";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('查看系统版本'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_platformVersion),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              child: Text('Get platform version'),
              onPressed: _getPlatformVersion,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getPlatformVersion() async {
    PlatformVersionApi platformVersionApi = new PlatformVersionApi();
    String platformVersion = await platformVersionApi.getPlatformVersion();
    setState(() {
      _platformVersion = platformVersion;
    });
  }
}
