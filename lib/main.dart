import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_demo/plugins/get_battery_level.dart';
import 'package:flutter_demo/plugins/get_platform_version.dart';
import 'package:flutter_demo/network/dio.dart';
import 'package:flutter_demo/network/http_client.dart';
import 'package:flutter_demo/widgets/component/button.dart';
import 'package:flutter_demo/widgets/component/image.dart';
import 'package:flutter_demo/widgets/component/textfield.dart';
import 'package:flutter_demo/widgets/component/text.dart';
import 'package:flutter_demo/widgets/funcation/future.dart';
import 'package:flutter_demo/widgets/funcation/inherited.dart';
import 'package:flutter_demo/widgets/funcation/stream.dart';
import 'package:flutter_demo/widgets/layout/nest_scroll_view.dart';

void main(){
  //FlutterError的onError回调可以收集build时catch的同步异常
  FlutterError.onError = (FlutterErrorDetails errorDetails){
    //默认把异常信息打印到控制台
    FlutterError.dumpErrorToConsole(errorDetails);
    //可以把异常传递给zone的onError回调，统一在onError回调中处理异常
    Zone.current.handleUncaughtError(errorDetails.exception, errorDetails.stack);
  };

  //ErrorWidget的builder构建可以在build失败时在页面展示错误信息
  ErrorWidget.builder = (FlutterErrorDetails errorDetails){
    //...这里我们可以自定义错误展示界面
    return ErrorWidget(errorDetails.exception);
  };

  //运行一个沙盒环境(zone)
  runZonedGuarded(
    //zone
    (){
      runApp(MyApp());
    },
    //该onError回调可以收集zone中未catch的的异步异常
    (Object error, StackTrace stack){
      print("catch exception:");
      print("error = $error");
      print("stack = $stack");
      //...这里我们可以上报异常信息
    },
    //配置zone，可以定义一些代码行为
    zoneSpecification: ZoneSpecification(
      //如拦截日志信息
      print: (Zone self, ZoneDelegate parent, Zone zone, String line){
        //parent.print(zone, "intercepted print: line = $line");
        //...这里我们可以上报日志信息
      },
    ),
    //定义zone的私有数据，可以通过zone[key]获取
    zoneValues: {}
  );
}

//主路由
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //注册路由表
      routes: {
        ButtonPage.NAME: (context) => ButtonPage(),
        ImagePage.NAME: (context) => ImagePage(),
        TextPage.NAME: (context) => TextPage(),
        TextFieldPage.NAME: (context) => TextFieldPage(),
        InheritedPage.NAME: (context) => InheritedPage(),
        StreamPage.NAME: (context) => StreamPage(),
        FuturePage.NAME: (context) => FuturePage(),
        NestScrollViewPage.NAME: (context) => NestScrollViewPage(),
        HttpClientPage.NAME: (context) => HttpClientPage(),
        DioPage.NAME: (context) => DioPage(),
        GetBatteryLevelPage.NAME: (context) => GetBatteryLevelPage(),
        GetPlatformVersionPage.NAME: (context) => GetPlatformVersionPage()
      },
      home: MyHomePage(title: 'Flutter Demo'),
    );
  }

}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  //当Widget第一次插入到Widget树时会被调用，对于每一个State对象, Flutter framework只会调用一次该回调，
  //所以，通常在该回调中做一些一次性的操作，如状态初始化、订阅子树的事件通知等
  @override
  void initState() {
    super.initState();
    print("initState()");
  }

  //当State对象的依赖发生变化时会被调用, 典型的场景是当系统语言Locale或应用主题改变时，Flutter framework会通知widget调用此回调。
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies()");
  }

  //主要是用于构建Widget子树的,会在如下场景被调用：
  //在调用initState()之后。
  //在调用didUpdateWidget()之后。
  //在调用setState()之后。
  //在调用didChangeDependencies()之后。
  //在State对象从树中一个位置移除后（会调用deactivate）又重新插入到树的其它位置之后。
  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have clicked the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            _buildWrapWidget(context)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  //此回调是专门为了开发调试而提供的，在热重载(hot reload)时会被调用，此回调在Release模式下永远不会被调用。
  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }


  //在widget重新构建时，Flutter framework会调用Widget.canUpdate来检测Widget树中同一位置的新旧节点，然后决定是否需要更新，
  //如果Widget.canUpdate返回true则会调用此回调, 正如之前所述，Widget.canUpdate会在新旧widget的key和runtimeType同时相等时会返回true，
  //也就是说在在新旧widget的key和runtimeType同时相等时didUpdateWidget()就会被调用。
  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdataWidget");
  }

  //当State对象从树中被移除时，会调用此回调
  @override
  void deactivate() {
    super.deactivate();
    print("deactivate");
  }

  //如果deactivate调用后，State对象从树中被移除没有重新插入到树中则紧接着会调用dispose()方法，当State对象从树中被永久移除时调用，通常在此回调中释放资源。
  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  Wrap _buildWrapWidget(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: [
        OutlinedButton(
          child: Text("text"),
          onPressed: (){
            //通过Navigator.push()导航到新路由
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return TextPage();
            }));
          },
        ),
        OutlinedButton(
          child: Text("button"),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return ButtonPage();
            }));
          },
        ),
        OutlinedButton(
          child: Text("image"),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return ImagePage();
            }));
          },
        ),
        OutlinedButton(
          child: Text("text field"),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return TextFieldPage();
            }));
          },
        ),
        OutlinedButton(
          child: Text("inherited widget"),
          onPressed: (){
            Navigator.of(context).pushNamed(InheritedPage.NAME);
          },
        ),
        OutlinedButton(
          child: Text("stream builder"),
          onPressed: (){
            Navigator.of(context).pushNamed(StreamPage.NAME);
          },
        ),
        OutlinedButton(
          child: Text("nest scrollview"),
          onPressed: (){
            Navigator.of(context).pushNamed(NestScrollViewPage.NAME);
          },
        ),
        OutlinedButton(
          child: Text("future builder"),
          onPressed: (){
            Navigator.of(context).pushNamed(FuturePage.NAME);
          },
        ),
        OutlinedButton(
          child: Text("http client"),
          onPressed: (){
            Navigator.of(context).pushNamed(HttpClientPage.NAME);
          },
        ),
        OutlinedButton(
          child: Text("dio"),
          onPressed: (){
            Navigator.of(context).pushNamed(DioPage.NAME);
          },
        ),
        OutlinedButton(
          child: Text("get battery plugin"),
          onPressed: (){
            Navigator.of(context).pushNamed(GetBatteryLevelPage.NAME);
          },
        ),
        OutlinedButton(
          child: Text("get version plugin"),
          onPressed: (){
            Navigator.of(context).pushNamed(GetPlatformVersionPage.NAME);
          },
        ),
      ],
    );
  }

}

