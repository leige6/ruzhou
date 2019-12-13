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
}
