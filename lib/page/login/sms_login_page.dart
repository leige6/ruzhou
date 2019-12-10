
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:ruzhou/constant/gaps.dart';
import 'package:ruzhou/constant/styles.dart';
import 'package:ruzhou/router/fluro_navigator.dart';
import 'package:ruzhou/router/login_router.dart';
import 'package:ruzhou/utils/toast.dart';
import 'package:ruzhou/utils/utils.dart';
import 'package:ruzhou/widgets/app_bar.dart';
import 'package:ruzhou/widgets/my_button.dart';
import 'package:ruzhou/widgets/my_text_filed.dart';



/// design/1注册登录/index.html#artboard4
class SMSLoginPage extends StatefulWidget {
  @override
  _SMSLoginPageState createState() => _SMSLoginPageState();
}

class _SMSLoginPageState extends State<SMSLoginPage> {
  
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _vCodeController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool _isClick = false;
  
  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_verify);
    _vCodeController.addListener(_verify);
  }

  void _verify(){
    String name = _phoneController.text;
    String vCode = _vCodeController.text;
    bool isClick = true;
    if (name.isEmpty || name.length < 11) {
      isClick = false;
    }
    if (vCode.isEmpty || vCode.length < 6) {
      isClick = false;
    }
    if (isClick != _isClick){
      setState(() {
        _isClick = isClick;
      });
    }
  }

  void _login(){
    Toast.show("去登录......");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: defaultTargetPlatform == TargetPlatform.iOS ? FormKeyboardActions(
        child: _buildBody(),
      ) : SingleChildScrollView(
        child: _buildBody(),
      )
    );
  }
  
  _buildBody(){
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "验证码登录",
            style: TextStyles.textBold26,
          ),
          Gaps.vGap16,
          MyTextField(
            focusNode: _nodeText1,
            config: Utils.getKeyboardActionsConfig(context, [_nodeText1, _nodeText2]),
            controller: _phoneController,
            maxLength: 11,
            keyboardType: TextInputType.phone,
            hintText: "请输入手机号",
          ),
          Gaps.vGap8,
          MyTextField(
            focusNode: _nodeText2,
            controller: _vCodeController,
            maxLength: 6,
            keyboardType: TextInputType.number,
            hintText: "请输入验证码",
            getVCode: (){
              Toast.show('获取验证码');
              return Future.value(true);
            },
          ),
          Gaps.vGap8,
          Container(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                child: RichText(
                  text: TextSpan(
                    text: '提示：未注册账号的手机号，请先',
                    style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: 14.0),
                    children: <TextSpan>[
                      TextSpan(text: '注册', style: TextStyle(color: Theme.of(context).errorColor)),
                      TextSpan(text: '。'),
                    ],
                  ),
                ),
                onTap: (){
                  NavigatorUtils.push(context, LoginRouter.registerPage);
                },
              )
          ),
          Gaps.vGap15,
          Gaps.vGap10,
          MyButton(
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
          )
        ],
      ),
    );
  }
}
