import 'package:pigeon/pigeon.dart';

@HostApi()
abstract class PlatformVersionApi {
  String getPlatformVersion();
}