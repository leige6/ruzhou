

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ruzhou/entity/news_entity.dart';

///只有标题的新闻项
class OnlyTitleItem extends StatelessWidget {

  NewsEntity newsEntity;

  OnlyTitleItem(this.newsEntity);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: EdgeInsets.only(
            top:ScreenUtil.getInstance().setHeight(24.0),
            left: ScreenUtil.getInstance().setWidth(20.0),
            right: ScreenUtil.getInstance().setWidth(20.0),
        ),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Colors.white,
                child: new Text(
                    this.newsEntity.title,
                    softWrap: true,//自动换行
                    maxLines: 2, //最大行数
                    overflow: TextOverflow.ellipsis,
                    style: new TextStyle(
                        color:Colors.black,
                        fontSize: ScreenUtil.instance.setSp(35.0), //字体大小
                    )
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top:ScreenUtil.instance.setHeight(10.0)),
                  child:Row(
                      children: <Widget>[
                        this.newsEntity.isTop?Padding(
                                  padding: EdgeInsets.only(
                                      right: ScreenUtil.instance.setWidth(10.0)),
                                  child: Text(
                                    "置顶",
                                    style: TextStyle(
                                        fontSize: ScreenUtil.instance.setSp(23.0),
                                        color: Colors.red,
                                        decorationStyle: TextDecorationStyle.dashed),
                                  ),
                                ): Container(
                                    width: 0,
                                    height: 0
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: ScreenUtil.instance.setWidth(10.0)),
                                  child:  Text(
                                    "${this.newsEntity.from}",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: ScreenUtil.instance.setSp(23.0),
                                      //fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: ScreenUtil.instance.setWidth(10.0)),
                                  child:  Text(
                                    "${this.newsEntity.commentCount}评论",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: ScreenUtil.instance.setSp(23.0),
                                      //fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: ScreenUtil.instance.setWidth(10.0)),
                                  child:  Text(
                                    "${this.newsEntity.time}",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: ScreenUtil.instance.setSp(23.0),
                                      //fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ]
                  ),
              ),
              Padding(
                padding:
                EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(20.0)),
                child: Divider(
                  height: ScreenUtil.getInstance().setHeight(1.0),
                  color: Color(0xffd3d3d3),
                ),
              ),
            ]
        )
    );
  }

}