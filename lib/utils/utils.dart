import 'package:device_id/device_id.dart';
import 'package:flutter/cupertino.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:ruzhou/utils/theme_utils.dart';
import 'package:uuid/uuid.dart';

class Utils {

  static KeyboardActionsConfig getKeyboardActionsConfig(BuildContext context, List<FocusNode> list){
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: ThemeUtils.getKeyboardActionsColor(context),
      nextFocus: true,
      actions: List.generate(list.length, (i) => KeyboardAction(
        focusNode: list[i],
        closeWidget: const Padding(
          padding: const EdgeInsets.all(5.0),
          child: const Text("关闭"),
        ),
      )),
    );
  }

  static String generateUUID() {
    var uuid = Uuid().v1();
    return uuid.toString();
  }


  static Future<String> getDeviceInfo(int type) async{
    switch(type){
      case 0:
        String device_id = await DeviceId.getID;
        return device_id;
      case 1:
        String imei = await DeviceId.getIMEI;
        return imei;
      case 2:
        String meid = await DeviceId.getMEID;
        return meid;
    }
  }
}