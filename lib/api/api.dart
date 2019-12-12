class Api {
  static const String BASE_URL = 'http://10.90.60.41:9999';
  static const String REFRESH_CODE=BASE_URL+'/code?randomStr=';//刷新验证码
  static const String REGISTER=BASE_URL+'/register';//用户注册
  static const String LOGIN_BY_USERNAME=BASE_URL+'/auth/oauth/token';//用户名登陆
  static const String LOGOUT=BASE_URL+'/auth/token/logout';//用户退出
}
