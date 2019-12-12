import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ruzhou/api/api.dart';
import 'package:ruzhou/constant/common.dart';
import 'package:ruzhou/constant/strings.dart';
import 'package:ruzhou/entity/result.dart';
import 'package:ruzhou/entity/user_entity.dart';
import 'package:ruzhou/utils/http_util.dart';

typedef OnSuccess<T>(T data);

typedef OnFail(String message);

class UserService {
  Future register(Map<String, String> parameters, OnSuccess onSuccess,
      OnFail onFail) async {
    try {
      var response =
          await HttpUtil.instance.post(Api.REGISTER, parameters: parameters);
      if (response['errno'] == 0) {
        onSuccess("");
      } else {
        onFail(Strings.LOGOUT_FAIL);
      }
    } catch (e) {
      print(e);
      onFail(Strings.SERVER_EXCEPTION);
    }
  }

  Future loginByUsername(Map<String, dynamic> parameters, OnSuccess onSuccess,
      OnFail onFail) async {
    try {
      //设置请求头
      Options options = Options();
      options.headers[Constant.authorization] = 'Basic cGlnOnBpZw==';
      var response =
          await HttpUtil.instance.get(Api.LOGIN_BY_USERNAME, parameters: parameters,options:options);
        UserEntity userEntity = UserEntity.fromJson(response);
        onSuccess(userEntity);
    } catch (e) {
      Result res=Result.fromJson(e.response.toString());
      onFail(res.msg);
    }
  }

  Future loginOut(OnSuccess onSuccess, OnFail onFail) async {
    try {
      var response = await HttpUtil.instance.post(Api.LOGOUT);
      var data=response['data'];
      if (data.code == 0) {
        onSuccess(Strings.LOGOUT_SUCCESS);
      } else {
        onFail(Strings.LOGOUT_FAIL);
      }
    } catch (e) {
      print(e);
      onFail(Strings.SERVER_EXCEPTION);
    }
  }
}
