

import 'package:flutter/cupertino.dart';
import 'package:ruzhou/entity/news_entity.dart';

import 'one_image_item.dart';
import 'only_title_item.dart';

class NewsListView extends StatelessWidget {
  List<NewsEntity> newList;

  NewsListView(this.newList);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: newList.length,
        itemBuilder: (BuildContext context, int index) {
          bool isOneImage=index.isOdd;
          if(isOneImage){
            return OneImageItem(newList[index]);
          }else{
            return OnlyTitleItem(newList[index]);
          }
        });;
  }

}