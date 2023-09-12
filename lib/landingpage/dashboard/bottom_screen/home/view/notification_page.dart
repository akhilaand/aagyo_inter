// Flutter imports:
import 'package:flutter/material.dart';

class Notification_Page extends StatelessWidget {
  const Notification_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text("Notification",style: TextStyle(color: Colors.black),),
      ),
      body: const Center(
        child: Text("Comming soon.."),
      ),
    );
  }
}
