import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:project_decision/filter-controller.dart';
import 'package:project_decision/main.dart';

class StartController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController animationController;
  ScrollController scrollController = ScrollController();

  var scrollOffset = 0.0.obs;
  var endForestOffset = 0.0.obs;
  var endRamenVal = 0.0.obs;
  var endAll = 0.0.obs;
  var imageNo = 1.obs;
  Timer? timer;
  @override
  void onInit() {
    super.onInit();
    animationController =
        AnimationController(vsync: this, duration: 500.milliseconds);
    scrollController.addListener(scrollListen);
  }

  @override
  void onClose() {
    scrollController.removeListener(scrollListen);
    super.onClose();
  }

  void scrollListen() {
    scrollOffset.value = scrollController.offset;
    if ((scrollOffset.value * 0.43) + 100 >= Get.size.height) {
      if (endForestOffset.value == 0) {
        endForestOffset.value = (scrollOffset.value);
        HapticFeedback.heavyImpact();
        setStartImageCount();
      }
    } else {
      endForestOffset.value = 0;
      timer?.cancel();
    }
  }

  void setStartImageCount() {
    timer = Timer.periodic(1500.milliseconds, (timer) {
      if (imageNo.value < 5) {
        imageNo.value++;
      } else {
        imageNo.value = 1;
      }
    });
  }


  void onGetStart() {
    // Get.offNamed("/home");
    if (!Get.isRegistered<FilterController>()) {
      Get.put(FilterController());
    }
    Future.delayed(200.milliseconds, () {
      Get.toNamed("/home");
    });
  }
}
