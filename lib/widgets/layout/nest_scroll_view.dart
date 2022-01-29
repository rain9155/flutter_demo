import 'package:flutter/material.dart';

class NestScrollViewPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, _){
          return [
            SliverAppBar(
              title: Text('NestScrollViewPage'),
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