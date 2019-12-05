
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ruzhou/constant/colours.dart';
import 'package:ruzhou/model/user_info_model.dart';
import 'package:ruzhou/utils/image_utils.dart';
import 'package:ruzhou/widgets/load_image.dart';
import 'package:ruzhou/widgets/water_mark.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}


class _MinePageState extends State<MinePage>  with AutomaticKeepAliveClientMixin{

  final TextStyle textStyle =
  TextStyle(fontSize: 18, fontWeight: FontWeight.w400);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: new AppBar(
          backgroundColor:Colors.blue,
          title: new Text('我的'),
        ),
        body: Container(
              color: Colours.material_bg,
              child: ListView(
                children: <Widget>[
                  Consumer<UserInfoModel>(
                      builder: (_, provider, __) {
                        return Container(
                            color: Colours.material_bg,
                            padding:EdgeInsets.only(
                              top: ScreenUtil.getInstance().setHeight(80.0),
                              left: ScreenUtil.getInstance().setWidth(35.0),
                              right: ScreenUtil.getInstance().setWidth(35.0),
                              bottom: ScreenUtil.getInstance().setHeight(60.0),
                            ),
                            child: new Column(
                              children: <Widget>[
                                Row(
                                    children: <Widget>[
                                      CircleAvatar(
                                          radius: 40.0,
                                          backgroundColor: Colours.user_head_bg,
                                          backgroundImage: ImageUtils.getImageProvider(provider.user?.avatarUrl, holderImg: 'user_head')
                                      ),
                                      new Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            padding:EdgeInsets.only(
                                              left: ScreenUtil.getInstance().setWidth(15.0),
                                              bottom: ScreenUtil.getInstance().setHeight(18.0),
                                            ),
                                            child:new Text("登录/注册",style: new TextStyle(fontSize: 18,fontWeight:FontWeight.bold,color: Colours.second_text),),
                                          ),
                                          Container(
                                            padding:EdgeInsets.only(
                                              left: ScreenUtil.getInstance().setWidth(15.0),
                                            ),
                                            child:new Text("点击登陆 赚积分兑大礼",style: new TextStyle(fontSize: 15,color: Colours.second_text),),
                                          ),
                                        ],
                                      )
                                    ]),
                              ],
                            )
                        );
                      }),
                  Container(
                      color: Colours.material_bg,
                      padding:EdgeInsets.only(
                        /*left: ScreenUtil.getInstance().setWidth(35.0),
                        right: ScreenUtil.getInstance().setWidth(35.0),*/
                        bottom: ScreenUtil.getInstance().setHeight(30.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Column(
                            children: <Widget>[
                              Padding(
                                padding:EdgeInsets.only(
                                  bottom: ScreenUtil.getInstance().setHeight(10.0),
                                ),
                                child: LoadAssetImage("message", width: 30.0, color: Colours.text_gray,),
                              ),
                              Text("消息",style: new TextStyle(fontSize: 14,color: Colours.mine_icon_text),)
                            ],
                          ),
                          new Column(
                            children: <Widget>[
                              Padding(
                                padding:EdgeInsets.only(
                                  bottom: ScreenUtil.getInstance().setHeight(10.0),
                                ),
                                child: LoadAssetImage("personal_letter", width: 30.0, color: Colours.text_gray,),
                              ),
                              Text("私信",style: new TextStyle(fontSize: 14,color: Colours.mine_icon_text),)
                            ],
                          ),
                          new Column(
                            children: <Widget>[
                              Padding(
                                padding:EdgeInsets.only(
                                  bottom: ScreenUtil.getInstance().setHeight(10.0),
                                ),
                                child: LoadAssetImage("collect", width: 30.0, color: Colours.text_gray,),
                              ),
                              Text("收藏",style: new TextStyle(fontSize: 14,color: Colours.mine_icon_text),)
                            ],
                          )
                        ],
                      )
                  ),
                  Container(
                    color: Colours.bg_gray,
                    child: SizedBox(
                      height: 8,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      '全网搜',
                      style: textStyle,
                    ),
                    onTap: () {

                    },
                  ),
                  Container(
                    padding:EdgeInsets.only(
                      left: ScreenUtil.getInstance().setWidth(35.0),
                      right: ScreenUtil.getInstance().setWidth(35.0),
                    ),
                    child:new Divider(),
                  )
                ],
              )
            )
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}