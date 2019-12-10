
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ruzhou/constant/colours.dart';
import 'package:ruzhou/constant/dimens.dart';
import 'package:ruzhou/constant/gaps.dart';
import 'package:ruzhou/router/fluro_navigator.dart';

/// 自定义AppBar
class MyAppBar extends StatelessWidget implements PreferredSizeWidget{

  const MyAppBar({
    Key key,
    this.backgroundColor,
    this.title: "",
    this.centerTitle: "",
    this.actionName: "",
    this.backImg: "",
    this.onPressed,
    this.isBack: true
  }): super(key: key);

  final Color backgroundColor;
  final String title;
  final String centerTitle;
  final String backImg;
  final String actionName;
  final VoidCallback onPressed;
  final bool isBack;

  @override
  Widget build(BuildContext context) {
    Color _backgroundColor;

    if (backgroundColor == null){
      _backgroundColor = Theme.of(context).appBarTheme.color;
    }else{
      _backgroundColor = backgroundColor;
    }

    SystemUiOverlayStyle _overlayStyle =  SystemUiOverlayStyle.light ;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayStyle,
      child: Material(
        color: _backgroundColor,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: centerTitle.isEmpty ? Alignment.centerLeft : Alignment.center,
                    width: double.infinity,
                    child: Text(
                        title.isEmpty ? centerTitle : title,
                        style: TextStyle(
                          fontSize: Dimens.font_sp20,
                          color: Colours.material_bg ,
                        )
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 48.0),
                  )
                ],
              ),
              isBack ? IconButton(
                onPressed:(){
                  NavigatorUtils.goBack(context);
                },
                tooltip: 'Back',
                padding: const EdgeInsets.all(12.0),
                icon: Icon(Icons.arrow_back_ios,color:  _overlayStyle == SystemUiOverlayStyle.light ? Colours.material_bg : Colours.text,),
              ) : Gaps.empty,
              Positioned(
                right: 0.0,
                child: Theme(
                  data: Theme.of(context).copyWith(
                      buttonTheme: ButtonThemeData(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        minWidth: 60.0,
                      )
                  ),
                  child: actionName.isEmpty ? Container() :
                  FlatButton(
                    child: Text(actionName, key: const Key('actionName')),
                    textColor: _overlayStyle == SystemUiOverlayStyle.light ? Colours.material_bg : Colours.text,
                    highlightColor: Colors.transparent,
                    onPressed: onPressed,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(48.0);
}
