// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_switch/flutter_switch.dart';

class OrderId extends StatefulWidget {
  const OrderId({Key? key}) : super(key: key);

  @override
  State<OrderId> createState() => _OrderIdState();
}

class _OrderIdState extends State<OrderId> {
    bool status = false;
  @override
  Widget build(BuildContext context) {
    return  Container(
        height: MediaQuery.of(context).size.height * 0.28,
    width: MediaQuery.of(context).size.width * 0.8,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(5),
    border: Border.all(color: Colors.grey),
    // color: Colors.red
    ),

    child: FlutterSwitch(
      activeText: "Online",
      inactiveText: "Offline",
      activeColor: Colors.green,

      value: status,
      valueFontSize: 10,
      width: 80,
      height: 30,
      borderRadius: 30.0,
      showOnOff: true,
      onToggle: (val) {
        setState(() {
          status = val;
        });
      },
    ),);
  }
}
