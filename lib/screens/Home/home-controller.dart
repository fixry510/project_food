import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_decision/dowload-file.dart';
import 'package:project_decision/filter-controller.dart';
import 'package:project_decision/main.dart';

class HomeController extends GetxController {
  ScrollController scrollController = ScrollController();
  GlobalKey globalKeyTextField = GlobalKey();
  GlobalKey globalKeyFilter = GlobalKey();
  StreamSubscription? cateSubscription;
  StreamSubscription? foodSubscription;

  List categoriesData = [];
  List foodsMaster = [];
  List foodsShow = [];

  var isShowMiniImage = true.obs;
  var scrollOffset = 0.0.obs;
  var filterOriginPoint = 0.0.obs;
  var textFieldOriginPoint = 0.0.obs;
  var imageNo = 1.obs;
  var searchFood = ''.obs;

  Timer? timer;

  GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  Future<void> listenDataFromFirebase() async {
    cateSubscription = FirebaseFirestore.instance
        .collection("categories")
        .orderBy("catgoryName")
        .snapshots()
        .listen((event) async {
      categoriesData = [];
      print("Run");
      event.docs.forEach((cateData) {
        final cateInfo = cateData.data();
        categoriesData.add(cateInfo);
      });
      Future.wait([
        ...categoriesData.map((cate) async {
          final file = await downloadFile(cate['imageCatagory']);
          cate['imageFile'] = file;
        }).toList()
      ]).then((value) => update()).catchError((err) => update());
      update();
    });
    foodSubscription = FirebaseFirestore.instance
        .collection("foods")
        .snapshots()
        .listen((event) async {
      foodsMaster = [];
      foodsShow = [];

      event.docs.forEach((food) async {
        final foodData = food.data();
        foodsMaster.add(foodData);
      });
      foodsShow = [...foodsMaster];
      await Future.wait([
        ...foodsShow.map((food) async {
          final file = await downloadFile(food['foodImage']);
          food['imageFile'] = file;
        }).toList()
      ]).then((value) => update()).catchError((err) => update());
      foodsShow = Get.find<FilterController>().getFoodsWithCondition();
      update();
    });
  }

  @override
  void onInit() {
    super.onInit();
    listenDataFromFirebase();
    setStartImageCount();
    scrollController.addListener(scrollListen);
  }

  void scrollListen() {
    scrollOffset.value = scrollController.offset;
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

  @override
  void onClose() {
    super.onClose();
    scrollController.removeListener(scrollListen);
    Get.delete<FilterController>(force: true);
    cateSubscription?.cancel();
  }
}
//   Future<void> insertTest() async {
//     print("START INSERT");
//     for (int i = 0; i < dataInsert.length; i++) {
//       final doc = FirebaseFirestore.instance.collection("categories").doc();
//       await doc.set({
//         "catgoryId": doc.id,
//         "catgoryName": dataInsert[i]['catgoryName'],
//         "description": dataInsert[i]['description'],
//         "imageCatagory": dataInsert[i]['imageCatagory'],
//       });
//       for (int j = 0; j < (dataInsert[i]['foods'] as List).length; j++) {
//         final docFood = FirebaseFirestore.instance.collection("foods").doc();
//         final foodData = (dataInsert[i]['foods'] as List)[j];
//         await docFood.set({
//           "foodId": docFood.id,
//           "catgoryId": doc.id,
//           "foodName": foodData['foodName'],
//           "description": foodData['description'],
//           "price": foodData['price'],
//           "foodImage": foodData['foodImage'],
//           "recommended": foodData['recommended'],
//           "foodScore": foodData['foodScore'],
//         });
//       }
//     }
//     print("END INSERT");
//   }
