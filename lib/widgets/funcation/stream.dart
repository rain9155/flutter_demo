import 'dart:async';

import 'package:flutter/material.dart';

/// 使用StreamBuilder和Stream实现一个计数器：
/// StreamBuilder是Flutter中的一个异步控件，配合Stream使用，用于异步更新的场景
/// Stream是Dart中用于接收异步事件的流，和Future不同的是，它可以接收多个异步操作的结果
class StreamPage extends StatefulWidget{

  static const NAME = 'stream_page';

  @override
  State createState() => _StreamPageState();

}

class _StreamPageState extends State<StreamPage>{

  int _count = 0;

  /// 通过StreamController控制Stream
  final _streamControl = StreamController<int>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StreamBuilder控件"),
      ),
      body: Center(
        child: Builder(builder: (context){
          print("parent build");
          return Column(
            children: <Widget>[
              SizedBox(height: 10),
              StreamBuilder(
                /// 初始值
                initialData: _count,
                /// 通过StreamController实例的stream字段获取Stream出口
                stream: _streamControl.stream,
                /// builder，每次数据更新时都会被调用
                builder: (context, snapshot){
                  print("child build");
                  return Text(
                    snapshot.data.toString(),
                    textScaleFactor: 1.5,
                  );
                },
              ),
              SizedBox(height: 10),
              FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: (){
                  /// 通过StreamController实例的sink字段获取Stream入口
                  _streamControl.sink.add(++_count);
                },
              ),
            ],
          );
        })
      ),
    );
  }

  @override
  void dispose() {
    _streamControl.close();
    super.dispose();
  }
}