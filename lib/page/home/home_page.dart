import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/bezier_bounce_footer.dart';
import 'package:flutter_easyrefresh/bezier_circle_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ruzhou/entity/home_entity.dart';
import 'package:ruzhou/entity/news_entity.dart';
import 'package:ruzhou/widgets/news_list_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage>  with SingleTickerProviderStateMixin{
  HomeEntity _homeEntity;
  List<NewsEntity> _newsList =List();
  EasyRefreshController _controller = EasyRefreshController();
  List<String> imgs=["https://pics.lvjs.com.cn/pics/uploads/pc/place2/2018-02-27/0d6da4ff-141c-414a-99ba-26aac3dd314b.jpg",
                      "https://pics.lvjs.com.cn/pics/uploads/pc/place2/2018-05-22/b767b716-725e-4736-8958-fb2bb1d74870.jpg",
                      "https://pics.lvjs.com.cn/pics/uploads/pc/place2/2018-02-27/0d6da4ff-141c-414a-99ba-26aac3dd314b.jpg",
                      "https://pics.lvjs.com.cn/uploads/pc/place2/2017-11-14/4201cc06-9107-4161-9791-1965a10506e0_480_320.jpg",
                       "https://pics.lvjs.com.cn/uploads/pc/place2/2017-08-08/7359ba0f-cdb1-4ed1-b198-da098c6e8b10_480_320.jpg"];
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    _queryHomeData();
  }


  _queryHomeData() async {
    await Future.delayed(Duration(seconds: 2), () {

      setState(() {
        for(int i=0;i<=20;i++){
          int imageIndex=i%5;
          bool isTop=i.isOdd;
          NewsEntity news=new NewsEntity(i, "驻马店“父子与少女生3孩”案开庭，被告人否认强奸，称发生关系后还给2000元，检方建议最高可判死刑真的么", "华商连线", 125, "9分钟前",isTop,imgs[imageIndex]);
          _newsList.add(news);
        }

      });
      _controller.finishRefresh();
    });
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
          appBar: new AppBar(
            backgroundColor:Colors.blue,
            title: new Text('首页'),
          ),
          body:contentWidget()
        );

  }

  Widget contentWidget() {
      return Container(
          child: EasyRefresh(
            controller: _controller,
            header: BezierCircleHeader(backgroundColor: Colors.deepOrange),
            footer: BezierBounceFooter(backgroundColor: Colors.deepOrange),
            enableControlFinishRefresh: true,
            enableControlFinishLoad: false,
            child:SingleChildScrollView(
               child: Column(
                   children: <Widget>[
                     NewsListView(_newsList),
                   ]
               )
            )
          ),
      );
  }

}