

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ruzhou/entity/news_entity.dart';
import 'load_image.dart';

///只有一个图片的标题的新闻项
class OneImageItem extends StatelessWidget {

  NewsEntity newsEntity;

  OneImageItem(this.newsEntity);


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
          children: <Widget>[
            IntrinsicHeight( //IntrinsicHeight可以根据子控件的高度，智能调整自身高度,Row是横向排列，在Row中使用Expanded是填充水平方向的剩余空间，这和ListView的这一特性没有冲突，可以使用。而Column是竖直排列，在Column中使用Expanded是填充竖直方向的剩余空间，这将和ListView的这一特性发生冲突，因为ListView将无法计算自己的子View的高度。
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                      child: Container(
                          color: Colors.white,
                          //alignment: Alignment.centerLeft,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Expanded(
                                  child: Container(
                                    color: Colors.white,
                                    child: new Text(
                                        this.newsEntity.title,
                                        softWrap: true,//自动换行
                                        maxLines: 3, //最大行数
                                        overflow: TextOverflow.ellipsis,
                                        style: new TextStyle(
                                          color:Colors.black,
                                          fontSize: ScreenUtil.instance.setSp(35.0), //字体大小
                                        )
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top:ScreenUtil.instance.setHeight(25.0)),
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

                              ]
                          )
                      ),
                    ),
                    Container(
                      /* padding: EdgeInsets.only(
                      top:ScreenUtil.getInstance().setHeight(6.0),
                    ),*/
                      //padding: EdgeInsets.all(ScreenUtil.instance.setWidth(20.0)),
                        height: ScreenUtil.instance.setHeight(150.0),
                        width:  ScreenUtil.instance.setWidth(200.0),
                        child: LoadImage(newsEntity.imgageUrl,width:200,height: 150,)
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
          ],
        )
    );
  }

}