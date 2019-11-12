import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ruzhou/entity/tab_entity.dart';
import 'package:ruzhou/widgets/news_list_view.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage>  with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin{

  final  _tabsList=<TabEntity>[
    TabEntity(1, '推荐','recom',null),
    TabEntity(2, '热点','hot',null),
    TabEntity(3, '本地','local',null),
    TabEntity(4, '新时代','newtime',null),
  ];






  final tabBarList =[Text('推荐'),Text('热点'),Text('本地'),Text('新时代'),];
  final List<Widget> tabBarViewList  =[NewsListView(code:'recom'),NewsListView(code:'hot'),NewsListView(code:'local'),NewsListView(code:'newtime'),];
  @override
  void dispose() {
    super.dispose();

  }

  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
          appBar: new AppBar(
            backgroundColor:Colors.blue,
            title: new Text('首页'),
          ),
          body:DefaultTabController(
            length: _tabsList.length,
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 40,
                  padding:EdgeInsets.only(left:ScreenUtil.getInstance().setWidth(20.0),),
                  alignment: Alignment.centerLeft,
                  color: Colors.white,
                  child: TabBar(
                      isScrollable: true,
                      indicatorColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.label,
                      unselectedLabelColor: Colors.black,
                      unselectedLabelStyle: TextStyle(fontSize: 18),
                      labelColor: Colors.red,
                      labelPadding: EdgeInsets.only(right: 30),
                      labelStyle: TextStyle(fontSize: 20),
                      tabs: tabBarList),
                ),
                Divider(
                  height: 1.0,
                  color: Color(0xffd3d3d3),
                ),
                Expanded(
                    child: TabBarView(
                      children:  tabBarViewList,// physics: NeverScrollableScrollPhysics(), // 禁止滑动
                    ))
              ],
            )
          )
        );

  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;



}