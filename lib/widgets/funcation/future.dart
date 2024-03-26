
import 'package:flutter/material.dart';

/// FutureBuilder是一个异步更新UI组件，它依赖一个Future，它会根据所依赖的Future的状态来动态构建自身
class FuturePage extends StatefulWidget{

  static const NAME = 'future_page';

  @override
  State createState() {
    return _FuturePageState();
  }
}

class _FuturePageState extends State<FuturePage>{

  Future<String> _request() async {
    //模拟网络请求
    return Future.delayed(Duration(seconds: 2), (){
      return '我是从互联网返回的数据';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FutureBuilder控件"),
      ),
      body: Center(
        child: FutureBuilder(
          /// 初始值
          initialData: 'loading',
          /// Future
          future: _request(),
          /// builder，每次数据更新时都会被调用
          builder: (BuildContext context, AsyncSnapshot<String> snapshot){
            // 请求已结束
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                // 请求失败，显示错误
                return Text(snapshot.error?.toString() ?? "");
              } else {
                // 请求成功，显示数据
                return Text(snapshot.data!);
              }
            } else {
              // 请求未结束，显示loading
              return Text(snapshot.data!);
            }
          },
        ),
      ),
    );
  }
}