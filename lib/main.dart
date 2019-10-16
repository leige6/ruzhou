import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:ruzhou/router/application.dart';
import 'package:ruzhou/router/routers.dart';

void main() => runApp(RuZhouApp());

class RuZhouApp extends StatelessWidget {

  RuZhouApp() {
    final router = Router();
    Routers.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title: 'Flutter Demo',
      onGenerateRoute: Application.router.generator,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      )
    );
  }
}
