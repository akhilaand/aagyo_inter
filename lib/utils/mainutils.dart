// Flutter imports:
import 'package:flutter/material.dart';

class MainUtils{

  void goTo(BuildContext context, Widget nextScreen) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => nextScreen,
        ));
}}
