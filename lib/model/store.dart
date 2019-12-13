
import 'package:provider/provider.dart' show ChangeNotifierProvider, MultiProvider, Consumer, Provider;
import 'package:ruzhou/model/select_images_model.dart';
import 'package:ruzhou/model/theme_provider.dart';
import 'package:ruzhou/model/user_info_model.dart';

import 'login_provider.dart';

class Store {
       //获取值 of(context)  这个会引起页面的整体刷新，如果全局是页面级别的
    static T value<T>(context) {
        return Provider.of<T>(context);
    }

    // 不会引起页面的刷新，只刷新了 Consumer 的部分，极大地缩小你的控件刷新范围
    static Consumer connect<T>({builder, child}) {
        return Consumer<T>(builder: builder, child: child);
    }
}