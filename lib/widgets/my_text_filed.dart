

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:ruzhou/utils/utils.dart';

class MyTextField extends StatefulWidget {

  const MyTextField({
    Key key,
    @required this.controller,
    this.focusNode,
    this.config,
  }): super(key: key);

  final TextEditingController controller;
  final FocusNode focusNode;
  final KeyboardActionsConfig config;

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //widget.controller?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.iOS){
      // 因Android平台输入法兼容问题，所以只配置IOS平台
      FormKeyboardActions.setKeyboardActions(context, widget.config);
    }
    return TextField(
        focusNode: widget.focusNode,
        controller: widget.controller,
        maxLines: 6,
        maxLength: 1000,
        decoration: InputDecoration(
          hintText: '这一刻你的想法...',
          contentPadding: EdgeInsets.only(left: 10,top: 2),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide.none),
        ),
      );
  }
}