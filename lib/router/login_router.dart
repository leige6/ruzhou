import 'package:fluro/fluro.dart';
import 'package:ruzhou/page/login/login_page.dart';
import 'package:ruzhou/page/login/register_page.dart';
import 'package:ruzhou/page/login/reset_password_page.dart';
import 'package:ruzhou/page/login/sms_login_page.dart';
import 'package:ruzhou/page/mine/mine_page.dart';
import 'package:ruzhou/page/mine/service_agree_page.dart';
import 'package:ruzhou/router/router_init.dart';


class LoginRouter implements IRouterProvider{

  static String login = "/login";
  static String registerPage = "/login/register";
  static String smsLoginPage = "/login/smsLogin";
  static String resetPasswordPage = "/login/resetPassword";
  static String updatePasswordPage = "/login/updatePassword";


  @override
  void initRouter(Router router) {
    router.define(login, handler: Handler(handlerFunc: (_, params) => LoginPage()));
    router.define(smsLoginPage, handler: Handler(handlerFunc: (_, params) => SMSLoginPage()));
    router.define(registerPage, handler: Handler(handlerFunc: (_, params) => RegisterPage()));
    router.define(resetPasswordPage, handler: Handler(handlerFunc: (_, params) => ResetPasswordPage()));
  }

}