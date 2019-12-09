import 'package:flutter/cupertino.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class Utils {
  static KeyboardActionsConfig getKeyboardActionsConfig(BuildContext context, List<FocusNode> list){
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      //keyboardBarColor: ThemeUtils.getKeyboardActionsColor(context),
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

  static KeyboardActionsConfig getKeyboardActions(BuildContext context, List<FocusNode> list){
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      //keyboardBarColor: ThemeUtils.getKeyboardActionsColor(context),
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
}