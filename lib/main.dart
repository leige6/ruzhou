import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ruzhou/model/store.dart';
import 'package:ruzhou/router/application.dart';
import 'package:ruzhou/router/routers.dart';

void main() {
  runApp(RuZhouApp());
 if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class RuZhouApp extends StatelessWidget {

  RuZhouApp() {
    final router = Router();
    Routers.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return  Store.init(
        context: context, //以这个为准
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          //title: 'Flutter Demo',
          onGenerateRoute: Application.router.generator,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          localizationsDelegates: [                             //此处
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [                                   //此处
            const Locale('zh','CH'),
            const Locale('en','US'),
          ],
        )
    );
  }
}
