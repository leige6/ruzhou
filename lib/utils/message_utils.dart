
import 'dart:io';

//import 'package:jstomp/jstomp.dart';

class MessageUtils {
  /*JStomp stomp;

  String _initState = "";
  String _connectionState = "";
  String _subscriberState = "";
  String _content = "";
  String _sendContent = "";
  String url = "ws://192.168.137.1:15674/ws";
  String sendUrl= "/groupMessage/sendMessage";*/

  /*void _initStateChanged(String str) {
      _initState = str;
  }

  void _connectionStateChanged(String state) {
      _connectionState = state;
  }

  void _messageStateChanged(String msg) {
      _content = msg;
  }

  void _sendStateChanged(String send) {
      _sendContent = send;
  }

  ///
  ///初始化并连接stomp
  ///
  Future _initStomp() async {
    if (stomp == null) {
      stomp = JStomp.instance;
    }
    bool b = await stomp.init(url: url, sendUrl: sendUrl);
    _initStateChanged(b ? "初始化成功" : "初始化失败");

    if (b) {
      ///打开连接
      await stomp.connection((open) async {
        print("连接打开了...$open");
        _connectionStateChanged("Stomp连接打开了...");
        ///订阅点对点通道
        final String p2pUrl = "/microGroupMessage/";
        bool b = await stomp.subscribP2P([p2pUrl]);
        if (b) {
            _subscriberState = "通道订阅完成：" + p2pUrl;
        }
      }, onError: (error) {
        print("连接打开错误了...$error");
        _connectionStateChanged("Stomp连接出错了：$error");
      }, onClosed: (closed) {
        print("连接打开错误了...$closed");
        _connectionStateChanged("Stomp连接关闭了...");
      });
    }

    ///添加消息回调
    await stomp.onMessageCallback((message) {
      print("收到p2p新消息：" + message.toString());
      _messageStateChanged("收到p2p新消息：" + message.toString());
    }, onBroadCast: (cast) {
      print("收到新广播消息：" + cast.toString());
      _messageStateChanged("收到广播新消息：" + cast.toString());
    });

    ///添加发送回调
    await stomp.onSendCallback((status, sendMsg) {
      print("消息发送完毕：$status :msg=" + sendMsg.toString());
      _sendStateChanged("发送了一条消息：$status :msg=" + sendMsg.toString());
    });

  }

  ///
  /// 发送消息
  ///
  Future<String> _sendMsg(String JsonMsg) async {
    Map<String, dynamic> head = {
      "userId": "p123456",
      "token": "MgjkjkdIdkkDkkjkfdjfdkjfk",
    };
    return await stomp.sendMessage(JsonMsg, header: head);
  }

  ///
  /// 断开连接，销毁资源
  ///
  Future<bool> _destroyStomp() async {
    if (stomp == null) {
      return true;
    }
    bool b = await stomp.destroy();
    stomp = null;
    return b;
  }*/

}
