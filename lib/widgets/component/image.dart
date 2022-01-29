import 'package:flutter/material.dart';

/// 图片控件及加载图片
/// Image: 用来展示一张图片，图片来源可以是asset、文件、内存以及网络
/// ImageProvider：ImageProvider 是一个抽象类，主要定义了图片数据获取的接口load()，从不同的数据源获取图片需要实现不同的ImageProvider
/// Icon: 可以像web开发一样使用iconfont，iconfont即“字体图标”，它是将图标做成字体文件，然后通过指定不同的字符而显示不同的图片。
class ImagePage extends StatelessWidget{

  static const NAME = 'image_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("图片控件及加载图片"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              //! AssetImage是实现了从Asset中加载图片的ImageProvider
              image: AssetImage("assets/images/girl.jpg"),
              width: 100,
            ),
            //也可以用这种方式从asset加载图片
            Image.asset("assets/images/girl.jpg",
              width: 100,
            ),
            Image(
              //! NetworkImage是实现了从Asset中加载图片的ImageProvider
              image: NetworkImage("https://img-blog.csdnimg.cn/20190508204540271.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L1JhaW5fOTE1NQ==,size_16,color_FFFFFF,t_70"),
              width: 100,
            ),
            // 也可以用这种方式从网络加载图片
            Image.network("https://img-blog.csdnimg.cn/20190508204540271.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L1JhaW5fOTE1NQ==,size_16,color_FFFFFF,t_70",
              width: 100,
            ),
            //! 控制图片显示的外观、大小等
            Image(
              image: AssetImage("assets/images/girl.jpg"),
              width: 100,
              color: Colors.blue,//图片的混合色值
              colorBlendMode: BlendMode.difference,//混合模式
              alignment: Alignment.centerLeft,//对齐方式
              repeat: ImageRepeat.repeatY,//当图片小于控件宽高时，指定图片的重复规则
              fit: BoxFit.cover,//该属性用于在图片的显示空间和图片本身大小不同时指定图片的适应模式。有以下取值：
              //fill： 会拉伸填充满显示空间，图片会变形。
              //cover： 会按图片的长宽比放大后居中填满显示空间，图片不会变形，超出显示空间部分会被剪裁。
              //contain：这是图片的默认适应规则，图片会在保证图片本身长宽比不变的情况下缩放以适应当前显示空间，图片不会变形。
              //fitWidth、fitHeight：图片的宽度（高度）会缩放到显示空间的宽度（高度），高度（宽度）会按比例缩放，然后居中显示，图片不会变形，超出显示空间部分会被剪裁
              //none: 图片没有适应策略，会在显示空间内显示图片，如果图片比显示空间大，则显示空间只会显示图片中间部分。
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //! 字体图标, flutter已经封装好，Icons里面有许多字体对应的图标
                Icon(Icons.access_alarm,
                    color: Colors.blue
                ),
                Icon(Icons.accessibility),
                Icon(Icons.zoom_out_map,
                  color: Colors.red,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}