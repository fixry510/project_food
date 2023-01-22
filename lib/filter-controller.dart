import 'package:get/get.dart';
import 'package:project_decision/screens/Home/home-controller.dart';
import 'package:project_decision/screens/models/condition-model.dart';

class FilterController extends GetxController {
  ConditionDetail conditionDetail = defalut;

  bool isCondition() {
    return conditionDetail.isRecommanded ||
        conditionDetail.isSort.active ||
        conditionDetail.catgories.length > 0 ||
        conditionDetail.prices.length > 0 ||
        conditionDetail.ratings.length > 0;
  }

  void setCondition([Function? callback = null]) {
    if (callback != null) {
      conditionDetail = callback();
    } else {
      conditionDetail = this.conditionDetail;
    }
    Get.find<HomeController>().foodsShow = getFoodsWithCondition();
    Get.find<HomeController>().update();
    Get.back();
    print(conditionDetail.toString());
  }

  List getFoodsWithCondition() {
    List foods = [...Get.find<HomeController>().foodsMaster];
    List newFoods = [];
    foods.forEach((food) {
      var priceGo = true;
      var raingsGo = true;
      var catgoriesGo = true;
      for (var price in this.conditionDetail.prices) {
        var lengthPrice = food['price'].toString().length;
        var lengthConditionPrice = price.length;
        if (lengthPrice == lengthConditionPrice) {
          priceGo = true;
          break;
        } else {
          priceGo = false;
        }
      }
      for (var rate in this.conditionDetail.ratings) {
        if (food['foodScore'].toString() == rate) {
          raingsGo = true;
          break;
        } else {
          raingsGo = false;
        }
      }
      for (var cate in this.conditionDetail.catgories) {
        if (cate['catgoryId'] == food['catgoryId']) {
          catgoriesGo = true;
          break;
        } else {
          catgoriesGo = false;
        }
      }
      bool allCorrect = catgoriesGo && raingsGo && priceGo;
      if (allCorrect) {
        newFoods.add(food);
      }
    });
    if (this.conditionDetail.isRecommanded) {
      newFoods = newFoods.where((food) => food['recommended']).toList();
    }
    if (this.conditionDetail.isSort.active) {
      SortDetail sortDetail = this.conditionDetail.isSort;
      switch (sortDetail.sortBy) {
        case "Price":
          if (sortDetail.asc) {
            newFoods.sort((foodA, foodB) {
              return foodA["price"].compareTo(foodB["price"]);
            });
          } else {
            newFoods.sort((foodA, foodB) {
              return foodB["price"].compareTo(foodA["price"]);
            });
          }
          break;
        case "Rating":
          if (sortDetail.asc) {
            newFoods.sort((foodA, foodB) {
              return foodA["foodScore"].compareTo(foodB["foodScore"]);
            });
          } else {
            newFoods.sort((foodA, foodB) {
              return foodB["foodScore"].compareTo(foodA["foodScore"]);
            });
          }
          break;
        case "Food":
          if (sortDetail.asc) {
            newFoods.sort((foodA, foodB) {
              return foodA["foodName"].compareTo(foodB["foodName"]);
            });
          } else {
            newFoods.sort((foodA, foodB) {
              return foodB["foodName"].compareTo(foodA["foodName"]);
            });
          }
          break;
        case "Recommanded":
          if (sortDetail.asc) {
            newFoods.sort((foodA, foodB) {
              return (foodB["recommended"] ? 1 : -1)
                  .compareTo(foodA["recommended"] ? 1 : -1);
            });
          } else {
            newFoods.sort((foodA, foodB) {
              return (foodA["recommended"] ? 1 : -1)
                  .compareTo(foodB["recommended"] ? 1 : -1);
            });
          }
          break;
        default:
      }
    }
    return newFoods;
  }
}
