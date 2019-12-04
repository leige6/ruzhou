import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ruzhou/entity/tab_entity.dart';
import 'package:ruzhou/widgets/load_image.dart';
import 'package:ruzhou/widgets/news_list_view.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

//flutter is a SingleTickerProviderStateMixin but multiple tickers were created. 报错，原因是多个地方调用setState请求重绘，但是state使用的是SingleTickerProviderStateMixin ，将其改成TickerProviderStateMixin即可
//原文链接：https://blog.csdn.net/email_jade/article/details/85317859
class _HomePageState extends State<HomePage>  with TickerProviderStateMixin,AutomaticKeepAliveClientMixin{

  var _futureBuilderFuture;//防止FutureBuilder不必要的刷新
  TabController controller;
  final tabBarList=<Widget>[];
  final tabBarViewList=<Widget>[];
  //当整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void initState() {
    super.initState();
    Timer _timer=Timer.periodic(new Duration(seconds: 2),(timer){
      print("-------------------hello word----------------");
    });
    ///用_futureBuilderFuture来保存_gerData()的结果，以避免不必要的ui重绘:相关blog地址：https://blog.csdn.net/u011272795/article/details/83010974
    _futureBuilderFuture=_loadData();
  }

  void errorRetry(){
    setState(() {
      tabBarList.clear();
      tabBarViewList.clear();
    });
    _loadData();
  }

  Future  _loadData() async{
    //模拟网络请求
   return Future.delayed(Duration(seconds: 1)).then((_res) async {
        //此为加载结束
        tabBarList.clear();
        tabBarViewList.clear();
        final _tabsList=<TabEntity>[
          TabEntity(1, '推荐','recom',null),
          TabEntity(2, '热点','hot',null),
          TabEntity(3, '本地','local',null),
          TabEntity(4, '新时代','newtime',null),
        ];
        for(int i=0;i<_tabsList.length;i++){
          TabEntity tabEntity=_tabsList[i];
          tabBarList.add(Text('${tabEntity.name}'));
          tabBarViewList.add(NewsListView(code:'${tabEntity.code}'));
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    //super.build(context)此句是为了防止BottomNavigationBar+PageView页面状态保持失效
    super.build(context);
    // TODO: implement build
    return Scaffold(
          appBar: new AppBar(
            backgroundColor:Colors.blue,
            title: new Text('首页'),
          ),
          body:FutureBuilder(
            builder: _buildFuture,
            future: _futureBuilderFuture, // 用户定义的需要异步执行的代码，类型为Future<String>或者null的变量或函数
          ),
        );

  }

  ///snapshot就是_calculation在时间轴上执行过程的状态快照
  Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return _emptyView;
      case ConnectionState.waiting: return _loadingView;  //如果_calculation正在执行则提示：加载中
      default:    //如果_calculation执行完毕
        if (snapshot.hasError)    //若_calculation执行出现异常
          return _errorView;
        else    //若_calculation执行正常完成
          //initialIndex初始选中第几个
          controller = TabController(initialIndex: 1, length: tabBarList.length, vsync: this);
          return Container(
            //宽高都充满屏幕剩余空间
            width: double.infinity,
            height: double.infinity,
            child: Center(
                child: DefaultTabController(
                    length: tabBarList.length,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: ScreenUtil.getInstance().setHeight(80.0),
                          padding:EdgeInsets.only(left:ScreenUtil.getInstance().setWidth(20.0),),
                          alignment: Alignment.centerLeft,
                          color: Colors.white,
                          child: TabBar(
                              controller: controller,//可以和TabBarView使用同一个TabController
                              isScrollable: true,
                              indicatorColor: Colors.white,
                              indicatorSize: TabBarIndicatorSize.label,
                              unselectedLabelColor: Colors.black,
                              unselectedLabelStyle: TextStyle(fontSize: ScreenUtil.getInstance().setSp(35.0)),
                              labelColor: Colors.red,
                              labelPadding: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(35.0)),
                              labelStyle: TextStyle(fontSize: ScreenUtil.getInstance().setSp(40.0)),
                              tabs: tabBarList),
                        ),
                        Divider(
                          height: 1.0,
                          color: Color(0xffd3d3d3),
                        ),
                        Expanded(
                            child: TabBarView(
                              controller: controller,
                              children:  tabBarViewList,// physics: NeverScrollableScrollPhysics(), // 禁止滑动
                            ))
                      ],
                    )
                )
            ),
          );
    }
  }

  ///数据为空的视图
  Widget get _emptyView {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LoadAssetImage('empty',height:ScreenUtil.getInstance().setHeight(100.0), width: ScreenUtil.getInstance().setWidth(100.0),),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text('暂无数据',
              style: TextStyle(
                fontSize: ScreenUtil.instance.setSp(23.0),
              ),
            ),
          )
        ],
      ),
    );
  }

  ///加载中视图
  Widget get _loadingView {
    return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: Colors.transparent),
          alignment: Alignment.center,
          child: Container(
            width: ScreenUtil.getInstance().setWidth(150.0),
            height: ScreenUtil.getInstance().setHeight(150.0),
            padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(10)),
            decoration: BoxDecoration(
                color: Color(0x88000000), borderRadius: BorderRadius.circular(6)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CircularProgressIndicator(),
                Text('正在加载',
                    style: TextStyle(
                      fontSize: ScreenUtil.instance.setSp(23.0),
                      //fontWeight: FontWeight.bold
                    )
                )
              ],
            ),
          ),
        );

  }


  ///错误视图
  Widget get _errorView {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LoadAssetImage('load_error',height:  ScreenUtil.getInstance().setHeight(100.0), width: ScreenUtil.getInstance().setWidth(100.0),),
          Text("加载失败，请重试",
              style: TextStyle(
                fontSize: ScreenUtil.instance.setSp(23.0),
                //fontWeight: FontWeight.bold
              )),
          RaisedButton(
            color: Color(0xffbc2929),
            onPressed: this.errorRetry,
            child: Text(
              '重新加载',
              style: TextStyle(color: Colors.white,
                fontSize: ScreenUtil.instance.setSp(23.0),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;



}