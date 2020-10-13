import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/base/button.dart';
import 'package:flutter_demo/widgets/base/image.dart';
import 'package:flutter_demo/widgets/base/textfield.dart';
import 'package:flutter_demo/widgets/state.dart';
import 'package:flutter_demo/widgets/base/text.dart';

void main() => runApp(MyApp());

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
        "counter_page" : (context) => CounterPage(),
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

  @override
  Widget build(BuildContext context) {
    //一个依赖库，生成随机字符串
    final wordPair = new WordPair.random();
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
            Text(
                wordPair.toString()
            ),
            FlatButton(
              child: Text("Open counter page"),
              textColor: Colors.amber,
              //注册路由表，通过路由名打开新路由页
              onPressed: () => Navigator.pushNamed(context, "counter_page"),
            ),
            FlatButton(
              child: Text("Open text page"),
              onPressed: (){
                //通过Navigator.push()导航到新路由
                Navigator.push(context, MaterialPageRoute(builder: (context){
                    return TextPage();
                  }));
              },
            ),
            FlatButton(
              child: Text("Open button page"),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return ButtonPage();
                }));
              },
            ),
            FlatButton(
              child: Text("Open image page"),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return ImagePage();
                }));
              },
            ),
            FlatButton(
              child: Text("Open text field page"),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return TextFieldPage();
                }));
              },
            ),
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
}

