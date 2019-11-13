import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTabPage extends StatefulWidget {

  final tabBarList;
  final tabBarViewList;

  HomeTabPage(
      {Key key,
        this.tabBarList,
        this.tabBarViewList})
      : super(key: key);


  @override
  _HomeTabPage createState() => _HomeTabPage();
}


class _HomeTabPage extends State<HomeTabPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin{
  TabController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    //initialIndex初始选中第几个
    controller = TabController(initialIndex: 1, length: widget.tabBarList.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
        length: widget.tabBarList.length,
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: ScreenUtil.getInstance().setHeight(40.0),
              padding:EdgeInsets.only(left:ScreenUtil.getInstance().setWidth(20.0),),
              alignment: Alignment.centerLeft,
              color: Colors.white,
              child: TabBar(
                  controller: controller,//可以和TabBarView使用同一个TabController
                  isScrollable: true,
                  indicatorColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.label,
                  unselectedLabelColor: Colors.black,
                  unselectedLabelStyle: TextStyle(fontSize: ScreenUtil.getInstance().setSp(18.0)),
                  labelColor: Colors.red,
                  labelPadding: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(30.0)),
                  labelStyle: TextStyle(fontSize: ScreenUtil.getInstance().setSp(20.0)),
                  tabs: widget.tabBarList),
            ),
            Divider(
              height: 1.0,
              color: Color(0xffd3d3d3),
            ),
            Expanded(
                child: TabBarView(
                  controller: controller,
                  children:  widget.tabBarViewList,// physics: NeverScrollableScrollPhysics(), // 禁止滑动
                ))
          ],
        )
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}