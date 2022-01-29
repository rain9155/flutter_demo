import 'package:flutter/material.dart';

class NestScrollViewPage extends StatelessWidget{

  static const NAME = "nest_scroll_view_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, _){
          return [
            SliverAppBar(
              title: Text('NestedScrollView控件'),
              automaticallyImplyLeading: true,
              pinned: true,
            )
          ];
        },
        body: Builder(
          builder: (context){
            return ListView.builder(
              itemExtent: 60,
              itemBuilder: (context, index){
                return Text(index.toString());
              },
            );
          },
        ),
      ),
    );
  }
}