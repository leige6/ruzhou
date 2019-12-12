import 'package:encrypt/encrypt.dart';

var encrypter;
var iv;
class EncryptUtils {

  // 工厂模式
  static EncryptUtils get instance => _getInstance();

  static EncryptUtils _encryptUtils;

  static EncryptUtils _getInstance() {
    if (_encryptUtils == null) {
      _encryptUtils = EncryptUtils();
    }
    return _encryptUtils;
  }

  EncryptUtils(){
    String password = 'pigxpigxpigxpigx';
     var key = Key.fromUtf8(password);
     encrypter = Encrypter(AES(key, mode:AESMode.cbc));
     iv =IV.fromUtf8(password);
  }

  String encryptOfAes(String data){
    return encrypter.encrypt(data, iv: iv).base64;
  }

   String decryptOfAes(String data){
    return  encrypter.decrypt64(data, iv: iv).toString();
  }

}