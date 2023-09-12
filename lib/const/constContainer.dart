// Flutter imports:
import 'package:flutter/material.dart';

class ConstantContainer extends StatefulWidget {
  final double height;
  final double width;
  final double radiusBorder;
  final double borderWidth;
  final Color borderColor;
  final Color ?color;
  final Widget widget;
  const ConstantContainer({Key? key, required this.height, required this.width, required this.radiusBorder, required this.borderWidth,  this.color, required this.widget, required this.borderColor, }) : super(key: key);

  @override
  State<ConstantContainer> createState() => _ConstantContainerState();
}

class _ConstantContainerState extends State<ConstantContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*widget.height,
      width: MediaQuery.of(context).size.width*widget.width,
      decoration: BoxDecoration(
        color: widget.color,
          borderRadius:BorderRadius.circular(widget.radiusBorder),
          border: Border.all(

              color: widget.borderColor,width: widget.borderWidth)
      ),
      child:widget.widget

    );
  }
}
