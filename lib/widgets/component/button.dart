import 'package:flutter/material.dart';

/// 关于按钮的控件，都来自material库
/// 所有material 库中的按钮都有如下相同点：
/// 1、按下时都会有“水波动画”
/// 2、有一个onPressed属性来设置点击回调，当按钮按下时会执行该回调，如果不提供该回调则按钮会处于禁用状态，禁用状态不响应用户点击。
/// RaisedButton->ElevatedButton：即"漂浮"按钮
/// FlatButton->TextButton:   即扁平按钮
/// OutlineButton->OutlinedButton: 默认有一个边框的按钮
/// IconButton: 是一个可点击的Icon
class ButtonPage extends StatelessWidget{

  static const NAME = 'button_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("按钮控件"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //! "漂浮"按钮,它默认带有阴影和灰色背景。
            // 按下后，阴影会变大
            ElevatedButton(
              child: Text("raised button"),
              onPressed: (){},
            ),
            //! 扁平按钮,默认背景透明并不带阴影。
            // 按下后，会有背景色
            TextButton(
              child: Text("flat button"),
              onPressed: (){},
            ),
            //! OutlineButton默认有一个边框，不带阴影且背景透明。
            // 按下后，边框颜色会变亮、同时出现背景和阴影(较弱)
            OutlinedButton(
              child: Text("outline button"),
              onPressed: (){},
            ),
            //! IconButton: 是一个可点击的Icon,不包括文字，默认没有背景
            //点击后会出现背景
            IconButton(
              icon: Icon(Icons.thumb_up),
              onPressed: (){},
            ),
          ],
        ),
      ),
    );
  }

}