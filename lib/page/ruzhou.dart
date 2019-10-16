import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ruzhou/constant/string.dart';
import 'find/find_page.dart';
import 'home/home_page.dart';
import 'mine/mine_page.dart';
class RuZhouMainView extends StatefulWidget {
  @override
  _RuZhouMainViewState createState() => _RuZhouMainViewState();
}

class _RuZhouMainViewState extends State<RuZhouMainView> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _list = List();


  @override
  void initState() {
    super.initState();
    _list
      ..add(HomePage())
      ..add(FindPage())
      ..add(MinePage());
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _list,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(IconData(0xe619,fontFamily: 'RuZhouIcons')),
            title: Text(Strings.HOME,style: TextStyle(fontSize: 12),),
          ),
          BottomNavigationBarItem(
            icon: Icon(IconData(0xe6c0,fontFamily: 'RuZhouIcons')),
            title: Text(Strings.FIND,style: TextStyle(fontSize: 12),),
          ),
          BottomNavigationBarItem(
            icon: Icon(IconData(0xe61f,fontFamily: 'RuZhouIcons')),
            title: Text(Strings.MINE, style: TextStyle(fontSize: 12),
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepOrangeAccent,
        unselectedItemColor: Colors.grey,
        iconSize: 18,
        onTap: _onItemTapped,
      ),
    );
  }
}
