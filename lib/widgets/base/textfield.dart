import 'package:flutter/material.dart';

/// 输入框和表单控件
///TextField: 用于文本输入
///Form： 它可以对输入框进行分组，然后进行一些统一操作，如输入内容校验、输入框重置以及输入内容保存。它的child只能为FieldForm的子类
class TextFieldPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("输入框和表单"),
      ),
      body: Column(
        children: <Widget>[
          //! Form中的子控件一定要是TextFormField
          TextField(
            autofocus: true,//是否自动获取焦点
            //用于控制TextField的外观显示，如提示文本、背景颜色、边框等
            decoration: InputDecoration(
                labelText: "用户名",//文本
                hintText: "用户名或email",//提示文本
                prefixIcon: Icon(Icons.person)//图标
            ),
          ),
          TextField(
            decoration: InputDecoration(
                labelText: "密码",
                hintText: "你的登陆密码",
                prefixIcon: Icon(Icons.lock)
            ),
            obscureText: true,//是否隐藏正在编辑的文本，如用于输入密码的场景等
          ),
          FormWidget()
        ],
      ),
    );
  }
}

class FormWidget extends StatefulWidget{

  @override
  State createState() => _FormWidgetState();

}

class _FormWidgetState extends State<FormWidget>{

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      //！ Form，表单
      child: Form(
        key: _formKey,// 设置globalKey，用于后面获取FormState
        autovalidate: true,//是否自动校验输入内容；当为true时，每一个子FormField内容发生变化时都会自动校验合法性，并直接显示错误信息。否则，需要通过调用FormState.validate()来手动校验。
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //! Form中的子控件一定要是FormField的子类，TextFormField时FormField的子类，同时是TextField的包装类
            TextFormField(
              autofocus: true,
              controller: _usernameController,
              decoration: InputDecoration(
                  labelText: "用户名",
                  hintText: "用户名或email",
                  prefixIcon: Icon(Icons.person)
              ),
              //验证用户名
              validator: (v){
                return v.trim().length > 0 ? null : "用户名不能为空";
              },
            ),
            TextFormField(
              controller: _pwdController,
              decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "你的登陆密码",
                  prefixIcon: Icon(Icons.lock)
              ),
              obscureText: true,
              //验证密码
              validator: (v){
                return v.trim().length > 5 ? null : "密码不能少于6位";
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(onPressed: (){
                      // 通过_formKey.currentState 获取FormState后，
                      // 调用validate()方法校验用户名密码是否合法，
                      // 校验通过后再提交数据。
                      if((_formKey.currentState as FormState).validate()){
                        //验证通过提交数据
                      }},
                      child: Text("登陆"),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}