import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// 使用Dio库发起http网络请求
/// see also: https://github.com/flutterchina/dio
class DioPage extends StatefulWidget{

  static const NAME = 'dio_page';

  @override
  State createState() {
    return _DioPageState();
  }
}

class _DioPageState extends State<DioPage>{

  bool _isLoading = false;
  String _text = '';

  void _request() async {
    if(_isLoading){
      return;
    }
    _text = 'loading';
    setState(() {
      _isLoading = true;
    });
    Dio? dio;
    try{
      //1、创建Dio
      dio = new Dio();
      //2、发起网络请求，得到响应
      Response<String> response = await dio.get("http://www.baidu.com");
      //3、获取响应内容
      _text = response.data!;
    }catch(e){
      print(e);
      _text = 'load fail';
    }finally{
      //4、关闭Dio，终止Dio发起的所有请求
      if(dio != null){
        dio.close();
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dio发起网络请求"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              ElevatedButton(
                child: Text("发起网络请求"),
                onPressed: _request,
              ),
              SizedBox(height: 10),
              Text(_text),
            ],
          ),
        ),
      ),
    );
  }

}