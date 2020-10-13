import 'package:flutter/material.dart';

/// 文本和字体样式控件，来自widgets库
/// Text：用于显示简单样式文本
class TextPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("文本控件"),
      ),
      body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Hello world!" * 6,
          textAlign: TextAlign.center, //文本的对齐方式；可以选择左对齐、右对齐还是居中。参考系是Text widget本身
        ),
        Text(
          "Hello world! I'm jianyu" * 5,
          maxLines: 1, //指定文本显示的最大行数，默认情况下，文本是自动折行的
          overflow: TextOverflow.ellipsis, //如果文本超出指定的最大行数，通过overflow来指定截断方式，默认是直接截断
        ),
        Text(
          "Hello world!",
          textScaleFactor: 1.5, //文本相对于当前字体大小的缩放因子
        ),
        Text(
          "Hello world",
          //！TextStyle用于指定文本显示的样式如颜色、字体、粗细、背景等
          style: TextStyle(
            color: Colors.blue, //文本颜色
            fontSize: 18.0, //文本字体大小
            height: 1.2, //指定文本行高，行高等于fontSize * height
            fontFamily: "Courier", //指定字体样式
            background: Paint()..color = Colors.yellow, //文本背景
            decoration: TextDecoration.underline, //指定文本装饰，如下划线
            decorationStyle: TextDecorationStyle.dashed, //指定decoration的style，如虚线
          ),
        ),
        //！ TextSpan代表文本的一个“片段”，可以对一个Text内容的不同部分按照不同的样式显示
        //通过Text.rich 方法将TextSpan 添加到Text中
        Text.rich(TextSpan(
            children: [
              TextSpan(
                text: "Home",
              ),
              TextSpan(
                  text: "https://flutter.cn",
                  style: TextStyle(
                      color: Colors.blue
                  )
              )
            ]
        )),
        //！DefaultTextStyle: 用于设置默认文本样式,
        //如果在widget树的某一个节点处设置一个默认的文本样式，那么该节点的子树中所有文本（Text）都会默认继承这个样式
        DefaultTextStyle(
          style: TextStyle(
              color: Colors.red,
              fontSize: 20.0
          ),
          child: Column(
            children: <Widget>[
              Text("I am rain"),//继承默认样式
              Text("I am jianyu"),//继承默认样式
              Text("Hello world",
                style: TextStyle(
                    inherit: false,//不继承默认样式
                    color: Colors.blue
                ),
              )
            ],
          ),
        )
      ],
    ),
    );
  }

}