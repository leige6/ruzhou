import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:ruzhou/constant/colours.dart';
import 'package:ruzhou/entity/gallery_image_entity.dart';
import 'package:ruzhou/model/select_images_model.dart';
import 'package:ruzhou/model/store.dart';
import 'package:ruzhou/router/find_router.dart';
import 'package:ruzhou/router/fluro_navigator.dart';
import 'package:ruzhou/utils/image_utils.dart';
import 'package:ruzhou/utils/utils.dart';
import 'package:ruzhou/widgets/app_bar.dart';
import 'package:ruzhou/widgets/find_my_text_filed.dart';

class FindPage extends StatefulWidget {
  @override
  _FindPageState createState() => _FindPageState();
}


class _FindPageState extends State<FindPage> with AutomaticKeepAliveClientMixin{

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // TODO: implement build
    return Scaffold(
      appBar: MyAppBar(
        isBack: false,
        centerTitle: '发现',
      ),
      body:defaultTargetPlatform == TargetPlatform.iOS ?FormKeyboardActions(
        child: _buildBody(),
      ) :SingleChildScrollView(
        child: _buildBody()
      )
    );
  }

  _buildBody(){
    return  Container(
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height,
      ),
      padding: EdgeInsets.only(
        top:ScreenUtil.getInstance().setHeight(24.0),
        left: ScreenUtil.getInstance().setWidth(35.0),
        right: ScreenUtil.getInstance().setWidth(35.0),
        bottom: ScreenUtil.getInstance().setHeight(24.0),
      ),
      color: Colors.white,
      child: Center(
        child: Text("发现"),
      ),
    );
    }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
  }
}