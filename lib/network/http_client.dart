
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

/// 使用HttpClient发起http网络请求，HttpClient是dart:io库中提供的一个类
class HttpClientPage extends StatefulWidget{

  static const NAME = 'http_client_page';

  @override
  State createState() {
    return _HttpClientPageState();
  }
}

class _HttpClientPageState extends State<HttpClientPage>{

  bool _isLoading = false;
  String _text = '';

  Future<Null> _request() async {
    if(_isLoading){
      return;
    }
    _text = 'loading';
    setState(() {
      _isLoading = true;
    });
    HttpClient httpClient;
    try{
      //1、创建HttpClient
      httpClient = new HttpClient();
      //2、打开http连接，获取到HttpClientRequest
      HttpClientRequest request = await httpClient.getUrl(Uri.parse("http://www.baidu.com"));
      //3、可以通过request添加headers
      request.headers.add("key", "value");
      //4、连接服务器，获取到HttpClientResponse
      HttpClientResponse response = await request.close();
      //5、通过response读取响应内容或响应头, 响应内容是一个Stream
      _text = await response.transform(utf8.decoder).join();
    }catch(e){
      print(e);
      _text = 'load fail';
    }finally{
      //6、关闭HttpClient，终止HttpClient发起的所有请求
      if(httpClient != null){
        httpClient.close();
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
        title: Text("HttpClient发起网络请求"),
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