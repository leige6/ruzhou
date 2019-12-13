import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';
import 'package:ruzhou/constant/common.dart';
import 'package:flustars/flustars.dart' as FlutterStars;
import 'package:ruzhou/constant/gaps.dart';
import 'package:ruzhou/constant/strings.dart';
import 'package:ruzhou/constant/styles.dart';
import 'package:ruzhou/entity/user_entity.dart';
import 'package:ruzhou/model/login_provider.dart';
import 'package:ruzhou/model/store.dart';
import 'package:ruzhou/model/user_info_model.dart';
import 'package:ruzhou/router/fluro_navigator.dart';
import 'package:ruzhou/router/login_router.dart';
import 'package:ruzhou/router/mine_router.dart';
import 'package:ruzhou/service/user_service.dart';
import 'package:ruzhou/utils/encrypt_utils.dart';
import 'package:ruzhou/utils/toast.dart';
import 'package:ruzhou/utils/utils.dart';
import 'package:ruzhou/widgets/app_bar.dart';
import 'package:ruzhou/widgets/my_button.dart';
import 'package:ruzhou/widgets/my_text_filed.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //定义一个controller
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _identifyCodeController = TextEditingController();
  UserEntity userEntity;
  UserService userService = UserService();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();
  bool _isClick = false;
  String randomStr='';

  @override
  void initState() {
    super.initState();
    //监听输入改变
    _nameController.addListener(_verify);
    _passwordController.addListener(_verify);
    _identifyCodeController.addListener(_verify);
    _nameController.text = FlutterStars.SpUtil.getString(Constant.phone);
  }


  void _verify(){
    String name = _nameController.text;
    String password = _passwordController.text;
    String identifyCode = _identifyCodeController.text;
    bool isClick = true;
    if (name.isEmpty || name.length < 5) {
      isClick = false;
    }
    if (password.isEmpty || password.length < 6) {
      isClick = false;
    }
    if (identifyCode.isEmpty || identifyCode.length < 4) {
      isClick = false;
    }
    /// 状态不一样在刷新，避免重复不必要的setState
    if (isClick != _isClick){
      setState(() {
        _isClick = isClick;
      });
    }
  }

  void _login(){
    String username=_nameController.text.toString();
    String password=_passwordController.text.toString();
    String code=_identifyCodeController.text.toString();
    String encyPass=EncryptUtils.instance.encryptOfAes(password);
    Map<String, String> map = Map();
    map["username"]=username;
    map["password"]=encyPass;
    map["code"]=code;
    map["randomStr"]=randomStr;
    map["grant_type"]="password";
    map["scope"]="server";
    userService.loginByUsername(map, (success) {
       print(success);
       userEntity=success;
       Provider.of<UserInfoModel>(context).setUser(userEntity);
       _saveUserInfo();//保存客户信息
       NavigatorUtils.goBack(context);
       Toast.show(Strings.LOGIN_SUCCESS);
    }, (onFail) {
      print(onFail);
      _identifyCodeController.text='';
      Provider.of<LoginProvider>(context).updateRandomStr();
      Toast.show(onFail);
    });
  }

  _saveUserInfo() async {
    bool res=await FlutterStars.SpUtil.putObject(Constant.user, userEntity);
    print('用户信息放入文件存储结果：${res}');
    /*await FlutterStars.SpUtil.putString(Constant.userName, _nameController.text);
    await FlutterStars.SpUtil.putString(Constant.accessToken, userEntity.accessToken);
    await FlutterStars.SpUtil.putString(Constant.refreshToken, userEntity.refreshToken);
    await FlutterStars.SpUtil.putString(Constant.userName, userEntity.username);
    await FlutterStars.SpUtil.putString(Constant.avatarUrl, userEntity.avatarUrl);*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          isBack: true,
          centerTitle: '密码登录',
          actionName: '验证码登录',
          onPressed: (){
            NavigatorUtils.push(context, LoginRouter.smsLoginPage,replace: true);
          },
        ),
        body: defaultTargetPlatform == TargetPlatform.iOS ? FormKeyboardActions(
          child: _buildBody(),
        ) : SingleChildScrollView(
          child: _buildBody(),
        )
    );
  }

  _buildBody(){
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "密码登录",
            style: TextStyles.textBold26,
          ),
          Gaps.vGap16,
          MyTextField(
            key: const Key('phone'),
            focusNode: _nodeText1,
            controller: _nameController,
            maxLength: 11,
            hintText: "请输入账号",
          ),
          Gaps.vGap8,
          MyTextField(
            key: const Key('password'),
            keyName: 'password',
            focusNode: _nodeText2,
            config: Utils.getKeyboardActionsConfig(context, [_nodeText1, _nodeText2]),
            isInputPwd: true,
            controller: _passwordController,
            maxLength: 16,
            hintText: "请输入密码",
          ),
          Gaps.vGap8,
          Store.connect<LoginProvider>( builder: (ctx, loginProvider, child) {
            randomStr=loginProvider.randomStr;
            return  MyTextField(
              key: const Key('identifyCode'),
              keyName: 'identifyCode',
              focusNode: _nodeText3,
              config: Utils.getKeyboardActionsConfig(context, [_nodeText1, _nodeText2,_nodeText3]),
              isShowCode: true,
              controller: _identifyCodeController,
              maxLength: 4,
              hintText: "请输入验证码",
            );
          }),
          Gaps.vGap10,
          Gaps.vGap15,
          MyButton(
            key: const Key('login'),
            onPressed: _isClick ? _login : null,
            text: "登录",
          ),
          Container(
            height: 40.0,
            alignment: Alignment.centerRight,
            child: GestureDetector(
              child: Text(
                '忘记密码',
                style: Theme.of(context).textTheme.subtitle,
              ),
              onTap: (){
                NavigatorUtils.push(context, LoginRouter.resetPasswordPage);
              },
            ),
          ),
          Gaps.vGap16,
          Container(
              alignment: Alignment.center,
              child: GestureDetector(
                child: Text(
                  '还没账号？快去注册',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor
                  ),
                ),
                onTap: (){
                  NavigatorUtils.push(context, LoginRouter.registerPage);
                },
              )
          )
        ],
      ),
    );
  }
}
