import 'dart:io';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:ruzhou/model/store.dart';
import 'package:ruzhou/router/application.dart';
import 'package:ruzhou/router/routers.dart';

import 'constant/common.dart';
import 'entity/user_entity.dart';
import 'model/login_provider.dart';
import 'model/select_images_model.dart';
import 'model/theme_provider.dart';
import 'model/user_info_model.dart';
import 'package:flustars/flustars.dart' as FlutterStars;


 main() async {
   if (Platform.isAndroid) {
     SystemUiOverlayStyle systemUiOverlayStyle =
     SystemUiOverlayStyle(statusBarColor: Colors.transparent);
     SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
   }
  await FlutterStars.SpUtil.getInstance();
  runApp(RuZhouApp());
}

class RuZhouApp extends StatelessWidget {

  RuZhouApp() {
    final router = Router();
    Routers.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    UserEntity us =FlutterStars.SpUtil.getObj(Constant.user, (v) => UserEntity.fromJson(v));
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider<UserInfoModel>.value(value: UserInfoModel(us)),
        ChangeNotifierProvider<SelectImagesModel>.value(value: SelectImagesModel()),
        ChangeNotifierProvider<ThemeProvider>.value(value: ThemeProvider()),
        ChangeNotifierProvider<LoginProvider>.value(value: LoginProvider())
      ],
      child: OKToast(
          child: Consumer<ThemeProvider>(
              builder: (_, provider, __) {
                return  MaterialApp(
                  debugShowCheckedModeBanner: false,
                  //title: 'Flutter Demo',
                  onGenerateRoute: Application.router.generator,
                  theme: provider.getTheme(),
                  darkTheme: provider.getTheme(isDarkMode: true),
                  localizationsDelegates: [                             //此处
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  supportedLocales: [                                   //此处
                    const Locale('zh','CH'),
                    const Locale('en','US'),
                  ],
                );
              }
          ),
          dismissOtherOnShow: true,//全局设置隐藏之前的属性,这里设置后,每次当你显示新的 toast 时,旧的就会被关闭
          backgroundColor: Colors.black54,
          textPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          radius: 20.0,
          position: ToastPosition.bottom
      ),
    );
  }
}
