import 'package:dio/dio.dart';

import 'package:ruzhou/constant/common.dart';
import 'package:flustars/flustars.dart' as FlutterStars;

var dio;

class HttpUtil {
  // 工厂模式
  static HttpUtil get instance => _getInstance();

  static HttpUtil _httpUtil;

  static HttpUtil _getInstance() {
    if (_httpUtil == null) {
      _httpUtil = HttpUtil();
    }
    return _httpUtil;
  }

  HttpUtil() {
    BaseOptions options = BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 5000,
    );
    dio = new Dio(options);
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      dio.lock();
      String token= FlutterStars.SpUtil.getString(Constant.accessToken,defValue: '');
      if(token.isNotEmpty){
        options.headers[Constant.authorization] ='Bearer ' + token;
      }
      options.headers[Constant.tenantId] = '1';
      options.headers[Constant.contentType] = 'application/json';
      dio.unlock();
      print("========================请求数据===================");
      print("url=${options.uri.toString()}");
      print("params=${options.data}");
      print("headers=${options.headers.toString()}");
      return options;
    }, onResponse: (Response response) {
      print("========================请求数据===================");
      print("code=${response.statusCode}");
      print("response=${response.data}");
    }, onError: (DioError error) {
      print("========================请求错误===================");
      Response response=error.response;
      print("message =${response.toString()}");
    }));
  }

  Future get(String url,
      {Map<String, dynamic> parameters, Options options}) async {
    Response response;
    if (parameters != null && options != null) {
      response =
          await dio.get(url, queryParameters: parameters, options: options);
    } else if (parameters != null && options == null) {
      response = await dio.get(url, queryParameters: parameters);
    } else if (parameters == null && options != null) {
      response = await dio.get(url, options: options);
    } else {
      response = await dio.get(url);
    }
    return response.data;
  }

  Future post(String url,
      {Map<String, dynamic> parameters, Options options}) async {
    Response response;
    if (parameters != null && options != null) {
      response = await dio.post(url, data: parameters, options: options);
    } else if (parameters != null && options == null) {
      response = await dio.post(url, data: parameters);
    } else if (parameters == null && options != null) {
      response = await dio.post(url, options: options);
    } else {
      response = await dio.post(url);
    }
    return response.data;
  }
}
