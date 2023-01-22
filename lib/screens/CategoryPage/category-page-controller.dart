import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:project_decision/screens/Home/home-controller.dart';

class CategoryPageController extends GetxController {
  List foods = [];
  String cateId = "";
  var searchVal = ''.obs;

  @override
  void onInit() {
    super.onInit();
    cateId = Get.arguments['catgoryId'];
    foods = Get.find<HomeController>()
        .foodsMaster
        .where((food) => food['catgoryId'] == cateId)
        .toList();
  }
}
