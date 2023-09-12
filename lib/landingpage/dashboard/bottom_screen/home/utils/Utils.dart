// Flutter imports:
import 'package:flutter/material.dart';

class Utils{

  DialogBox(BuildContext context ,Widget widget){
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: widget,
    ));
  }
   static showbottomSheet(BuildContext context ,Widget widget){
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return widget;
      },
    );
  }
}
