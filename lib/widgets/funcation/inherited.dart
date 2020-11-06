import 'package:flutter/material.dart';

///一个简易版的跨组件状态共享组件Provider实现
class FirstPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("FirstWidget"),
        ),
        body: Builder(builder: (context){
          print("parent build");
          return Center(child: SharedDataProvider<Num>(
            data: Num(),
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                Builder(builder: (context){
                  print("not depend widget build");
                  return RaisedButton(
                    child: Text("open second page"),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return SecondPage();
                      }));
                    },
                  );
                }),
                SizedBox(height: 10),
                Builder(builder: (context){
                  print("depend widget build");
                  return Text(
                    "num = ${SharedDataProvider.of<Num>(context).num}",
                    textScaleFactor: 1.5,
                  );
                }),
              ],
            ),
          ),);
        })
    );
  }
}

class SecondPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SecondPage")),
      body: Center(child: Builder(builder: (context){
          print("FloatingActionButton build");
          return FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: (){
              SharedDataProvider.of<Num>(context, listen: false).increase();
            },
          );
        }),
      ),
    );
  }

}

///共享的数据，订阅/发布模式
class Num extends ChangeNotifier{

  int num = 0;

  ///当数据更新时，通知Provider更新
  void increase(){
    num++;
    notifyListeners();
  }

}

///Provider，用于获取共享数据
class SharedDataProvider<T extends ChangeNotifier> extends StatefulWidget{

  SharedDataProvider({
    this.data,
    this.child
  });

  final T data;

  final Widget child;

  ///给定context获取widget树中距离最近的InheritedWidget实例
  static T of<T>(BuildContext context, {bool listen = true}){
    final sharedDataWidget = listen
        ? context.dependOnInheritedWidgetOfExactType<SharedDataWidget<T>>()
        : context.getElementForInheritedWidgetOfExactType<SharedDataWidget<T>>().widget as SharedDataWidget<T>;
    return sharedDataWidget?.data;
  }

  @override
  State createState() => _SharedDataProviderState<T>();

}

///订阅共享数据，当数据更新时负责重新构建InheritedWidget
class _SharedDataProviderState<T extends ChangeNotifier> extends State<SharedDataProvider<T>>{

  void _update(){
    setState((){});
  }

  @override
  void initState() {
    widget.data.addListener(_update);
    super.initState();
  }

  @override
  void didUpdateWidget(SharedDataProvider<T> oldWidget) {
    if(oldWidget.data != widget.data){
      oldWidget.data.removeListener(_update);
      widget.data.addListener(_update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print("SharedDataProvider build");
    return SharedDataWidget<T>(
      data: widget.data,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    widget.data.removeListener(_update);
    super.dispose();
  }
}

///InheritedWidget，含有共享数据，代理了child widget
class SharedDataWidget<T> extends InheritedWidget{

  SharedDataWidget({
    @required this.data,
    @required Widget child
  }) : assert(child != null),
        super(child: child);

  final T data;

  ///返回值决定依赖共享数据的child是否重新构建，true时依赖的child的didChangeDepend、build方法会被调用
  @override
  bool updateShouldNotify(SharedDataWidget<T> oldWidget) {
    return true;
  }
}


