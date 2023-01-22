import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_decision/load-wrap.dart';
import 'package:project_decision/screens/Home/home-controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:dio/dio.dart' as dio;

class AddFoodController extends GetxController {
  List categories = [];
  Map? currentSelectCate = null;
  var errorCateSelect = ''.obs;

  final foodNameController = TextEditingController();
  var errorFoodName = ''.obs;

  final priceController = TextEditingController();
  var errorPrice = ''.obs;

  final descriptionController = TextEditingController();
  var errorDescription = ''.obs;

  File? file;
  var errorImage = ''.obs;

  int ratingNumber = 1;
  bool isRecommanded = false;

  Future<void> selectImageFood() async {
    Future.delayed(500.milliseconds, () {
      errorImage.value = '';
    });
    var imageSelect =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageSelect != null) {
      file = File(imageSelect.path);
      update();
    }
  }

  bool isAllValid() {
    bool isValid = true;
    if (file == null) {
      errorImage.value = 'Please select image.';
      isValid = false;
    }
    if (currentSelectCate == null) {
      errorCateSelect.value = 'Please specify category.';
      isValid = false;
    }
    if (foodNameController.text.isEmpty) {
      errorFoodName.value = "Food name cannot empty.";
      isValid = false;
    }
    if (priceController.text.isEmpty) {
      errorPrice.value = "Price cannot empty.";
      isValid = false;
    }
    if (descriptionController.text.isEmpty) {
      errorDescription.value = "Description cannot empty.";
      isValid = false;
    }
    return isValid;
  }


  Future<void> addFoodHandler() async {
    if (isAllValid()) {
      final foodDoc = FirebaseFirestore.instance.collection("foods").doc();
      await wrapLoad(() async {
        final uploadTask = await FirebaseStorage.instance
            .ref("foods_image/${foodDoc.id}")
            .putFile(file!);
        await foodDoc.set({
          "catgoryId": currentSelectCate!['catgoryId'],
          "foodId": foodDoc.id,
          "foodName": foodNameController.text,
          "description": descriptionController.text,
          "foodScore": ratingNumber,
          "price": num.parse(priceController.text.replaceAll(",", "")),
          "recommended": isRecommanded,
          "foodImage": await uploadTask.ref.getDownloadURL()
        });
      }, Colors.black45);
      Get.back();
    }
  }

  @override
  void onInit() {
    super.onInit();
    categories = Get.find<HomeController>().categoriesData;
  }
}
