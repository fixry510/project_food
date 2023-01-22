
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> wrapLoad(fn, [color]) async {
  dynamic val = await Get.showOverlay(
    asyncFunction: fn,
    loadingWidget: Center(
      child: SizedBox(
        width: 25,
        height: 25,
        child: CircularProgressIndicator(
          color: Color(0xffFD7C4F),
        ),
      ),
    ),
    opacityColor: color ?? Colors.transparent,
  );
  return val;
}
