import 'package:flutter/material.dart';

class BuildInRadio extends StatelessWidget {
  late final bool isCheck;
  late final double width;
  late final double height;
    Color? checkColor;

  Color? borderColor;
  Color? centerColor;

  double? borderWidth;
  double? size;

  BuildInRadio({
    required this.isCheck,
    required this.height,
    required this.width,
    this.borderColor,
    this.centerColor,
    this.borderWidth,
    this.size,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
        border: Border.all(
          width: borderWidth ?? 1.5,
          color: borderColor ?? Colors.red
        ),
      ),
      // padding: EdgeInsets.all(1.5),
      child: Center(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 150),
          width: isCheck ? size ?? width - 6 : 0,
          height: isCheck ? size ?? height - 6 : 0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCheck ? centerColor ?? Colors.red : Colors.white,
          ),
        ),
      ),
    );
  }
}
