import 'package:flutter/material.dart';

Center noItemWidget() {
  return Center(child: Padding(
    padding: const EdgeInsets.all(20),
    child: Image.asset("assets/core/no_result_found.png",),
  ));
}