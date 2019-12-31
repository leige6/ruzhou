import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ruzhou/constant/colours.dart';
import 'package:ruzhou/constant/common.dart';
import 'package:ruzhou/constant/strings.dart';
import 'package:ruzhou/entity/user_entity.dart';
import 'package:ruzhou/model/user_info_model.dart';
import 'package:ruzhou/widgets/load_image.dart';
import 'find/find_page.dart';
import 'home/home_page.dart';
import 'mine/mine_page.dart';
import 'package:flustars/flustars.dart' as FlutterStars;


class RuZhouMainView extends StatefulWidget {
  @override
  _RuZhouMainViewState createState() => _RuZhouMainViewState();
}

class _RuZhouMainViewState extends State<RuZhouMainView> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _pageList = List();
  var _appBarTitles = ['首页', '发现', '我的'];
  List<BottomNavigationBarItem> _listNav;
  final pageController = PageController();
  @override
  void initState() {
    super.initState();
    _pageList
      ..add(HomePage())
      ..add(FindPage())
      ..add(MinePage());
  }


  List<BottomNavigationBarItem> _buildBottomNavigationBarItem(){
    if (_listNav == null){
      var _tabImages = [
        [
          Icon(IconData(0xe619,fontFamily: 'MyIcons'),size: 25,color: Colours.unselected_item_color,),
          Icon(IconData(0xe619,fontFamily: 'MyIcons'),size: 25,color: Colours.app_main,),
        ],
        [
          Icon(IconData(0xe6c0,fontFamily: 'MyIcons'),size: 25,color: Colours.unselected_item_color,),
          Icon(IconData(0xe6c0,fontFamily: 'MyIcons'),size: 25,color: Colours.app_main,),
        ],
        [
          Icon(IconData(0xe61f,fontFamily: 'MyIcons'),size: 25,color: Colours.unselected_item_color,),
          Icon(IconData(0xe61f,fontFamily: 'MyIcons'),size: 25,color: Colours.app_main,),
        ],
      ];
      _listNav = List.generate(3, (i){
        return BottomNavigationBarItem(
            icon: _tabImages[i][0],
            activeIcon: _tabImages[i][1],
            title: Padding(
              padding: const EdgeInsets.only(top: 1.5),
              child: Text(_appBarTitles[i], key: Key(_appBarTitles[i]),),
            )
        );
      });
    }
    return _listNav;
  }

  void _onItemTapped(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
          body: SafeArea(
            top:false,
            child: PageView(
              controller: pageController,
              onPageChanged: onPageChanged,
              children: _pageList,
              physics: NeverScrollableScrollPhysics(), // 禁止滑动
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: _buildBottomNavigationBarItem(),
            currentIndex: _selectedIndex,
            elevation: 5.0,
            iconSize: 21.0,
            selectedFontSize: 10,
            unselectedFontSize: 10,
            selectedItemColor: Colours.app_main,
            unselectedItemColor: Colours.unselected_item_color,
            onTap: _onItemTapped,
          ),
    );
  }


  /*loadData() async {
    // 通过spawn新建一个isolate，并绑定静态方法
    ReceivePort receivePort =ReceivePort();
    await Isolate.spawn(dataInit, receivePort.sendPort);

    // 获取新isolate的监听port
    SendPort sendPort = await receivePort.first;
    // 调用sendReceive自定义方法
    List dataList = await sendReceive(sendPort, 'https://jsonplaceholder.typicode.com/posts');
    print('dataList $dataList');
  }

  // isolate的绑定方法
  static dataInit(SendPort sendPort) async{
    // 创建监听port，并将sendPort传给外界用来调用
    ReceivePort receivePort =ReceivePort();
    sendPort.send(receivePort.sendPort);

    // 监听外界调用
    await for (var msg in receivePort) {
      String requestURL =msg[0];
      SendPort callbackPort =msg[1];

      Client client = Client();
      Response response = await client.get(requestURL);
      List dataList = json.decode(response.body);
      // 回调返回值给调用者
      callbackPort.send(dataList);
    }
  }

  // 创建自己的监听port，并且向新isolate发送消息
  Future sendReceive(SendPort sendPort, String url) {
    ReceivePort receivePort =ReceivePort();
    sendPort.send([url, receivePort.sendPort]);
    // 接收到返回值，返回给调用者
    return receivePort.first;
  }*/
}
